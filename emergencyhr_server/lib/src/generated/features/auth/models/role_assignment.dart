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
import '../../../features/auth/models/user_role.dart' as _it1fawf0;

/// A role held by a user. facilityId is set for facility-scoped roles.
abstract class RoleAssignment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RoleAssignment._({
    this.id,
    required this.userId,
    required this.role,
    this.facilityId,
    DateTime? createdAt,
    this.createdByUserId,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RoleAssignment({
    int? id,
    required int userId,
    required _it1fawf0.UserRole role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  }) = _RoleAssignmentImpl;

  factory RoleAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoleAssignment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      facilityId: jsonSerialization['facilityId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdByUserId: jsonSerialization['createdByUserId'] as int?,
    );
  }

  static final t = RoleAssignmentTable();

  static const db = RoleAssignmentRepository._();

  @override
  int? id;

  int userId;

  _it1fawf0.UserRole role;

  int? facilityId;

  DateTime createdAt;

  int? createdByUserId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoleAssignment copyWith({
    int? id,
    int? userId,
    _it1fawf0.UserRole? role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      if (createdByUserId != null) 'createdByUserId': createdByUserId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      if (createdByUserId != null) 'createdByUserId': createdByUserId,
    };
  }

  static RoleAssignmentInclude include() {
    return RoleAssignmentInclude._();
  }

  static RoleAssignmentIncludeList includeList({
    _is.WhereExpressionBuilder<RoleAssignmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    RoleAssignmentInclude? include,
  }) {
    return RoleAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoleAssignmentImpl extends RoleAssignment {
  _RoleAssignmentImpl({
    int? id,
    required int userId,
    required _it1fawf0.UserRole role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  }) : super._(
         id: id,
         userId: userId,
         role: role,
         facilityId: facilityId,
         createdAt: createdAt,
         createdByUserId: createdByUserId,
       );

  /// Returns a shallow copy of this [RoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoleAssignment copyWith({
    Object? id = _Undefined,
    int? userId,
    _it1fawf0.UserRole? role,
    Object? facilityId = _Undefined,
    DateTime? createdAt,
    Object? createdByUserId = _Undefined,
  }) {
    return RoleAssignment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      createdAt: createdAt ?? this.createdAt,
      createdByUserId: createdByUserId is int?
          ? createdByUserId
          : this.createdByUserId,
    );
  }
}

class RoleAssignmentUpdateTable extends _is.UpdateTable<RoleAssignmentTable> {
  RoleAssignmentUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<_it1fawf0.UserRole, _it1fawf0.UserRole> role(
    _it1fawf0.UserRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<int, int> facilityId(int? value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<int, int> createdByUserId(int? value) => _is.ColumnValue(
    table.createdByUserId,
    value,
  );
}

class RoleAssignmentTable extends _is.Table<int?> {
  RoleAssignmentTable({super.tableRelation})
    : super(tableName: 'role_assignment') {
    updateTable = RoleAssignmentUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    createdByUserId = _is.ColumnInt(
      'createdByUserId',
      this,
    );
  }

  late final RoleAssignmentUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnEnum<_it1fawf0.UserRole> role;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnInt createdByUserId;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    role,
    facilityId,
    createdAt,
    createdByUserId,
  ];
}

class RoleAssignmentInclude extends _is.IncludeObject {
  RoleAssignmentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RoleAssignment.t;
}

class RoleAssignmentIncludeList extends _is.IncludeList {
  RoleAssignmentIncludeList._({
    _is.WhereExpressionBuilder<RoleAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoleAssignment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RoleAssignment.t;
}

class RoleAssignmentRepository {
  const RoleAssignmentRepository._();

  /// Returns a list of [RoleAssignment]s matching the given query parameters.
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
  Future<List<RoleAssignment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoleAssignmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoleAssignment>(
      where: where?.call(RoleAssignment.t),
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoleAssignment] matching the given query parameters.
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
  Future<RoleAssignment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoleAssignmentTable>? where,
    int? offset,
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoleAssignment>(
      where: where?.call(RoleAssignment.t),
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoleAssignment] by its [id] or null if no such row exists.
  Future<RoleAssignment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoleAssignment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoleAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [RoleAssignment]s will have their `id` fields set.
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
  Future<List<RoleAssignment>> insert(
    _is.DatabaseSession session,
    List<RoleAssignment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RoleAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RoleAssignment] and returns the inserted row.
  ///
  /// The returned [RoleAssignment] will have its `id` field set.
  Future<RoleAssignment> insertRow(
    _is.DatabaseSession session,
    RoleAssignment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoleAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RoleAssignment]s in the list and returns the resulting rows.
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
  /// The returned [RoleAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoleAssignment>> upsert(
    _is.DatabaseSession session,
    List<RoleAssignment> rows, {
    required _is.ColumnSelections<RoleAssignmentTable> conflictColumns,
    _is.ColumnSelections<RoleAssignmentTable>? updateColumns,
    _is.WhereExpressionBuilder<RoleAssignmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RoleAssignment>(
      rows,
      conflictColumns: conflictColumns(RoleAssignment.t),
      updateColumns: updateColumns?.call(RoleAssignment.t),
      updateWhere: updateWhere?.call(RoleAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RoleAssignment] and returns the resulting row.
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
  /// The returned [RoleAssignment] will have its `id` field set.
  Future<RoleAssignment?> upsertRow(
    _is.DatabaseSession session,
    RoleAssignment row, {
    required _is.ColumnSelections<RoleAssignmentTable> conflictColumns,
    _is.ColumnSelections<RoleAssignmentTable>? updateColumns,
    _is.WhereExpressionBuilder<RoleAssignmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RoleAssignment>(
      row,
      conflictColumns: conflictColumns(RoleAssignment.t),
      updateColumns: updateColumns?.call(RoleAssignment.t),
      updateWhere: updateWhere?.call(RoleAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates all [RoleAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoleAssignment>> update(
    _is.DatabaseSession session,
    List<RoleAssignment> rows, {
    _is.ColumnSelections<RoleAssignmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RoleAssignment>(
      rows,
      columns: columns?.call(RoleAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RoleAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoleAssignment> updateRow(
    _is.DatabaseSession session,
    RoleAssignment row, {
    _is.ColumnSelections<RoleAssignmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoleAssignment>(
      row,
      columns: columns?.call(RoleAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoleAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoleAssignment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RoleAssignmentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RoleAssignment>(
      id,
      columnValues: columnValues(RoleAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoleAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RoleAssignment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RoleAssignmentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RoleAssignmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RoleAssignment>(
      columnValues: columnValues(RoleAssignment.t.updateTable),
      where: where(RoleAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RoleAssignment]s in the list and returns the deleted rows.
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
  Future<List<RoleAssignment>> delete(
    _is.DatabaseSession session,
    List<RoleAssignment> rows, {
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RoleAssignment>(
      rows,
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RoleAssignment].
  Future<RoleAssignment> deleteRow(
    _is.DatabaseSession session,
    RoleAssignment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoleAssignment>(
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
  Future<List<RoleAssignment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoleAssignmentTable> where,
    _is.OrderByBuilder<RoleAssignmentTable>? orderBy,
    _is.OrderByListBuilder<RoleAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RoleAssignment>(
      where: where(RoleAssignment.t),
      orderBy: orderBy?.call(RoleAssignment.t),
      orderByList: orderByList?.call(RoleAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RoleAssignmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RoleAssignment>(
      where: where?.call(RoleAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoleAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RoleAssignmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoleAssignment>(
      where: where(RoleAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
