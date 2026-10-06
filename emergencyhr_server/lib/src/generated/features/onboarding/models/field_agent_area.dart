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

/// A pilot area assigned to a field agent.
abstract class FieldAgentArea
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FieldAgentArea._({
    this.id,
    required this.userId,
    required this.area,
  });

  factory FieldAgentArea({
    int? id,
    required int userId,
    required String area,
  }) = _FieldAgentAreaImpl;

  factory FieldAgentArea.fromJson(Map<String, dynamic> jsonSerialization) {
    return FieldAgentArea(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      area: jsonSerialization['area'] as String,
    );
  }

  static final t = FieldAgentAreaTable();

  static const db = FieldAgentAreaRepository._();

  @override
  int? id;

  int userId;

  String area;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FieldAgentArea]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FieldAgentArea copyWith({
    int? id,
    int? userId,
    String? area,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FieldAgentArea',
      if (id != null) 'id': id,
      'userId': userId,
      'area': area,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FieldAgentArea',
      if (id != null) 'id': id,
      'userId': userId,
      'area': area,
    };
  }

  static FieldAgentAreaInclude include() {
    return FieldAgentAreaInclude._();
  }

  static FieldAgentAreaIncludeList includeList({
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    FieldAgentAreaInclude? include,
  }) {
    return FieldAgentAreaIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FieldAgentAreaImpl extends FieldAgentArea {
  _FieldAgentAreaImpl({
    int? id,
    required int userId,
    required String area,
  }) : super._(
         id: id,
         userId: userId,
         area: area,
       );

  /// Returns a shallow copy of this [FieldAgentArea]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FieldAgentArea copyWith({
    Object? id = _Undefined,
    int? userId,
    String? area,
  }) {
    return FieldAgentArea(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      area: area ?? this.area,
    );
  }
}

class FieldAgentAreaUpdateTable extends _is.UpdateTable<FieldAgentAreaTable> {
  FieldAgentAreaUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> area(String value) => _is.ColumnValue(
    table.area,
    value,
  );
}

class FieldAgentAreaTable extends _is.Table<int?> {
  FieldAgentAreaTable({super.tableRelation})
    : super(tableName: 'field_agent_area') {
    updateTable = FieldAgentAreaUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    area = _is.ColumnString(
      'area',
      this,
    );
  }

  late final FieldAgentAreaUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString area;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    area,
  ];
}

class FieldAgentAreaInclude extends _is.IncludeObject {
  FieldAgentAreaInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FieldAgentArea.t;
}

class FieldAgentAreaIncludeList extends _is.IncludeList {
  FieldAgentAreaIncludeList._({
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FieldAgentArea.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FieldAgentArea.t;
}

class FieldAgentAreaRepository {
  const FieldAgentAreaRepository._();

  /// Returns a list of [FieldAgentArea]s matching the given query parameters.
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
  Future<List<FieldAgentArea>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FieldAgentArea>(
      where: where?.call(FieldAgentArea.t),
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FieldAgentArea] matching the given query parameters.
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
  Future<FieldAgentArea?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? where,
    int? offset,
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FieldAgentArea>(
      where: where?.call(FieldAgentArea.t),
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FieldAgentArea] by its [id] or null if no such row exists.
  Future<FieldAgentArea?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FieldAgentArea>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FieldAgentArea]s in the list and returns the inserted rows.
  ///
  /// The returned [FieldAgentArea]s will have their `id` fields set.
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
  Future<List<FieldAgentArea>> insert(
    _is.DatabaseSession session,
    List<FieldAgentArea> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FieldAgentArea>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FieldAgentArea] and returns the inserted row.
  ///
  /// The returned [FieldAgentArea] will have its `id` field set.
  Future<FieldAgentArea> insertRow(
    _is.DatabaseSession session,
    FieldAgentArea row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FieldAgentArea>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FieldAgentArea]s in the list and returns the resulting rows.
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
  /// The returned [FieldAgentArea]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FieldAgentArea>> upsert(
    _is.DatabaseSession session,
    List<FieldAgentArea> rows, {
    required _is.ColumnSelections<FieldAgentAreaTable> conflictColumns,
    _is.ColumnSelections<FieldAgentAreaTable>? updateColumns,
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FieldAgentArea>(
      rows,
      conflictColumns: conflictColumns(FieldAgentArea.t),
      updateColumns: updateColumns?.call(FieldAgentArea.t),
      updateWhere: updateWhere?.call(FieldAgentArea.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FieldAgentArea] and returns the resulting row.
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
  /// The returned [FieldAgentArea] will have its `id` field set.
  Future<FieldAgentArea?> upsertRow(
    _is.DatabaseSession session,
    FieldAgentArea row, {
    required _is.ColumnSelections<FieldAgentAreaTable> conflictColumns,
    _is.ColumnSelections<FieldAgentAreaTable>? updateColumns,
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FieldAgentArea>(
      row,
      conflictColumns: conflictColumns(FieldAgentArea.t),
      updateColumns: updateColumns?.call(FieldAgentArea.t),
      updateWhere: updateWhere?.call(FieldAgentArea.t),
      transaction: transaction,
    );
  }

  /// Updates all [FieldAgentArea]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FieldAgentArea>> update(
    _is.DatabaseSession session,
    List<FieldAgentArea> rows, {
    _is.ColumnSelections<FieldAgentAreaTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FieldAgentArea>(
      rows,
      columns: columns?.call(FieldAgentArea.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FieldAgentArea]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FieldAgentArea> updateRow(
    _is.DatabaseSession session,
    FieldAgentArea row, {
    _is.ColumnSelections<FieldAgentAreaTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FieldAgentArea>(
      row,
      columns: columns?.call(FieldAgentArea.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FieldAgentArea] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FieldAgentArea?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FieldAgentAreaUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FieldAgentArea>(
      id,
      columnValues: columnValues(FieldAgentArea.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FieldAgentArea]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FieldAgentArea>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FieldAgentAreaUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FieldAgentAreaTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FieldAgentArea>(
      columnValues: columnValues(FieldAgentArea.t.updateTable),
      where: where(FieldAgentArea.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FieldAgentArea]s in the list and returns the deleted rows.
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
  Future<List<FieldAgentArea>> delete(
    _is.DatabaseSession session,
    List<FieldAgentArea> rows, {
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FieldAgentArea>(
      rows,
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FieldAgentArea].
  Future<FieldAgentArea> deleteRow(
    _is.DatabaseSession session,
    FieldAgentArea row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FieldAgentArea>(
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
  Future<List<FieldAgentArea>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FieldAgentAreaTable> where,
    _is.OrderByBuilder<FieldAgentAreaTable>? orderBy,
    _is.OrderByListBuilder<FieldAgentAreaTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FieldAgentArea>(
      where: where(FieldAgentArea.t),
      orderBy: orderBy?.call(FieldAgentArea.t),
      orderByList: orderByList?.call(FieldAgentArea.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FieldAgentAreaTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FieldAgentArea>(
      where: where?.call(FieldAgentArea.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FieldAgentArea] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FieldAgentAreaTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FieldAgentArea>(
      where: where(FieldAgentArea.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
