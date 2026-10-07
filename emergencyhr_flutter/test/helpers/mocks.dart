import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/api/api_response.dart';
import 'package:emergencyhr_flutter/data/api/assistant_api.dart';
import 'package:emergencyhr_flutter/data/api/auth_api.dart';
import 'package:emergencyhr_flutter/data/api/emergency_api.dart';
import 'package:emergencyhr_flutter/data/api/facility_api.dart';
import 'package:emergencyhr_flutter/data/api/profile_api.dart';
import 'package:emergencyhr_flutter/data/api/status_api.dart';
import 'package:emergencyhr_flutter/data/local/emergency_cache.dart';
import 'package:emergencyhr_flutter/data/local/intro_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApi extends Mock implements AuthApi {}

class MockStatusApi extends Mock implements StatusApi {}

class MockFacilityApi extends Mock implements FacilityApi {}

class MockEmergencyApi extends Mock implements EmergencyApi {}

class MockAssistantApi extends Mock implements AssistantApi {}

class MockProfileApi extends Mock implements ProfileApi {}

class MockEmergencyCache extends Mock implements EmergencyCache {}

class MockNavigationService extends Mock implements NavigationService {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockDialogService extends Mock implements DialogService {}

class MockBottomSheetService extends Mock implements BottomSheetService {}

class MockLauncherService extends Mock implements LauncherService {}

class MockPhoneCallService extends Mock implements PhoneCallService {}

class MockLocationService extends Mock implements LocationService {}

class MockSessionService extends Mock implements SessionService {}

class MockFirstAidService extends Mock implements FirstAidService {}

class MockIntroStorage extends Mock implements IntroStorage {}

final now = DateTime.utc(2026, 10, 6, 12);

/// Registers fallbacks mocktail needs for `any()` on these types.
void registerFallbacks() {
  registerFallbackValue(
    StatusInput(
      accepting: true,
      erBedsFree: 0,
      icuBedsFree: 0,
      doctorOnDuty: true,
      depositRequired: false,
    ),
  );
  registerFallbackValue(EmergencyAction.none);
  registerFallbackValue(
    UuidValue.fromString('00000000-0000-7000-8000-000000000000'),
  );
  registerFallbackValue(EmergencyType.skipped);
  registerFallbackValue(searchFixture());
}

Facility facilityFixture({
  int id = 1,
  OnboardingStage stage = OnboardingStage.live,
  DateTime? trainingCompletedAt,
}) => Facility(
  id: id,
  name: 'Seed Hospital 0$id, Ikeja',
  type: FacilityType.private,
  address: '$id Seed Road',
  area: 'Ikeja',
  lat: 6.6,
  lng: 3.35,
  deskPhone: '+2348100000001',
  verificationStatus: VerificationStatus.verified,
  onboardingStage: stage,
  source: FacilitySource.seeded,
  trainingCompletedAt: trainingCompletedAt ?? now,
);

FacilityStatus statusFixture({int minutesAgo = 5, bool accepting = true}) =>
    FacilityStatus(
      id: 1,
      facilityId: 1,
      accepting: accepting,
      erBedsFree: 3,
      icuBedsFree: 1,
      doctorOnDuty: true,
      depositRequired: false,
      updatedAt: now.subtract(Duration(minutes: minutesAgo)),
    );

FacilityDetail detailFixture({
  FacilityStatus? status,
  OnboardingStage stage = OnboardingStage.live,
  bool trained = true,
}) => FacilityDetail(
  facility: facilityFixture(
    stage: stage,
    trainingCompletedAt: trained ? now : null,
  ),
  capabilities: [Capability.trauma],
  status: status,
  checklist: GoLiveChecklist(facilityId: 1, items: [], complete: true),
  documents: [],
);

EmergencyResult resultFixture({
  int id = 1,
  String name = 'Seed Trauma Centre',
  int tier = 1,
  FreshnessTier freshness = FreshnessTier.fresh,
  int minutesAgo = 4,
  bool flagged = false,
  String? phone = '+2348100000001',
  List<Capability> capabilities = const [Capability.trauma],
}) => EmergencyResult(
  facilityId: id,
  name: name,
  address: '$id Seed Road',
  area: 'Ikeja',
  lat: 6.6,
  lng: 3.35,
  deskPhone: phone,
  distanceKm: 2.4,
  etaMinutes: 9,
  rankTier: tier,
  freshness: freshness,
  statusUpdatedAt: now.subtract(Duration(minutes: minutesAgo)),
  erBedsFree: 3,
  icuBedsFree: 1,
  doctorOnDuty: true,
  depositRequired: false,
  capabilities: capabilities,
  match: CapabilityMatch.full,
  flagged: flagged,
);

EmergencySearch searchFixture({
  List<EmergencyResult>? results,
  bool call112 = false,
  EmergencyType type = EmergencyType.roadAccident,
}) => EmergencySearch(
  sessionId: 10,
  accessToken: 'token',
  emergencyType: type,
  radiusKm: 10,
  results: results ?? [resultFixture()],
  showCall112: call112,
  computedAt: now,
);

ApiResponse<T> ok<T>(T data) => ApiResponse.ok(data);
ApiResponse<T> failed<T>(String message, {bool offline = false}) =>
    ApiResponse.failure(message: message, offline: offline);

/// A stream that never emits, standing in for the live results socket.
Stream<T> silentStream<T>() => StreamController<T>().stream;
