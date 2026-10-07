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
import 'package:emergencyhr_server/src/generated/protocol.dart' as _ilvcm0hz;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/facilities/models/facility_source.dart' as _i33gs98b;
import '../../../features/facilities/models/facility_type.dart' as _ieko45br;
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;
import '../../../features/facilities/models/opening_hours.dart' as _iy9wan3d;
import '../../../features/facilities/models/verification_status.dart'
    as _ipq8k6fl;

abstract class Facility
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Facility._({
    this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
    this.deskPhone,
    this.deskPhoneConfirmedAt,
    this.contactName,
    this.contactPhone,
    required this.verificationStatus,
    required this.onboardingStage,
    required this.source,
    this.sourceRef,
    this.liveAt,
    this.openingHours,
    this.trainingCompletedAt,
    this.flaggedAt,
    this.suspendedAt,
    this.suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Facility({
    int? id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    required _ipq8k6fl.VerificationStatus verificationStatus,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _i33gs98b.FacilitySource source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FacilityImpl;

  factory Facility.fromJson(Map<String, dynamic> jsonSerialization) {
    return Facility(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: _ieko45br.FacilityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      deskPhone: jsonSerialization['deskPhone'] as String?,
      deskPhoneConfirmedAt: jsonSerialization['deskPhoneConfirmedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['deskPhoneConfirmedAt'],
            ),
      contactName: jsonSerialization['contactName'] as String?,
      contactPhone: jsonSerialization['contactPhone'] as String?,
      verificationStatus: _ipq8k6fl.VerificationStatus.fromJson(
        (jsonSerialization['verificationStatus'] as String),
      ),
      onboardingStage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['onboardingStage'] as String),
      ),
      source: _i33gs98b.FacilitySource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      sourceRef: jsonSerialization['sourceRef'] as String?,
      liveAt: jsonSerialization['liveAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['liveAt']),
      openingHours: jsonSerialization['openingHours'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_iy9wan3d.OpeningHours>(
              jsonSerialization['openingHours'],
            ),
      trainingCompletedAt: jsonSerialization['trainingCompletedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['trainingCompletedAt'],
            ),
      flaggedAt: jsonSerialization['flaggedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['flaggedAt']),
      suspendedAt: jsonSerialization['suspendedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedAt'],
            ),
      suspendReason: jsonSerialization['suspendReason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FacilityTable();

  static const db = FacilityRepository._();

  @override
  int? id;

  String name;

  _ieko45br.FacilityType type;

  String address;

  /// Pilot area name, e.g. "Ikeja".
  String area;

  double lat;

  double lng;

  String? deskPhone;

  DateTime? deskPhoneConfirmedAt;

  String? contactName;

  String? contactPhone;

  _ipq8k6fl.VerificationStatus verificationStatus;

  _ibrba1hx.OnboardingStage onboardingStage;

  _i33gs98b.FacilitySource source;

  /// Where an imported listing came from, e.g. "grid3-nga-v2:<id>". Lets
  /// the same file be imported again without creating duplicates.
  String? sourceRef;

  DateTime? liveAt;

  _iy9wan3d.OpeningHours? openingHours;

  DateTime? trainingCompletedAt;

  /// Set when three wrong-status reports arrive within 24 hours.
  DateTime? flaggedAt;

  DateTime? suspendedAt;

  String? suspendReason;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Facility copyWith({
    int? id,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    _ipq8k6fl.VerificationStatus? verificationStatus,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _i33gs98b.FacilitySource? source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (deskPhoneConfirmedAt != null)
        'deskPhoneConfirmedAt': deskPhoneConfirmedAt?.toJson(),
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      'verificationStatus': verificationStatus.toJson(),
      'onboardingStage': onboardingStage.toJson(),
      'source': source.toJson(),
      if (sourceRef != null) 'sourceRef': sourceRef,
      if (liveAt != null) 'liveAt': liveAt?.toJson(),
      if (openingHours != null) 'openingHours': openingHours?.toJson(),
      if (trainingCompletedAt != null)
        'trainingCompletedAt': trainingCompletedAt?.toJson(),
      if (flaggedAt != null) 'flaggedAt': flaggedAt?.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (deskPhoneConfirmedAt != null)
        'deskPhoneConfirmedAt': deskPhoneConfirmedAt?.toJson(),
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      'verificationStatus': verificationStatus.toJson(),
      'onboardingStage': onboardingStage.toJson(),
      'source': source.toJson(),
      if (sourceRef != null) 'sourceRef': sourceRef,
      if (liveAt != null) 'liveAt': liveAt?.toJson(),
      if (openingHours != null)
        'openingHours': openingHours?.toJsonForProtocol(),
      if (trainingCompletedAt != null)
        'trainingCompletedAt': trainingCompletedAt?.toJson(),
      if (flaggedAt != null) 'flaggedAt': flaggedAt?.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FacilityInclude include() {
    return FacilityInclude._();
  }

  static FacilityIncludeList includeList({
    _is.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    FacilityInclude? include,
  }) {
    return FacilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityImpl extends Facility {
  _FacilityImpl({
    int? id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    required _ipq8k6fl.VerificationStatus verificationStatus,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _i33gs98b.FacilitySource source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         type: type,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
         deskPhone: deskPhone,
         deskPhoneConfirmedAt: deskPhoneConfirmedAt,
         contactName: contactName,
         contactPhone: contactPhone,
         verificationStatus: verificationStatus,
         onboardingStage: onboardingStage,
         source: source,
         sourceRef: sourceRef,
         liveAt: liveAt,
         openingHours: openingHours,
         trainingCompletedAt: trainingCompletedAt,
         flaggedAt: flaggedAt,
         suspendedAt: suspendedAt,
         suspendReason: suspendReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Facility copyWith({
    Object? id = _Undefined,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    Object? deskPhone = _Undefined,
    Object? deskPhoneConfirmedAt = _Undefined,
    Object? contactName = _Undefined,
    Object? contactPhone = _Undefined,
    _ipq8k6fl.VerificationStatus? verificationStatus,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _i33gs98b.FacilitySource? source,
    Object? sourceRef = _Undefined,
    Object? liveAt = _Undefined,
    Object? openingHours = _Undefined,
    Object? trainingCompletedAt = _Undefined,
    Object? flaggedAt = _Undefined,
    Object? suspendedAt = _Undefined,
    Object? suspendReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Facility(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deskPhone: deskPhone is String? ? deskPhone : this.deskPhone,
      deskPhoneConfirmedAt: deskPhoneConfirmedAt is DateTime?
          ? deskPhoneConfirmedAt
          : this.deskPhoneConfirmedAt,
      contactName: contactName is String? ? contactName : this.contactName,
      contactPhone: contactPhone is String? ? contactPhone : this.contactPhone,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      onboardingStage: onboardingStage ?? this.onboardingStage,
      source: source ?? this.source,
      sourceRef: sourceRef is String? ? sourceRef : this.sourceRef,
      liveAt: liveAt is DateTime? ? liveAt : this.liveAt,
      openingHours: openingHours is _iy9wan3d.OpeningHours?
          ? openingHours
          : this.openingHours?.copyWith(),
      trainingCompletedAt: trainingCompletedAt is DateTime?
          ? trainingCompletedAt
          : this.trainingCompletedAt,
      flaggedAt: flaggedAt is DateTime? ? flaggedAt : this.flaggedAt,
      suspendedAt: suspendedAt is DateTime? ? suspendedAt : this.suspendedAt,
      suspendReason: suspendReason is String?
          ? suspendReason
          : this.suspendReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FacilityUpdateTable extends _is.UpdateTable<FacilityTable> {
  FacilityUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_ieko45br.FacilityType, _ieko45br.FacilityType> type(
    _ieko45br.FacilityType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<String, String> area(String value) => _is.ColumnValue(
    table.area,
    value,
  );

  _is.ColumnValue<double, double> lat(double value) => _is.ColumnValue(
    table.lat,
    value,
  );

  _is.ColumnValue<double, double> lng(double value) => _is.ColumnValue(
    table.lng,
    value,
  );

  _is.ColumnValue<String, String> deskPhone(String? value) => _is.ColumnValue(
    table.deskPhone,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> deskPhoneConfirmedAt(DateTime? value) =>
      _is.ColumnValue(
        table.deskPhoneConfirmedAt,
        value,
      );

  _is.ColumnValue<String, String> contactName(String? value) => _is.ColumnValue(
    table.contactName,
    value,
  );

  _is.ColumnValue<String, String> contactPhone(String? value) =>
      _is.ColumnValue(
        table.contactPhone,
        value,
      );

  _is.ColumnValue<_ipq8k6fl.VerificationStatus, _ipq8k6fl.VerificationStatus>
  verificationStatus(_ipq8k6fl.VerificationStatus value) => _is.ColumnValue(
    table.verificationStatus,
    value,
  );

  _is.ColumnValue<_ibrba1hx.OnboardingStage, _ibrba1hx.OnboardingStage>
  onboardingStage(_ibrba1hx.OnboardingStage value) => _is.ColumnValue(
    table.onboardingStage,
    value,
  );

  _is.ColumnValue<_i33gs98b.FacilitySource, _i33gs98b.FacilitySource> source(
    _i33gs98b.FacilitySource value,
  ) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> sourceRef(String? value) => _is.ColumnValue(
    table.sourceRef,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> liveAt(DateTime? value) =>
      _is.ColumnValue(
        table.liveAt,
        value,
      );

  _is.ColumnValue<_iy9wan3d.OpeningHours, _iy9wan3d.OpeningHours> openingHours(
    _iy9wan3d.OpeningHours? value,
  ) => _is.ColumnValue(
    table.openingHours,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> trainingCompletedAt(DateTime? value) =>
      _is.ColumnValue(
        table.trainingCompletedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> flaggedAt(DateTime? value) =>
      _is.ColumnValue(
        table.flaggedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> suspendedAt(DateTime? value) =>
      _is.ColumnValue(
        table.suspendedAt,
        value,
      );

  _is.ColumnValue<String, String> suspendReason(String? value) =>
      _is.ColumnValue(
        table.suspendReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class FacilityTable extends _is.Table<int?> {
  FacilityTable({super.tableRelation}) : super(tableName: 'facility') {
    updateTable = FacilityUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    area = _is.ColumnString(
      'area',
      this,
    );
    lat = _is.ColumnDouble(
      'lat',
      this,
    );
    lng = _is.ColumnDouble(
      'lng',
      this,
    );
    deskPhone = _is.ColumnString(
      'deskPhone',
      this,
    );
    deskPhoneConfirmedAt = _is.ColumnDateTime(
      'deskPhoneConfirmedAt',
      this,
    );
    contactName = _is.ColumnString(
      'contactName',
      this,
    );
    contactPhone = _is.ColumnString(
      'contactPhone',
      this,
    );
    verificationStatus = _is.ColumnEnum(
      'verificationStatus',
      this,
      _is.EnumSerialization.byName,
    );
    onboardingStage = _is.ColumnEnum(
      'onboardingStage',
      this,
      _is.EnumSerialization.byName,
    );
    source = _is.ColumnEnum(
      'source',
      this,
      _is.EnumSerialization.byName,
    );
    sourceRef = _is.ColumnString(
      'sourceRef',
      this,
    );
    liveAt = _is.ColumnDateTime(
      'liveAt',
      this,
    );
    openingHours = _is.ColumnSerializable<_iy9wan3d.OpeningHours>(
      'openingHours',
      this,
    );
    trainingCompletedAt = _is.ColumnDateTime(
      'trainingCompletedAt',
      this,
    );
    flaggedAt = _is.ColumnDateTime(
      'flaggedAt',
      this,
    );
    suspendedAt = _is.ColumnDateTime(
      'suspendedAt',
      this,
    );
    suspendReason = _is.ColumnString(
      'suspendReason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final FacilityUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_ieko45br.FacilityType> type;

  late final _is.ColumnString address;

  /// Pilot area name, e.g. "Ikeja".
  late final _is.ColumnString area;

  late final _is.ColumnDouble lat;

  late final _is.ColumnDouble lng;

  late final _is.ColumnString deskPhone;

  late final _is.ColumnDateTime deskPhoneConfirmedAt;

  late final _is.ColumnString contactName;

  late final _is.ColumnString contactPhone;

  late final _is.ColumnEnum<_ipq8k6fl.VerificationStatus> verificationStatus;

  late final _is.ColumnEnum<_ibrba1hx.OnboardingStage> onboardingStage;

  late final _is.ColumnEnum<_i33gs98b.FacilitySource> source;

  /// Where an imported listing came from, e.g. "grid3-nga-v2:<id>". Lets
  /// the same file be imported again without creating duplicates.
  late final _is.ColumnString sourceRef;

  late final _is.ColumnDateTime liveAt;

  late final _is.ColumnSerializable<_iy9wan3d.OpeningHours> openingHours;

  late final _is.ColumnDateTime trainingCompletedAt;

  /// Set when three wrong-status reports arrive within 24 hours.
  late final _is.ColumnDateTime flaggedAt;

  late final _is.ColumnDateTime suspendedAt;

  late final _is.ColumnString suspendReason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    type,
    address,
    area,
    lat,
    lng,
    deskPhone,
    deskPhoneConfirmedAt,
    contactName,
    contactPhone,
    verificationStatus,
    onboardingStage,
    source,
    sourceRef,
    liveAt,
    openingHours,
    trainingCompletedAt,
    flaggedAt,
    suspendedAt,
    suspendReason,
    createdAt,
    updatedAt,
  ];
}

class FacilityInclude extends _is.IncludeObject {
  FacilityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Facility.t;
}

class FacilityIncludeList extends _is.IncludeList {
  FacilityIncludeList._({
    _is.WhereExpressionBuilder<FacilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Facility.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Facility.t;
}

class FacilityRepository {
  const FacilityRepository._();

  /// Returns a list of [Facility]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Facility>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Facility>(
      where: where?.call(Facility.t),
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Facility] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Facility?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityTable>? where,
    int? offset,
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Facility>(
      where: where?.call(Facility.t),
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Facility] by its [id] or null if no such row exists.
  Future<Facility?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Facility>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Facility]s in the list and returns the inserted rows.
  ///
  /// The returned [Facility]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> insert(
    _is.DatabaseSession session,
    List<Facility> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Facility>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Facility] and returns the inserted row.
  ///
  /// The returned [Facility] will have its `id` field set.
  Future<Facility> insertRow(
    _is.DatabaseSession session,
    Facility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Facility>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Facility]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Facility]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> upsert(
    _is.DatabaseSession session,
    List<Facility> rows, {
    required _is.ColumnSelections<FacilityTable> conflictColumns,
    _is.ColumnSelections<FacilityTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Facility>(
      rows,
      conflictColumns: conflictColumns(Facility.t),
      updateColumns: updateColumns?.call(Facility.t),
      updateWhere: updateWhere?.call(Facility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Facility] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Facility] will have its `id` field set.
  Future<Facility?> upsertRow(
    _is.DatabaseSession session,
    Facility row, {
    required _is.ColumnSelections<FacilityTable> conflictColumns,
    _is.ColumnSelections<FacilityTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Facility>(
      row,
      conflictColumns: conflictColumns(Facility.t),
      updateColumns: updateColumns?.call(Facility.t),
      updateWhere: updateWhere?.call(Facility.t),
      transaction: transaction,
    );
  }

  /// Updates all [Facility]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> update(
    _is.DatabaseSession session,
    List<Facility> rows, {
    _is.ColumnSelections<FacilityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Facility>(
      rows,
      columns: columns?.call(Facility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Facility]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Facility> updateRow(
    _is.DatabaseSession session,
    Facility row, {
    _is.ColumnSelections<FacilityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Facility>(
      row,
      columns: columns?.call(Facility.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Facility] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Facility?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FacilityUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Facility>(
      id,
      columnValues: columnValues(Facility.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Facility]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FacilityUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FacilityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Facility>(
      columnValues: columnValues(Facility.t.updateTable),
      where: where(Facility.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Facility]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> delete(
    _is.DatabaseSession session,
    List<Facility> rows, {
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Facility>(
      rows,
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Facility].
  Future<Facility> deleteRow(
    _is.DatabaseSession session,
    Facility row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Facility>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Facility>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityTable> where,
    _is.OrderByBuilder<FacilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Facility>(
      where: where(Facility.t),
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Facility>(
      where: where?.call(Facility.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Facility] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Facility>(
      where: where(Facility.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
