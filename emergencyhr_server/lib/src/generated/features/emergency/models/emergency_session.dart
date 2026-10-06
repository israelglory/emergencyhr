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
import '../../../features/emergency/models/emergency_action.dart' as _i479lbe3;
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// One use of the Emergency flow. startedAt to actedAt is the north star metric.
abstract class EmergencySession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EmergencySession._({
    this.id,
    this.userId,
    this.accessTokenHash,
    required this.lat,
    required this.lng,
    this.area,
    required this.emergencyType,
    required this.resultsShown,
    bool? emptyResult,
    required this.action,
    this.facilityId,
    required this.startedAt,
    this.actedAt,
  }) : emptyResult = emptyResult ?? false;

  factory EmergencySession({
    int? id,
    int? userId,
    String? accessTokenHash,
    required double lat,
    required double lng,
    String? area,
    required _iurmpi7d.EmergencyType emergencyType,
    required List<int> resultsShown,
    bool? emptyResult,
    required _i479lbe3.EmergencyAction action,
    int? facilityId,
    required DateTime startedAt,
    DateTime? actedAt,
  }) = _EmergencySessionImpl;

  factory EmergencySession.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencySession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      accessTokenHash: jsonSerialization['accessTokenHash'] as String?,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      area: jsonSerialization['area'] as String?,
      emergencyType: _iurmpi7d.EmergencyType.fromJson(
        (jsonSerialization['emergencyType'] as String),
      ),
      resultsShown: _ilvcm0hz.Protocol().deserialize<List<int>>(
        jsonSerialization['resultsShown'],
      ),
      emptyResult: jsonSerialization['emptyResult'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['emptyResult']),
      action: _i479lbe3.EmergencyAction.fromJson(
        (jsonSerialization['action'] as String),
      ),
      facilityId: jsonSerialization['facilityId'] as int?,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      actedAt: jsonSerialization['actedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['actedAt']),
    );
  }

  static final t = EmergencySessionTable();

  static const db = EmergencySessionRepository._();

  @override
  int? id;

  int? userId;

  /// Lets a guest update their own session without an account.
  String? accessTokenHash;

  double lat;

  double lng;

  String? area;

  _iurmpi7d.EmergencyType emergencyType;

  List<int> resultsShown;

  bool emptyResult;

  _i479lbe3.EmergencyAction action;

  int? facilityId;

  DateTime startedAt;

  DateTime? actedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EmergencySession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmergencySession copyWith({
    int? id,
    int? userId,
    String? accessTokenHash,
    double? lat,
    double? lng,
    String? area,
    _iurmpi7d.EmergencyType? emergencyType,
    List<int>? resultsShown,
    bool? emptyResult,
    _i479lbe3.EmergencyAction? action,
    int? facilityId,
    DateTime? startedAt,
    DateTime? actedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencySession',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (accessTokenHash != null) 'accessTokenHash': accessTokenHash,
      'lat': lat,
      'lng': lng,
      if (area != null) 'area': area,
      'emergencyType': emergencyType.toJson(),
      'resultsShown': resultsShown.toJson(),
      'emptyResult': emptyResult,
      'action': action.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'startedAt': startedAt.toJson(),
      if (actedAt != null) 'actedAt': actedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencySession',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'lat': lat,
      'lng': lng,
      if (area != null) 'area': area,
      'emergencyType': emergencyType.toJson(),
      'resultsShown': resultsShown.toJson(),
      'emptyResult': emptyResult,
      'action': action.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'startedAt': startedAt.toJson(),
      if (actedAt != null) 'actedAt': actedAt?.toJson(),
    };
  }

  static EmergencySessionInclude include() {
    return EmergencySessionInclude._();
  }

  static EmergencySessionIncludeList includeList({
    _is.WhereExpressionBuilder<EmergencySessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    EmergencySessionInclude? include,
  }) {
    return EmergencySessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencySessionImpl extends EmergencySession {
  _EmergencySessionImpl({
    int? id,
    int? userId,
    String? accessTokenHash,
    required double lat,
    required double lng,
    String? area,
    required _iurmpi7d.EmergencyType emergencyType,
    required List<int> resultsShown,
    bool? emptyResult,
    required _i479lbe3.EmergencyAction action,
    int? facilityId,
    required DateTime startedAt,
    DateTime? actedAt,
  }) : super._(
         id: id,
         userId: userId,
         accessTokenHash: accessTokenHash,
         lat: lat,
         lng: lng,
         area: area,
         emergencyType: emergencyType,
         resultsShown: resultsShown,
         emptyResult: emptyResult,
         action: action,
         facilityId: facilityId,
         startedAt: startedAt,
         actedAt: actedAt,
       );

  /// Returns a shallow copy of this [EmergencySession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmergencySession copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? accessTokenHash = _Undefined,
    double? lat,
    double? lng,
    Object? area = _Undefined,
    _iurmpi7d.EmergencyType? emergencyType,
    List<int>? resultsShown,
    bool? emptyResult,
    _i479lbe3.EmergencyAction? action,
    Object? facilityId = _Undefined,
    DateTime? startedAt,
    Object? actedAt = _Undefined,
  }) {
    return EmergencySession(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      accessTokenHash: accessTokenHash is String?
          ? accessTokenHash
          : this.accessTokenHash,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      area: area is String? ? area : this.area,
      emergencyType: emergencyType ?? this.emergencyType,
      resultsShown: resultsShown ?? this.resultsShown.map((e0) => e0).toList(),
      emptyResult: emptyResult ?? this.emptyResult,
      action: action ?? this.action,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      startedAt: startedAt ?? this.startedAt,
      actedAt: actedAt is DateTime? ? actedAt : this.actedAt,
    );
  }
}

class EmergencySessionUpdateTable
    extends _is.UpdateTable<EmergencySessionTable> {
  EmergencySessionUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int? value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> accessTokenHash(String? value) =>
      _is.ColumnValue(
        table.accessTokenHash,
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

  _is.ColumnValue<String, String> area(String? value) => _is.ColumnValue(
    table.area,
    value,
  );

  _is.ColumnValue<_iurmpi7d.EmergencyType, _iurmpi7d.EmergencyType>
  emergencyType(_iurmpi7d.EmergencyType value) => _is.ColumnValue(
    table.emergencyType,
    value,
  );

  _is.ColumnValue<List<int>, List<int>> resultsShown(List<int> value) =>
      _is.ColumnValue(
        table.resultsShown,
        value,
      );

  _is.ColumnValue<bool, bool> emptyResult(bool value) => _is.ColumnValue(
    table.emptyResult,
    value,
  );

  _is.ColumnValue<_i479lbe3.EmergencyAction, _i479lbe3.EmergencyAction> action(
    _i479lbe3.EmergencyAction value,
  ) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<int, int> facilityId(int? value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> actedAt(DateTime? value) =>
      _is.ColumnValue(
        table.actedAt,
        value,
      );
}

class EmergencySessionTable extends _is.Table<int?> {
  EmergencySessionTable({super.tableRelation})
    : super(tableName: 'emergency_session') {
    updateTable = EmergencySessionUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    accessTokenHash = _is.ColumnString(
      'accessTokenHash',
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
    area = _is.ColumnString(
      'area',
      this,
    );
    emergencyType = _is.ColumnEnum(
      'emergencyType',
      this,
      _is.EnumSerialization.byName,
    );
    resultsShown = _is.ColumnSerializable<List<int>>(
      'resultsShown',
      this,
    );
    emptyResult = _is.ColumnBool(
      'emptyResult',
      this,
      hasDefault: true,
    );
    action = _is.ColumnEnum(
      'action',
      this,
      _is.EnumSerialization.byName,
    );
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    actedAt = _is.ColumnDateTime(
      'actedAt',
      this,
    );
  }

  late final EmergencySessionUpdateTable updateTable;

  late final _is.ColumnInt userId;

  /// Lets a guest update their own session without an account.
  late final _is.ColumnString accessTokenHash;

  late final _is.ColumnDouble lat;

  late final _is.ColumnDouble lng;

  late final _is.ColumnString area;

  late final _is.ColumnEnum<_iurmpi7d.EmergencyType> emergencyType;

  late final _is.ColumnSerializable<List<int>> resultsShown;

  late final _is.ColumnBool emptyResult;

  late final _is.ColumnEnum<_i479lbe3.EmergencyAction> action;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime actedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    accessTokenHash,
    lat,
    lng,
    area,
    emergencyType,
    resultsShown,
    emptyResult,
    action,
    facilityId,
    startedAt,
    actedAt,
  ];
}

class EmergencySessionInclude extends _is.IncludeObject {
  EmergencySessionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EmergencySession.t;
}

class EmergencySessionIncludeList extends _is.IncludeList {
  EmergencySessionIncludeList._({
    _is.WhereExpressionBuilder<EmergencySessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmergencySession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EmergencySession.t;
}

class EmergencySessionRepository {
  const EmergencySessionRepository._();

  /// Returns a list of [EmergencySession]s matching the given query parameters.
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
  Future<List<EmergencySession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencySessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmergencySession>(
      where: where?.call(EmergencySession.t),
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmergencySession] matching the given query parameters.
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
  Future<EmergencySession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencySessionTable>? where,
    int? offset,
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmergencySession>(
      where: where?.call(EmergencySession.t),
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmergencySession] by its [id] or null if no such row exists.
  Future<EmergencySession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmergencySession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmergencySession]s in the list and returns the inserted rows.
  ///
  /// The returned [EmergencySession]s will have their `id` fields set.
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
  Future<List<EmergencySession>> insert(
    _is.DatabaseSession session,
    List<EmergencySession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EmergencySession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EmergencySession] and returns the inserted row.
  ///
  /// The returned [EmergencySession] will have its `id` field set.
  Future<EmergencySession> insertRow(
    _is.DatabaseSession session,
    EmergencySession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmergencySession>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EmergencySession]s in the list and returns the resulting rows.
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
  /// The returned [EmergencySession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencySession>> upsert(
    _is.DatabaseSession session,
    List<EmergencySession> rows, {
    required _is.ColumnSelections<EmergencySessionTable> conflictColumns,
    _is.ColumnSelections<EmergencySessionTable>? updateColumns,
    _is.WhereExpressionBuilder<EmergencySessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EmergencySession>(
      rows,
      conflictColumns: conflictColumns(EmergencySession.t),
      updateColumns: updateColumns?.call(EmergencySession.t),
      updateWhere: updateWhere?.call(EmergencySession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EmergencySession] and returns the resulting row.
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
  /// The returned [EmergencySession] will have its `id` field set.
  Future<EmergencySession?> upsertRow(
    _is.DatabaseSession session,
    EmergencySession row, {
    required _is.ColumnSelections<EmergencySessionTable> conflictColumns,
    _is.ColumnSelections<EmergencySessionTable>? updateColumns,
    _is.WhereExpressionBuilder<EmergencySessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EmergencySession>(
      row,
      conflictColumns: conflictColumns(EmergencySession.t),
      updateColumns: updateColumns?.call(EmergencySession.t),
      updateWhere: updateWhere?.call(EmergencySession.t),
      transaction: transaction,
    );
  }

  /// Updates all [EmergencySession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencySession>> update(
    _is.DatabaseSession session,
    List<EmergencySession> rows, {
    _is.ColumnSelections<EmergencySessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EmergencySession>(
      rows,
      columns: columns?.call(EmergencySession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EmergencySession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmergencySession> updateRow(
    _is.DatabaseSession session,
    EmergencySession row, {
    _is.ColumnSelections<EmergencySessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmergencySession>(
      row,
      columns: columns?.call(EmergencySession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmergencySession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmergencySession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EmergencySessionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EmergencySession>(
      id,
      columnValues: columnValues(EmergencySession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmergencySession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencySession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmergencySessionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EmergencySessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EmergencySession>(
      columnValues: columnValues(EmergencySession.t.updateTable),
      where: where(EmergencySession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EmergencySession]s in the list and returns the deleted rows.
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
  Future<List<EmergencySession>> delete(
    _is.DatabaseSession session,
    List<EmergencySession> rows, {
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EmergencySession>(
      rows,
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EmergencySession].
  Future<EmergencySession> deleteRow(
    _is.DatabaseSession session,
    EmergencySession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmergencySession>(
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
  Future<List<EmergencySession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmergencySessionTable> where,
    _is.OrderByBuilder<EmergencySessionTable>? orderBy,
    _is.OrderByListBuilder<EmergencySessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EmergencySession>(
      where: where(EmergencySession.t),
      orderBy: orderBy?.call(EmergencySession.t),
      orderByList: orderByList?.call(EmergencySession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencySessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EmergencySession>(
      where: where?.call(EmergencySession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmergencySession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmergencySessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmergencySession>(
      where: where(EmergencySession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
