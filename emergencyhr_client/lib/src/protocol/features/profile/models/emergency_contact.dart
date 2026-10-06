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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../features/profile/models/contact_channel.dart' as _iid3hpvd;

abstract class EmergencyContact
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmergencyContact._({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.channel,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EmergencyContact({
    int? id,
    required int userId,
    required String name,
    required String phone,
    required _iid3hpvd.ContactChannel channel,
    DateTime? createdAt,
  }) = _EmergencyContactImpl;

  factory EmergencyContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyContact(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      channel: _iid3hpvd.ContactChannel.fromJson(
        (jsonSerialization['channel'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  String phone;

  _iid3hpvd.ContactChannel channel;

  DateTime createdAt;

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmergencyContact copyWith({
    int? id,
    int? userId,
    String? name,
    String? phone,
    _iid3hpvd.ContactChannel? channel,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencyContact',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'channel': channel.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencyContact',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'channel': channel.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyContactImpl extends EmergencyContact {
  _EmergencyContactImpl({
    int? id,
    required int userId,
    required String name,
    required String phone,
    required _iid3hpvd.ContactChannel channel,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         phone: phone,
         channel: channel,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmergencyContact copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? phone,
    _iid3hpvd.ContactChannel? channel,
    DateTime? createdAt,
  }) {
    return EmergencyContact(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
