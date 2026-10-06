/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:emergencyhr_client/src/protocol/protocol.dart' as _ivwsyfsq;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../features/onboarding/models/facility_invite.dart' as _iwz3vzai;

/// Returned once when an invite is created. The link holds the secret token
/// and is never shown again.
abstract class InviteCreated
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InviteCreated._({
    required this.invite,
    required this.link,
  });

  factory InviteCreated({
    required _iwz3vzai.FacilityInvite invite,
    required String link,
  }) = _InviteCreatedImpl;

  factory InviteCreated.fromJson(Map<String, dynamic> jsonSerialization) {
    return InviteCreated(
      invite: _ivwsyfsq.Protocol().deserialize<_iwz3vzai.FacilityInvite>(
        jsonSerialization['invite'],
      ),
      link: jsonSerialization['link'] as String,
    );
  }

  _iwz3vzai.FacilityInvite invite;

  String link;

  /// Returns a shallow copy of this [InviteCreated]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InviteCreated copyWith({
    _iwz3vzai.FacilityInvite? invite,
    String? link,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InviteCreated',
      'invite': invite.toJson(),
      'link': link,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InviteCreated',
      'invite': invite.toJsonForProtocol(),
      'link': link,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InviteCreatedImpl extends InviteCreated {
  _InviteCreatedImpl({
    required _iwz3vzai.FacilityInvite invite,
    required String link,
  }) : super._(
         invite: invite,
         link: link,
       );

  /// Returns a shallow copy of this [InviteCreated]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InviteCreated copyWith({
    _iwz3vzai.FacilityInvite? invite,
    String? link,
  }) {
    return InviteCreated(
      invite: invite ?? this.invite.copyWith(),
      link: link ?? this.link,
    );
  }
}
