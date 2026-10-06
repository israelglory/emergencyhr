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
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/profile/models/contact_channel.dart' as _iid3hpvd;

abstract class ContactAlertResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ContactAlertResult._({
    required this.name,
    required this.phone,
    this.sentVia,
  });

  factory ContactAlertResult({
    required String name,
    required String phone,
    _iid3hpvd.ContactChannel? sentVia,
  }) = _ContactAlertResultImpl;

  factory ContactAlertResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContactAlertResult(
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      sentVia: jsonSerialization['sentVia'] == null
          ? null
          : _iid3hpvd.ContactChannel.fromJson(
              (jsonSerialization['sentVia'] as String),
            ),
    );
  }

  String name;

  String phone;

  /// Null when sending failed; the app then offers the phone's SMS app.
  _iid3hpvd.ContactChannel? sentVia;

  /// Returns a shallow copy of this [ContactAlertResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ContactAlertResult copyWith({
    String? name,
    String? phone,
    _iid3hpvd.ContactChannel? sentVia,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContactAlertResult',
      'name': name,
      'phone': phone,
      if (sentVia != null) 'sentVia': sentVia?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContactAlertResult',
      'name': name,
      'phone': phone,
      if (sentVia != null) 'sentVia': sentVia?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactAlertResultImpl extends ContactAlertResult {
  _ContactAlertResultImpl({
    required String name,
    required String phone,
    _iid3hpvd.ContactChannel? sentVia,
  }) : super._(
         name: name,
         phone: phone,
         sentVia: sentVia,
       );

  /// Returns a shallow copy of this [ContactAlertResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ContactAlertResult copyWith({
    String? name,
    String? phone,
    Object? sentVia = _Undefined,
  }) {
    return ContactAlertResult(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      sentVia: sentVia is _iid3hpvd.ContactChannel? ? sentVia : this.sentVia,
    );
  }
}
