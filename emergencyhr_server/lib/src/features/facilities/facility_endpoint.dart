import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import 'facility_service.dart';

class FacilityEndpoint extends Endpoint {
  static const _facilities = FacilityService();

  /// Search listings by name. Who may call: anyone.
  Future<List<FacilitySearchResult>> search(
    Session session,
    String query, {
    String? area,
  }) {
    return _facilities.search(
      session,
      query: Validate.text(query, field: 'query', max: 80),
      area: area,
    );
  }

  /// Listings within 300 m of the agent. Who may call: field agents, admins.
  Future<List<FacilitySearchResult>> nearby(
    Session session,
    double lat,
    double lng,
  ) async {
    await AuthGuard.requireRole(session, {
      UserRole.fieldAgent,
      UserRole.platformAdmin,
    });
    Validate.coordinates(lat, lng);
    return _facilities.nearby(session, lat: lat, lng: lng);
  }

  /// Who may call: any signed-in user.
  Future<List<DuplicateCandidate>> findDuplicates(
    Session session,
    String name,
    double lat,
    double lng,
  ) async {
    await AuthGuard.requireUser(session);
    Validate.coordinates(lat, lng);
    return _facilities.findDuplicates(
      session,
      name: Validate.text(name, field: 'name', max: 120),
      lat: lat,
      lng: lng,
    );
  }

  /// Creates a listing. Field agents create agent listings, platform admins
  /// create directory listings, anyone else creates a self-serve listing and
  /// becomes its hospital admin. Who may call: any signed-in user.
  Future<Facility> create(Session session, FacilityProfileInput input) async {
    final user = await AuthGuard.requireUser(session);
    final source = await AuthGuard.hasRole(session, user, {UserRole.fieldAgent})
        ? FacilitySource.fieldAgent
        : await AuthGuard.hasRole(session, user, {UserRole.platformAdmin})
        ? FacilitySource.seeded
        : FacilitySource.selfSignup;
    return _facilities.create(
      session,
      input: input,
      actor: user,
      source: source,
    );
  }

  /// Who may call: the facility's hospital admin, assigned field agent,
  /// platform admins.
  Future<Facility> updateProfile(
    Session session,
    int facilityId,
    FacilityProfileInput input,
  ) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    final facility = await _facilities.require(session, facilityId);
    return _facilities.updateProfile(
      session,
      facility: facility,
      input: input,
      actor: user,
    );
  }

  /// Who may call: the facility's staff, assigned agent, platform admins.
  Future<FacilityDetail> detail(Session session, int facilityId) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.staffAndManagers,
      facilityId: facilityId,
    );
    final facility = await _facilities.require(session, facilityId);
    return _facilities.detail(session, facility);
  }
}
