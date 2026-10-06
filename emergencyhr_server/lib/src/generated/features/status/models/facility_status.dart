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

/// Live availability, set only by verified staff of the facility.
abstract class FacilityStatus
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FacilityStatus._({
    this.id,
    required this.facilityId,
    required this.accepting,
    required this.erBedsFree,
    required this.icuBedsFree,
    required this.doctorOnDuty,
    required this.depositRequired,
    this.updatedByUserId,
    required this.updatedAt,
  });

  factory FacilityStatus({
    int? id,
    required int facilityId,
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
    int? updatedByUserId,
    required DateTime updatedAt,
  }) = _FacilityStatusImpl;

  factory FacilityStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityStatus(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      accepting: _is.BoolJsonExtension.fromJson(jsonSerialization['accepting']),
      erBedsFree: jsonSerialization['erBedsFree'] as int,
      icuBedsFree: jsonSerialization['icuBedsFree'] as int,
      doctorOnDuty: _is.BoolJsonExtension.fromJson(
        jsonSerialization['doctorOnDuty'],
      ),
      depositRequired: _is.BoolJsonExtension.fromJson(
        jsonSerialization['depositRequired'],
      ),
      updatedByUserId: jsonSerialization['updatedByUserId'] as int?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FacilityStatusTable();

  static const db = FacilityStatusRepository._();

  @override
  int? id;

  int facilityId;

  bool accepting;

  int erBedsFree;

  int icuBedsFree;

  bool doctorOnDuty;

  bool depositRequired;

  int? updatedByUserId;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FacilityStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityStatus copyWith({
    int? id,
    int? facilityId,
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    int? updatedByUserId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityStatus',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityStatus',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FacilityStatusInclude include() {
    return FacilityStatusInclude._();
  }

  static FacilityStatusIncludeList includeList({
    _is.WhereExpressionBuilder<FacilityStatusTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    FacilityStatusInclude? include,
  }) {
    return FacilityStatusIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityStatusImpl extends FacilityStatus {
  _FacilityStatusImpl({
    int? id,
    required int facilityId,
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
    int? updatedByUserId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         accepting: accepting,
         erBedsFree: erBedsFree,
         icuBedsFree: icuBedsFree,
         doctorOnDuty: doctorOnDuty,
         depositRequired: depositRequired,
         updatedByUserId: updatedByUserId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FacilityStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityStatus copyWith({
    Object? id = _Undefined,
    int? facilityId,
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    Object? updatedByUserId = _Undefined,
    DateTime? updatedAt,
  }) {
    return FacilityStatus(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      accepting: accepting ?? this.accepting,
      erBedsFree: erBedsFree ?? this.erBedsFree,
      icuBedsFree: icuBedsFree ?? this.icuBedsFree,
      doctorOnDuty: doctorOnDuty ?? this.doctorOnDuty,
      depositRequired: depositRequired ?? this.depositRequired,
      updatedByUserId: updatedByUserId is int?
          ? updatedByUserId
          : this.updatedByUserId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FacilityStatusUpdateTable extends _is.UpdateTable<FacilityStatusTable> {
  FacilityStatusUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<bool, bool> accepting(bool value) => _is.ColumnValue(
    table.accepting,
    value,
  );

  _is.ColumnValue<int, int> erBedsFree(int value) => _is.ColumnValue(
    table.erBedsFree,
    value,
  );

  _is.ColumnValue<int, int> icuBedsFree(int value) => _is.ColumnValue(
    table.icuBedsFree,
    value,
  );

  _is.ColumnValue<bool, bool> doctorOnDuty(bool value) => _is.ColumnValue(
    table.doctorOnDuty,
    value,
  );

  _is.ColumnValue<bool, bool> depositRequired(bool value) => _is.ColumnValue(
    table.depositRequired,
    value,
  );

  _is.ColumnValue<int, int> updatedByUserId(int? value) => _is.ColumnValue(
    table.updatedByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class FacilityStatusTable extends _is.Table<int?> {
  FacilityStatusTable({super.tableRelation})
    : super(tableName: 'facility_status') {
    updateTable = FacilityStatusUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    accepting = _is.ColumnBool(
      'accepting',
      this,
    );
    erBedsFree = _is.ColumnInt(
      'erBedsFree',
      this,
    );
    icuBedsFree = _is.ColumnInt(
      'icuBedsFree',
      this,
    );
    doctorOnDuty = _is.ColumnBool(
      'doctorOnDuty',
      this,
    );
    depositRequired = _is.ColumnBool(
      'depositRequired',
      this,
    );
    updatedByUserId = _is.ColumnInt(
      'updatedByUserId',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final FacilityStatusUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnBool accepting;

  late final _is.ColumnInt erBedsFree;

  late final _is.ColumnInt icuBedsFree;

  late final _is.ColumnBool doctorOnDuty;

  late final _is.ColumnBool depositRequired;

  late final _is.ColumnInt updatedByUserId;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    accepting,
    erBedsFree,
    icuBedsFree,
    doctorOnDuty,
    depositRequired,
    updatedByUserId,
    updatedAt,
  ];
}

class FacilityStatusInclude extends _is.IncludeObject {
  FacilityStatusInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FacilityStatus.t;
}

class FacilityStatusIncludeList extends _is.IncludeList {
  FacilityStatusIncludeList._({
    _is.WhereExpressionBuilder<FacilityStatusTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FacilityStatus.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FacilityStatus.t;
}

class FacilityStatusRepository {
  const FacilityStatusRepository._();

  /// Returns a list of [FacilityStatus]s matching the given query parameters.
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
  Future<List<FacilityStatus>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityStatusTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FacilityStatus>(
      where: where?.call(FacilityStatus.t),
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FacilityStatus] matching the given query parameters.
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
  Future<FacilityStatus?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityStatusTable>? where,
    int? offset,
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FacilityStatus>(
      where: where?.call(FacilityStatus.t),
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FacilityStatus] by its [id] or null if no such row exists.
  Future<FacilityStatus?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FacilityStatus>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FacilityStatus]s in the list and returns the inserted rows.
  ///
  /// The returned [FacilityStatus]s will have their `id` fields set.
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
  Future<List<FacilityStatus>> insert(
    _is.DatabaseSession session,
    List<FacilityStatus> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FacilityStatus>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FacilityStatus] and returns the inserted row.
  ///
  /// The returned [FacilityStatus] will have its `id` field set.
  Future<FacilityStatus> insertRow(
    _is.DatabaseSession session,
    FacilityStatus row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FacilityStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FacilityStatus]s in the list and returns the resulting rows.
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
  /// The returned [FacilityStatus]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityStatus>> upsert(
    _is.DatabaseSession session,
    List<FacilityStatus> rows, {
    required _is.ColumnSelections<FacilityStatusTable> conflictColumns,
    _is.ColumnSelections<FacilityStatusTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityStatusTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FacilityStatus>(
      rows,
      conflictColumns: conflictColumns(FacilityStatus.t),
      updateColumns: updateColumns?.call(FacilityStatus.t),
      updateWhere: updateWhere?.call(FacilityStatus.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FacilityStatus] and returns the resulting row.
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
  /// The returned [FacilityStatus] will have its `id` field set.
  Future<FacilityStatus?> upsertRow(
    _is.DatabaseSession session,
    FacilityStatus row, {
    required _is.ColumnSelections<FacilityStatusTable> conflictColumns,
    _is.ColumnSelections<FacilityStatusTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityStatusTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FacilityStatus>(
      row,
      conflictColumns: conflictColumns(FacilityStatus.t),
      updateColumns: updateColumns?.call(FacilityStatus.t),
      updateWhere: updateWhere?.call(FacilityStatus.t),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityStatus]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityStatus>> update(
    _is.DatabaseSession session,
    List<FacilityStatus> rows, {
    _is.ColumnSelections<FacilityStatusTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FacilityStatus>(
      rows,
      columns: columns?.call(FacilityStatus.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FacilityStatus]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FacilityStatus> updateRow(
    _is.DatabaseSession session,
    FacilityStatus row, {
    _is.ColumnSelections<FacilityStatusTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FacilityStatus>(
      row,
      columns: columns?.call(FacilityStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FacilityStatus] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FacilityStatus?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FacilityStatusUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FacilityStatus>(
      id,
      columnValues: columnValues(FacilityStatus.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityStatus]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityStatus>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FacilityStatusUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FacilityStatusTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FacilityStatus>(
      columnValues: columnValues(FacilityStatus.t.updateTable),
      where: where(FacilityStatus.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FacilityStatus]s in the list and returns the deleted rows.
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
  Future<List<FacilityStatus>> delete(
    _is.DatabaseSession session,
    List<FacilityStatus> rows, {
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FacilityStatus>(
      rows,
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FacilityStatus].
  Future<FacilityStatus> deleteRow(
    _is.DatabaseSession session,
    FacilityStatus row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FacilityStatus>(
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
  Future<List<FacilityStatus>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityStatusTable> where,
    _is.OrderByBuilder<FacilityStatusTable>? orderBy,
    _is.OrderByListBuilder<FacilityStatusTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FacilityStatus>(
      where: where(FacilityStatus.t),
      orderBy: orderBy?.call(FacilityStatus.t),
      orderByList: orderByList?.call(FacilityStatus.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityStatusTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FacilityStatus>(
      where: where?.call(FacilityStatus.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FacilityStatus] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityStatusTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FacilityStatus>(
      where: where(FacilityStatus.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
