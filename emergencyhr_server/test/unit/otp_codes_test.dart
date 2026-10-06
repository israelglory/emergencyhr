import 'package:emergencyhr_server/src/features/auth/otp_codes.dart';
import 'package:test/test.dart';

void main() {
  group('Given OtpCodes', () {
    test('when generating then the code has 6 digits', () {
      for (var i = 0; i < 50; i++) {
        expect(OtpCodes.generate(), matches(RegExp(r'^\d{6}$')));
      }
    });

    test('when hashing the same code for two phones then hashes differ', () {
      final a = OtpCodes.hash('123456', '+2348031234567', 'pepper');
      final b = OtpCodes.hash('123456', '+2348031234568', 'pepper');
      expect(a, isNot(b));
    });

    test('when comparing equal hashes then they match', () {
      final a = OtpCodes.hash('123456', '+2348031234567', 'pepper');
      expect(OtpCodes.matches(a, a), isTrue);
      expect(OtpCodes.matches(a, a.replaceRange(0, 1, 'x')), isFalse);
    });
  });
}
