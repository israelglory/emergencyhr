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

/// A user's report that a facility's status was wrong.
abstract class StatusReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StatusReport._({
    this.id,
    required this.sessionId,
    required this.facilityId,
    this.userId,
    required this.reason,
    required this.createdAt,
    this.reviewedAt,
    this.reviewedByUserId,
  });

  factory StatusReport({
    int? id,
    required int sessionId,
    required int facilityId,
    int? userId,
    required String reason,
    required DateTime createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  }) = _StatusReportImpl;

  factory StatusReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusReport(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int?,
      reason: jsonSerialization['reason'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
    );
  }

  static final t = StatusReportTable();

  static const db = StatusReportRepository._();

  @override
  int? id;

  int sessionId;

  int facilityId;

  int? userId;

  String reason;

  DateTime createdAt;

  DateTime? reviewedAt;

  int? reviewedByUserId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StatusReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StatusReport copyWith({
    int? id,
    int? sessionId,
    int? facilityId,
    int? userId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusReport',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusReport',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
    };
  }

  static StatusReportInclude include() {
    return StatusReportInclude._();
  }

  static StatusReportIncludeList includeList({
    _is.WhereExpressionBuilder<StatusReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    StatusReportInclude? include,
  }) {
    return StatusReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StatusReportImpl extends StatusReport {
  _StatusReportImpl({
    int? id,
    required int sessionId,
    required int facilityId,
    int? userId,
    required String reason,
    required DateTime createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  }) : super._(
         id: id,
         sessionId: sessionId,
         facilityId: facilityId,
         userId: userId,
         reason: reason,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
         reviewedByUserId: reviewedByUserId,
       );

  /// Returns a shallow copy of this [StatusReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StatusReport copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? facilityId,
    Object? userId = _Undefined,
    String? reason,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
    Object? reviewedByUserId = _Undefined,
  }) {
    return StatusReport(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      facilityId: facilityId ?? this.facilityId,
      userId: userId is int? ? userId : this.userId,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      reviewedByUserId: reviewedByUserId is int?
          ? reviewedByUserId
          : this.reviewedByUserId,
    );
  }
}

class StatusReportUpdateTable extends _is.UpdateTable<StatusReportTable> {
  StatusReportUpdateTable(super.table);

  _is.ColumnValue<int, int> sessionId(int value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<int, int> userId(int? value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _is.ColumnValue(
        table.reviewedAt,
        value,
      );

  _is.ColumnValue<int, int> reviewedByUserId(int? value) => _is.ColumnValue(
    table.reviewedByUserId,
    value,
  );
}

class StatusReportTable extends _is.Table<int?> {
  StatusReportTable({super.tableRelation}) : super(tableName: 'status_report') {
    updateTable = StatusReportUpdateTable(this);
    sessionId = _is.ColumnInt(
      'sessionId',
      this,
    );
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    reviewedAt = _is.ColumnDateTime(
      'reviewedAt',
      this,
    );
    reviewedByUserId = _is.ColumnInt(
      'reviewedByUserId',
      this,
    );
  }

  late final StatusReportUpdateTable updateTable;

  late final _is.ColumnInt sessionId;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnInt userId;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime reviewedAt;

  late final _is.ColumnInt reviewedByUserId;

  @override
  List<_is.Column> get columns => [
    id,
    sessionId,
    facilityId,
    userId,
    reason,
    createdAt,
    reviewedAt,
    reviewedByUserId,
  ];
}

class StatusReportInclude extends _is.IncludeObject {
  StatusReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StatusReport.t;
}

class StatusReportIncludeList extends _is.IncludeList {
  StatusReportIncludeList._({
    _is.WhereExpressionBuilder<StatusReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StatusReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StatusReport.t;
}

class StatusReportRepository {
  const StatusReportRepository._();

  /// Returns a list of [StatusReport]s matching the given query parameters.
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
  Future<List<StatusReport>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StatusReport>(
      where: where?.call(StatusReport.t),
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StatusReport] matching the given query parameters.
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
  Future<StatusReport?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusReportTable>? where,
    int? offset,
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StatusReport>(
      where: where?.call(StatusReport.t),
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StatusReport] by its [id] or null if no such row exists.
  Future<StatusReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StatusReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StatusReport]s in the list and returns the inserted rows.
  ///
  /// The returned [StatusReport]s will have their `id` fields set.
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
  Future<List<StatusReport>> insert(
    _is.DatabaseSession session,
    List<StatusReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StatusReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StatusReport] and returns the inserted row.
  ///
  /// The returned [StatusReport] will have its `id` field set.
  Future<StatusReport> insertRow(
    _is.DatabaseSession session,
    StatusReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StatusReport>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StatusReport]s in the list and returns the resulting rows.
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
  /// The returned [StatusReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusReport>> upsert(
    _is.DatabaseSession session,
    List<StatusReport> rows, {
    required _is.ColumnSelections<StatusReportTable> conflictColumns,
    _is.ColumnSelections<StatusReportTable>? updateColumns,
    _is.WhereExpressionBuilder<StatusReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StatusReport>(
      rows,
      conflictColumns: conflictColumns(StatusReport.t),
      updateColumns: updateColumns?.call(StatusReport.t),
      updateWhere: updateWhere?.call(StatusReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StatusReport] and returns the resulting row.
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
  /// The returned [StatusReport] will have its `id` field set.
  Future<StatusReport?> upsertRow(
    _is.DatabaseSession session,
    StatusReport row, {
    required _is.ColumnSelections<StatusReportTable> conflictColumns,
    _is.ColumnSelections<StatusReportTable>? updateColumns,
    _is.WhereExpressionBuilder<StatusReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StatusReport>(
      row,
      conflictColumns: conflictColumns(StatusReport.t),
      updateColumns: updateColumns?.call(StatusReport.t),
      updateWhere: updateWhere?.call(StatusReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [StatusReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusReport>> update(
    _is.DatabaseSession session,
    List<StatusReport> rows, {
    _is.ColumnSelections<StatusReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StatusReport>(
      rows,
      columns: columns?.call(StatusReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StatusReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StatusReport> updateRow(
    _is.DatabaseSession session,
    StatusReport row, {
    _is.ColumnSelections<StatusReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StatusReport>(
      row,
      columns: columns?.call(StatusReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StatusReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StatusReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StatusReportUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StatusReport>(
      id,
      columnValues: columnValues(StatusReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StatusReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StatusReportUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StatusReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StatusReport>(
      columnValues: columnValues(StatusReport.t.updateTable),
      where: where(StatusReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StatusReport]s in the list and returns the deleted rows.
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
  Future<List<StatusReport>> delete(
    _is.DatabaseSession session,
    List<StatusReport> rows, {
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StatusReport>(
      rows,
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StatusReport].
  Future<StatusReport> deleteRow(
    _is.DatabaseSession session,
    StatusReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StatusReport>(
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
  Future<List<StatusReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StatusReportTable> where,
    _is.OrderByBuilder<StatusReportTable>? orderBy,
    _is.OrderByListBuilder<StatusReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StatusReport>(
      where: where(StatusReport.t),
      orderBy: orderBy?.call(StatusReport.t),
      orderByList: orderByList?.call(StatusReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StatusReport>(
      where: where?.call(StatusReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StatusReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StatusReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StatusReport>(
      where: where(StatusReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
