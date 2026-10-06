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

/// Every admin and agent action, with actor and time.
abstract class AdminActionLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AdminActionLog._({
    this.id,
    required this.actorUserId,
    required this.action,
    required this.targetType,
    required this.targetId,
    this.reason,
    required this.at,
  });

  factory AdminActionLog({
    int? id,
    required int actorUserId,
    required String action,
    required String targetType,
    required int targetId,
    String? reason,
    required DateTime at,
  }) = _AdminActionLogImpl;

  factory AdminActionLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminActionLog(
      id: jsonSerialization['id'] as int?,
      actorUserId: jsonSerialization['actorUserId'] as int,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      reason: jsonSerialization['reason'] as String?,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  static final t = AdminActionLogTable();

  static const db = AdminActionLogRepository._();

  @override
  int? id;

  int actorUserId;

  String action;

  String targetType;

  int targetId;

  String? reason;

  DateTime at;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminActionLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminActionLog copyWith({
    int? id,
    int? actorUserId,
    String? action,
    String? targetType,
    int? targetId,
    String? reason,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminActionLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminActionLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      'at': at.toJson(),
    };
  }

  static AdminActionLogInclude include() {
    return AdminActionLogInclude._();
  }

  static AdminActionLogIncludeList includeList({
    _is.WhereExpressionBuilder<AdminActionLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    AdminActionLogInclude? include,
  }) {
    return AdminActionLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminActionLogImpl extends AdminActionLog {
  _AdminActionLogImpl({
    int? id,
    required int actorUserId,
    required String action,
    required String targetType,
    required int targetId,
    String? reason,
    required DateTime at,
  }) : super._(
         id: id,
         actorUserId: actorUserId,
         action: action,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         at: at,
       );

  /// Returns a shallow copy of this [AdminActionLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminActionLog copyWith({
    Object? id = _Undefined,
    int? actorUserId,
    String? action,
    String? targetType,
    int? targetId,
    Object? reason = _Undefined,
    DateTime? at,
  }) {
    return AdminActionLog(
      id: id is int? ? id : this.id,
      actorUserId: actorUserId ?? this.actorUserId,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason is String? ? reason : this.reason,
      at: at ?? this.at,
    );
  }
}

class AdminActionLogUpdateTable extends _is.UpdateTable<AdminActionLogTable> {
  AdminActionLogUpdateTable(super.table);

  _is.ColumnValue<int, int> actorUserId(int value) => _is.ColumnValue(
    table.actorUserId,
    value,
  );

  _is.ColumnValue<String, String> action(String value) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<String, String> targetType(String value) => _is.ColumnValue(
    table.targetType,
    value,
  );

  _is.ColumnValue<int, int> targetId(int value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<String, String> reason(String? value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );
}

class AdminActionLogTable extends _is.Table<int?> {
  AdminActionLogTable({super.tableRelation})
    : super(tableName: 'admin_action_log') {
    updateTable = AdminActionLogUpdateTable(this);
    actorUserId = _is.ColumnInt(
      'actorUserId',
      this,
    );
    action = _is.ColumnString(
      'action',
      this,
    );
    targetType = _is.ColumnString(
      'targetType',
      this,
    );
    targetId = _is.ColumnInt(
      'targetId',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
    );
  }

  late final AdminActionLogUpdateTable updateTable;

  late final _is.ColumnInt actorUserId;

  late final _is.ColumnString action;

  late final _is.ColumnString targetType;

  late final _is.ColumnInt targetId;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime at;

  @override
  List<_is.Column> get columns => [
    id,
    actorUserId,
    action,
    targetType,
    targetId,
    reason,
    at,
  ];
}

class AdminActionLogInclude extends _is.IncludeObject {
  AdminActionLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AdminActionLog.t;
}

class AdminActionLogIncludeList extends _is.IncludeList {
  AdminActionLogIncludeList._({
    _is.WhereExpressionBuilder<AdminActionLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminActionLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AdminActionLog.t;
}

class AdminActionLogRepository {
  const AdminActionLogRepository._();

  /// Returns a list of [AdminActionLog]s matching the given query parameters.
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
  Future<List<AdminActionLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminActionLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminActionLog>(
      where: where?.call(AdminActionLog.t),
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminActionLog] matching the given query parameters.
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
  Future<AdminActionLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminActionLogTable>? where,
    int? offset,
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminActionLog>(
      where: where?.call(AdminActionLog.t),
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminActionLog] by its [id] or null if no such row exists.
  Future<AdminActionLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminActionLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminActionLog]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminActionLog]s will have their `id` fields set.
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
  Future<List<AdminActionLog>> insert(
    _is.DatabaseSession session,
    List<AdminActionLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AdminActionLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AdminActionLog] and returns the inserted row.
  ///
  /// The returned [AdminActionLog] will have its `id` field set.
  Future<AdminActionLog> insertRow(
    _is.DatabaseSession session,
    AdminActionLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminActionLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AdminActionLog]s in the list and returns the resulting rows.
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
  /// The returned [AdminActionLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminActionLog>> upsert(
    _is.DatabaseSession session,
    List<AdminActionLog> rows, {
    required _is.ColumnSelections<AdminActionLogTable> conflictColumns,
    _is.ColumnSelections<AdminActionLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminActionLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AdminActionLog>(
      rows,
      conflictColumns: conflictColumns(AdminActionLog.t),
      updateColumns: updateColumns?.call(AdminActionLog.t),
      updateWhere: updateWhere?.call(AdminActionLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AdminActionLog] and returns the resulting row.
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
  /// The returned [AdminActionLog] will have its `id` field set.
  Future<AdminActionLog?> upsertRow(
    _is.DatabaseSession session,
    AdminActionLog row, {
    required _is.ColumnSelections<AdminActionLogTable> conflictColumns,
    _is.ColumnSelections<AdminActionLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminActionLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AdminActionLog>(
      row,
      conflictColumns: conflictColumns(AdminActionLog.t),
      updateColumns: updateColumns?.call(AdminActionLog.t),
      updateWhere: updateWhere?.call(AdminActionLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [AdminActionLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminActionLog>> update(
    _is.DatabaseSession session,
    List<AdminActionLog> rows, {
    _is.ColumnSelections<AdminActionLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AdminActionLog>(
      rows,
      columns: columns?.call(AdminActionLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AdminActionLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminActionLog> updateRow(
    _is.DatabaseSession session,
    AdminActionLog row, {
    _is.ColumnSelections<AdminActionLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminActionLog>(
      row,
      columns: columns?.call(AdminActionLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminActionLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminActionLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AdminActionLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminActionLog>(
      id,
      columnValues: columnValues(AdminActionLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminActionLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminActionLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AdminActionLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AdminActionLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AdminActionLog>(
      columnValues: columnValues(AdminActionLog.t.updateTable),
      where: where(AdminActionLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AdminActionLog]s in the list and returns the deleted rows.
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
  Future<List<AdminActionLog>> delete(
    _is.DatabaseSession session,
    List<AdminActionLog> rows, {
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AdminActionLog>(
      rows,
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AdminActionLog].
  Future<AdminActionLog> deleteRow(
    _is.DatabaseSession session,
    AdminActionLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminActionLog>(
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
  Future<List<AdminActionLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminActionLogTable> where,
    _is.OrderByBuilder<AdminActionLogTable>? orderBy,
    _is.OrderByListBuilder<AdminActionLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AdminActionLog>(
      where: where(AdminActionLog.t),
      orderBy: orderBy?.call(AdminActionLog.t),
      orderByList: orderByList?.call(AdminActionLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminActionLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AdminActionLog>(
      where: where?.call(AdminActionLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminActionLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminActionLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminActionLog>(
      where: where(AdminActionLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
