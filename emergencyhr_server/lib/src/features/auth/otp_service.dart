import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import '../notifications/messaging.dart';
import 'otp_codes.dart';

/// Issues and checks one-time codes sent by SMS. Rate limited per phone and
/// per IP address.
class OtpService {
  OtpService();

  final _perPhone = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'otp',
      source: 'phone',
      maxAttempts: 5,
      timeframe: const Duration(hours: 1),
    ),
  );

  final _perIp = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'otp',
      source: 'ip',
      maxAttempts: 20,
      timeframe: const Duration(hours: 1),
    ),
  );

  static String pepper(Session session) {
    final value = session.passwords['otpHashPepper'];
    if (value == null || value.isEmpty) {
      throw StateError('otpHashPepper is missing from config/passwords.yaml');
    }
    return value;
  }

  Future<OtpRequestResult> request(
    Session session, {
    required String phone,
    required OtpPurpose purpose,
  }) async {
    final now = clock.now();
    final latest = await OtpChallenge.db.findFirstRow(
      session,
      where: (t) => t.phone.equals(phone) & t.purpose.equals(purpose),
      orderBy: (t) => t.createdAt.desc(),
    );
    if (latest != null &&
        latest.consumedAt == null &&
        now.difference(latest.createdAt) < OtpCodes.resendCooldown) {
      final wait = OtpCodes.resendCooldown - now.difference(latest.createdAt);
      throw Errors.rateLimited(retryAfterSeconds: wait.inSeconds + 1);
    }

    final ip = session.request?.connectionInfo.remote.address.toString();
    if (!await _perPhone.tryRecordAttempt(session, key: phone) ||
        (ip != null && !await _perIp.tryRecordAttempt(session, key: ip))) {
      throw Errors.rateLimited(retryAfterSeconds: 3600);
    }

    final code = OtpCodes.generate();
    final expiresAt = now.add(OtpCodes.ttl);
    await OtpChallenge.db.insertRow(
      session,
      OtpChallenge(
        phone: phone,
        purpose: purpose,
        codeHash: OtpCodes.hash(code, phone, pepper(session)),
        expiresAt: expiresAt,
        createdAt: now,
      ),
    );

    await Messaging.sms(session).send(
      session,
      to: phone,
      message:
          '$code is your Emergencyhr code. It expires in 5 minutes. '
          'Do not share it.',
    );

    return OtpRequestResult(
      phone: phone,
      expiresAt: expiresAt,
      codeLength: OtpCodes.length,
      resendAvailableAt: now.add(OtpCodes.resendCooldown),
    );
  }

  /// Consumes the latest code for [phone] or throws a typed error.
  Future<void> verify(
    Session session, {
    required String phone,
    required OtpPurpose purpose,
    required String code,
    Transaction? transaction,
  }) async {
    final now = clock.now();
    final challenge = await OtpChallenge.db.findFirstRow(
      session,
      where: (t) =>
          t.phone.equals(phone) &
          t.purpose.equals(purpose) &
          t.consumedAt.equals(null),
      orderBy: (t) => t.createdAt.desc(),
      transaction: transaction,
    );
    if (challenge == null || !challenge.expiresAt.isAfter(now)) {
      throw InvalidStateException(
        code: AppErrorCode.otpExpired,
        message: 'This code has expired. Request a new one.',
      );
    }
    if (challenge.attempts >= OtpCodes.maxAttempts) {
      throw InvalidStateException(
        code: AppErrorCode.otpInvalid,
        message: 'Too many wrong codes. Request a new one.',
      );
    }

    final expected = OtpCodes.hash(code.trim(), phone, pepper(session));
    if (!OtpCodes.matches(expected, challenge.codeHash)) {
      await OtpChallenge.db.updateRow(
        session,
        challenge.copyWith(attempts: challenge.attempts + 1),
        transaction: transaction,
      );
      throw InvalidStateException(
        code: AppErrorCode.otpInvalid,
        message: 'That code is not correct.',
      );
    }

    await OtpChallenge.db.updateRow(
      session,
      challenge.copyWith(consumedAt: now),
      transaction: transaction,
    );
  }
}
