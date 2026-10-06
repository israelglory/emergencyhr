import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/data/models/freshness.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 10, 6, 12);

  group('Given Freshness.tierAt', () {
    test('when a fresh status ages past 30 min then it becomes stale', () {
      expect(
        Freshness.tierAt(
          serverTier: FreshnessTier.fresh,
          updatedAt: now.subtract(const Duration(minutes: 31)),
          now: now,
        ),
        FreshnessTier.stale,
      );
    });

    test('when it ages past 120 min then it is never shown as accepting', () {
      expect(
        Freshness.tierAt(
          serverTier: FreshnessTier.fresh,
          updatedAt: now.subtract(const Duration(minutes: 121)),
          now: now,
        ),
        FreshnessTier.unverified,
      );
    });

    test('when the server says unverified then it never upgrades', () {
      expect(
        Freshness.tierAt(
          serverTier: FreshnessTier.unverified,
          updatedAt: now,
          now: now,
        ),
        FreshnessTier.unverified,
      );
    });
  });

  group('Given Freshness.label', () {
    test('when fresh then says accepting and confirmed age', () {
      expect(
        Freshness.label(
          FreshnessTier.fresh,
          now.subtract(const Duration(minutes: 4)),
          now,
        ),
        'Accepting emergencies. Confirmed 4 min ago.',
      );
    });

    test('when stale then says call ahead', () {
      expect(
        Freshness.label(
          FreshnessTier.stale,
          now.subtract(const Duration(minutes: 45)),
          now,
        ),
        'Last confirmed 45 min ago. Call ahead.',
      );
    });

    test('when unverified then says call before going', () {
      expect(
        Freshness.label(FreshnessTier.unverified, null, now),
        'Unverified. Call before going.',
      );
    });
  });
}
