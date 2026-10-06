import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:serverpod/serverpod.dart';

/// Field-level encryption for health data and chat history (AES-256-GCM).
/// The key is `dataEncryptionKey` in passwords.yaml: 32 random bytes, base64.
class FieldCrypto {
  FieldCrypto(List<int> key) : _key = SecretKey(key);

  final SecretKey _key;
  static final _algorithm = AesGcm.with256bits();
  static const _prefix = 'v1:';

  factory FieldCrypto.fromSession(Session session) {
    final encoded = session.passwords['dataEncryptionKey'];
    if (encoded == null || encoded.isEmpty) {
      throw StateError('dataEncryptionKey is missing from passwords.yaml');
    }
    final key = base64Decode(encoded);
    if (key.length != 32) {
      throw StateError('dataEncryptionKey must be 32 bytes, base64 encoded');
    }
    return FieldCrypto(key);
  }

  Future<String> encrypt(String plain) async {
    final box = await _algorithm.encrypt(utf8.encode(plain), secretKey: _key);
    return '$_prefix${base64Encode(box.concatenation())}';
  }

  Future<String?> encryptOptional(String? plain) async =>
      plain == null || plain.isEmpty ? null : encrypt(plain);

  Future<String> decrypt(String sealed) async {
    if (!sealed.startsWith(_prefix)) throw const FormatException('Unknown');
    final box = SecretBox.fromConcatenation(
      base64Decode(sealed.substring(_prefix.length)),
      nonceLength: _algorithm.nonceLength,
      macLength: _algorithm.macAlgorithm.macLength,
    );
    return utf8.decode(await _algorithm.decrypt(box, secretKey: _key));
  }

  Future<String?> decryptOptional(String? sealed) async =>
      sealed == null ? null : decrypt(sealed);
}
