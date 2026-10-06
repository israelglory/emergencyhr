import 'package:emergencyhr_server/src/core/validation.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('Given Validate.phone', () {
    for (final (input, expected) in [
      ('08031234567', '+2348031234567'),
      ('8031234567', '+2348031234567'),
      ('2348031234567', '+2348031234567'),
      ('+234 803 123 4567', '+2348031234567'),
      ('+447700900123', '+447700900123'),
    ]) {
      test('when given "$input" then normalises to $expected', () {
        expect(Validate.phone(input), expected);
      });
    }

    for (final input in ['', '123', '0603123456', '+2340031234567', 'abc']) {
      test('when given "$input" then throws a validation error', () {
        expect(
          () => Validate.phone(input),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.code,
              'code',
              AppErrorCode.validation,
            ),
          ),
        );
      });
    }
  });

  group('Given Validate.coordinates', () {
    test('when in range then passes', () {
      expect(() => Validate.coordinates(6.6, 3.35), returnsNormally);
    });

    test('when latitude is out of range then throws', () {
      expect(
        () => Validate.coordinates(91, 3.35),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Given Validate.count', () {
    test('when negative then throws', () {
      expect(
        () => Validate.count(-1, field: 'erBedsFree'),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
