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

/// Audit log entry for every status change. oldValue and newValue are JSON.
abstract class StatusChangeLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StatusChangeLog._({
    this.id,
    required this.facilityId,
    this.userId,
    this.oldValue,
    required this.newValue,
    bool? practice,
    required this.at,
  }) : practice = practice ?? false;

  factory StatusChangeLog({
    int? id,
    required int facilityId,
    int? userId,
    String? oldValue,
    required String newValue,
    bool? practice,
    required DateTime at,
  }) = _StatusChangeLogImpl;

  factory StatusChangeLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusChangeLog(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int?,
      oldValue: jsonSerialization['oldValue'] as String?,
      newValue: jsonSerialization['newValue'] as String,
      practice: jsonSerialization['practice'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['practice']),
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  static final t = StatusChangeLogTable();

  static const db = StatusChangeLogRepository._();

  @override
  int? id;

  int facilityId;

  int? userId;

  String? oldValue;

  String newValue;

  /// Training-mode updates are logged but never shown to the public.
  bool practice;

  DateTime at;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StatusChangeLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StatusChangeLog copyWith({
    int? id,
    int? facilityId,
    int? userId,
    String? oldValue,
    String? newValue,
    bool? practice,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusChangeLog',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      if (oldValue != null) 'oldValue': oldValue,
      'newValue': newValue,
      'practice': practice,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusChangeLog',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      if (oldValue != null) 'oldValue': oldValue,
      'newValue': newValue,
      'practice': practice,
      'at': at.toJson(),
    };
  }

  static StatusChangeLogInclude include() {
    return StatusChangeLogInclude._();
  }

  static StatusChangeLogIncludeList includeList({
    _is.WhereExpressionBuilder<StatusChangeLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    StatusChangeLogInclude? include,
  }) {
    return StatusChangeLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StatusChangeLogImpl extends StatusChangeLog {
  _StatusChangeLogImpl({
    int? id,
    required int facilityId,
    int? userId,
    String? oldValue,
    required String newValue,
    bool? practice,
    required DateTime at,
  }) : super._(
         id: id,
         facilityId: facilityId,
         userId: userId,
         oldValue: oldValue,
         newValue: newValue,
         practice: practice,
         at: at,
       );

  /// Returns a shallow copy of this [StatusChangeLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StatusChangeLog copyWith({
    Object? id = _Undefined,
    int? facilityId,
    Object? userId = _Undefined,
    Object? oldValue = _Undefined,
    String? newValue,
    bool? practice,
    DateTime? at,
  }) {
    return StatusChangeLog(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      userId: userId is int? ? userId : this.userId,
      oldValue: oldValue is String? ? oldValue : this.oldValue,
      newValue: newValue ?? this.newValue,
      practice: practice ?? this.practice,
      at: at ?? this.at,
    );
  }
}

class StatusChangeLogUpdateTable extends _is.UpdateTable<StatusChangeLogTable> {
  StatusChangeLogUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<int, int> userId(int? value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> oldValue(String? value) => _is.ColumnValue(
    table.oldValue,
    value,
  );

  _is.ColumnValue<String, String> newValue(String value) => _is.ColumnValue(
    table.newValue,
    value,
  );

  _is.ColumnValue<bool, bool> practice(bool value) => _is.ColumnValue(
    table.practice,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );
}

class StatusChangeLogTable extends _is.Table<int?> {
  StatusChangeLogTable({super.tableRelation})
    : super(tableName: 'status_change_log') {
    updateTable = StatusChangeLogUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    oldValue = _is.ColumnString(
      'oldValue',
      this,
    );
    newValue = _is.ColumnString(
      'newValue',
      this,
    );
    practice = _is.ColumnBool(
      'practice',
      this,
      hasDefault: true,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
    );
  }

  late final StatusChangeLogUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnInt userId;

  late final _is.ColumnString oldValue;

  late final _is.ColumnString newValue;

  /// Training-mode updates are logged but never shown to the public.
  late final _is.ColumnBool practice;

  late final _is.ColumnDateTime at;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    userId,
    oldValue,
    newValue,
    practice,
    at,
  ];
}

class StatusChangeLogInclude extends _is.IncludeObject {
  StatusChangeLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StatusChangeLog.t;
}

class StatusChangeLogIncludeList extends _is.IncludeList {
  StatusChangeLogIncludeList._({
    _is.WhereExpressionBuilder<StatusChangeLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StatusChangeLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StatusChangeLog.t;
}

class StatusChangeLogRepository {
  const StatusChangeLogRepository._();

  /// Returns a list of [StatusChangeLog]s matching the given query parameters.
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
  Future<List<StatusChangeLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusChangeLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StatusChangeLog>(
      where: where?.call(StatusChangeLog.t),
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StatusChangeLog] matching the given query parameters.
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
  Future<StatusChangeLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusChangeLogTable>? where,
    int? offset,
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StatusChangeLog>(
      where: where?.call(StatusChangeLog.t),
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StatusChangeLog] by its [id] or null if no such row exists.
  Future<StatusChangeLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StatusChangeLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StatusChangeLog]s in the list and returns the inserted rows.
  ///
  /// The returned [StatusChangeLog]s will have their `id` fields set.
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
  Future<List<StatusChangeLog>> insert(
    _is.DatabaseSession session,
    List<StatusChangeLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StatusChangeLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StatusChangeLog] and returns the inserted row.
  ///
  /// The returned [StatusChangeLog] will have its `id` field set.
  Future<StatusChangeLog> insertRow(
    _is.DatabaseSession session,
    StatusChangeLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StatusChangeLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StatusChangeLog]s in the list and returns the resulting rows.
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
  /// The returned [StatusChangeLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusChangeLog>> upsert(
    _is.DatabaseSession session,
    List<StatusChangeLog> rows, {
    required _is.ColumnSelections<StatusChangeLogTable> conflictColumns,
    _is.ColumnSelections<StatusChangeLogTable>? updateColumns,
    _is.WhereExpressionBuilder<StatusChangeLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StatusChangeLog>(
      rows,
      conflictColumns: conflictColumns(StatusChangeLog.t),
      updateColumns: updateColumns?.call(StatusChangeLog.t),
      updateWhere: updateWhere?.call(StatusChangeLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StatusChangeLog] and returns the resulting row.
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
  /// The returned [StatusChangeLog] will have its `id` field set.
  Future<StatusChangeLog?> upsertRow(
    _is.DatabaseSession session,
    StatusChangeLog row, {
    required _is.ColumnSelections<StatusChangeLogTable> conflictColumns,
    _is.ColumnSelections<StatusChangeLogTable>? updateColumns,
    _is.WhereExpressionBuilder<StatusChangeLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StatusChangeLog>(
      row,
      conflictColumns: conflictColumns(StatusChangeLog.t),
      updateColumns: updateColumns?.call(StatusChangeLog.t),
      updateWhere: updateWhere?.call(StatusChangeLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [StatusChangeLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusChangeLog>> update(
    _is.DatabaseSession session,
    List<StatusChangeLog> rows, {
    _is.ColumnSelections<StatusChangeLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StatusChangeLog>(
      rows,
      columns: columns?.call(StatusChangeLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StatusChangeLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StatusChangeLog> updateRow(
    _is.DatabaseSession session,
    StatusChangeLog row, {
    _is.ColumnSelections<StatusChangeLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StatusChangeLog>(
      row,
      columns: columns?.call(StatusChangeLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StatusChangeLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StatusChangeLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StatusChangeLogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StatusChangeLog>(
      id,
      columnValues: columnValues(StatusChangeLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StatusChangeLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StatusChangeLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StatusChangeLogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StatusChangeLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StatusChangeLog>(
      columnValues: columnValues(StatusChangeLog.t.updateTable),
      where: where(StatusChangeLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StatusChangeLog]s in the list and returns the deleted rows.
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
  Future<List<StatusChangeLog>> delete(
    _is.DatabaseSession session,
    List<StatusChangeLog> rows, {
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StatusChangeLog>(
      rows,
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StatusChangeLog].
  Future<StatusChangeLog> deleteRow(
    _is.DatabaseSession session,
    StatusChangeLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StatusChangeLog>(
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
  Future<List<StatusChangeLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StatusChangeLogTable> where,
    _is.OrderByBuilder<StatusChangeLogTable>? orderBy,
    _is.OrderByListBuilder<StatusChangeLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StatusChangeLog>(
      where: where(StatusChangeLog.t),
      orderBy: orderBy?.call(StatusChangeLog.t),
      orderByList: orderByList?.call(StatusChangeLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StatusChangeLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StatusChangeLog>(
      where: where?.call(StatusChangeLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StatusChangeLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StatusChangeLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StatusChangeLog>(
      where: where(StatusChangeLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
