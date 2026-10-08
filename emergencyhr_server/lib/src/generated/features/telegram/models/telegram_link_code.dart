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

/// Single-use code inside a "Connect Telegram" link. Only the hash is
/// stored.
abstract class TelegramLinkCode
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TelegramLinkCode._({
    this.id,
    required this.userId,
    required this.codeHash,
    required this.expiresAt,
    this.usedAt,
  });

  factory TelegramLinkCode({
    int? id,
    required int userId,
    required String codeHash,
    required DateTime expiresAt,
    DateTime? usedAt,
  }) = _TelegramLinkCodeImpl;

  factory TelegramLinkCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelegramLinkCode(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      codeHash: jsonSerialization['codeHash'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
    );
  }

  static final t = TelegramLinkCodeTable();

  static const db = TelegramLinkCodeRepository._();

  @override
  int? id;

  int userId;

  String codeHash;

  DateTime expiresAt;

  DateTime? usedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TelegramLinkCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TelegramLinkCode copyWith({
    int? id,
    int? userId,
    String? codeHash,
    DateTime? expiresAt,
    DateTime? usedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelegramLinkCode',
      if (id != null) 'id': id,
      'userId': userId,
      'codeHash': codeHash,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static TelegramLinkCodeInclude include() {
    return TelegramLinkCodeInclude._();
  }

  static TelegramLinkCodeIncludeList includeList({
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    TelegramLinkCodeInclude? include,
  }) {
    return TelegramLinkCodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelegramLinkCodeImpl extends TelegramLinkCode {
  _TelegramLinkCodeImpl({
    int? id,
    required int userId,
    required String codeHash,
    required DateTime expiresAt,
    DateTime? usedAt,
  }) : super._(
         id: id,
         userId: userId,
         codeHash: codeHash,
         expiresAt: expiresAt,
         usedAt: usedAt,
       );

  /// Returns a shallow copy of this [TelegramLinkCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TelegramLinkCode copyWith({
    Object? id = _Undefined,
    int? userId,
    String? codeHash,
    DateTime? expiresAt,
    Object? usedAt = _Undefined,
  }) {
    return TelegramLinkCode(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      codeHash: codeHash ?? this.codeHash,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
    );
  }
}

class TelegramLinkCodeUpdateTable
    extends _is.UpdateTable<TelegramLinkCodeTable> {
  TelegramLinkCodeUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> codeHash(String value) => _is.ColumnValue(
    table.codeHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> usedAt(DateTime? value) =>
      _is.ColumnValue(
        table.usedAt,
        value,
      );
}

class TelegramLinkCodeTable extends _is.Table<int?> {
  TelegramLinkCodeTable({super.tableRelation})
    : super(tableName: 'telegram_link_code') {
    updateTable = TelegramLinkCodeUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    codeHash = _is.ColumnString(
      'codeHash',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    usedAt = _is.ColumnDateTime(
      'usedAt',
      this,
    );
  }

  late final TelegramLinkCodeUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString codeHash;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime usedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    codeHash,
    expiresAt,
    usedAt,
  ];
}

class TelegramLinkCodeInclude extends _is.IncludeObject {
  TelegramLinkCodeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TelegramLinkCode.t;
}

class TelegramLinkCodeIncludeList extends _is.IncludeList {
  TelegramLinkCodeIncludeList._({
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TelegramLinkCode.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TelegramLinkCode.t;
}

class TelegramLinkCodeRepository {
  const TelegramLinkCodeRepository._();

  /// Returns a list of [TelegramLinkCode]s matching the given query parameters.
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
  Future<List<TelegramLinkCode>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TelegramLinkCode>(
      where: where?.call(TelegramLinkCode.t),
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TelegramLinkCode] matching the given query parameters.
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
  Future<TelegramLinkCode?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? where,
    int? offset,
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TelegramLinkCode>(
      where: where?.call(TelegramLinkCode.t),
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TelegramLinkCode] by its [id] or null if no such row exists.
  Future<TelegramLinkCode?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TelegramLinkCode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TelegramLinkCode]s in the list and returns the inserted rows.
  ///
  /// The returned [TelegramLinkCode]s will have their `id` fields set.
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
  Future<List<TelegramLinkCode>> insert(
    _is.DatabaseSession session,
    List<TelegramLinkCode> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TelegramLinkCode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TelegramLinkCode] and returns the inserted row.
  ///
  /// The returned [TelegramLinkCode] will have its `id` field set.
  Future<TelegramLinkCode> insertRow(
    _is.DatabaseSession session,
    TelegramLinkCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TelegramLinkCode>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TelegramLinkCode]s in the list and returns the resulting rows.
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
  /// The returned [TelegramLinkCode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLinkCode>> upsert(
    _is.DatabaseSession session,
    List<TelegramLinkCode> rows, {
    required _is.ColumnSelections<TelegramLinkCodeTable> conflictColumns,
    _is.ColumnSelections<TelegramLinkCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TelegramLinkCode>(
      rows,
      conflictColumns: conflictColumns(TelegramLinkCode.t),
      updateColumns: updateColumns?.call(TelegramLinkCode.t),
      updateWhere: updateWhere?.call(TelegramLinkCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TelegramLinkCode] and returns the resulting row.
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
  /// The returned [TelegramLinkCode] will have its `id` field set.
  Future<TelegramLinkCode?> upsertRow(
    _is.DatabaseSession session,
    TelegramLinkCode row, {
    required _is.ColumnSelections<TelegramLinkCodeTable> conflictColumns,
    _is.ColumnSelections<TelegramLinkCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TelegramLinkCode>(
      row,
      conflictColumns: conflictColumns(TelegramLinkCode.t),
      updateColumns: updateColumns?.call(TelegramLinkCode.t),
      updateWhere: updateWhere?.call(TelegramLinkCode.t),
      transaction: transaction,
    );
  }

  /// Updates all [TelegramLinkCode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLinkCode>> update(
    _is.DatabaseSession session,
    List<TelegramLinkCode> rows, {
    _is.ColumnSelections<TelegramLinkCodeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TelegramLinkCode>(
      rows,
      columns: columns?.call(TelegramLinkCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TelegramLinkCode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TelegramLinkCode> updateRow(
    _is.DatabaseSession session,
    TelegramLinkCode row, {
    _is.ColumnSelections<TelegramLinkCodeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TelegramLinkCode>(
      row,
      columns: columns?.call(TelegramLinkCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelegramLinkCode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TelegramLinkCode?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TelegramLinkCodeUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TelegramLinkCode>(
      id,
      columnValues: columnValues(TelegramLinkCode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TelegramLinkCode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLinkCode>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TelegramLinkCodeUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<TelegramLinkCodeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TelegramLinkCode>(
      columnValues: columnValues(TelegramLinkCode.t.updateTable),
      where: where(TelegramLinkCode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TelegramLinkCode]s in the list and returns the deleted rows.
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
  Future<List<TelegramLinkCode>> delete(
    _is.DatabaseSession session,
    List<TelegramLinkCode> rows, {
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TelegramLinkCode>(
      rows,
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TelegramLinkCode].
  Future<TelegramLinkCode> deleteRow(
    _is.DatabaseSession session,
    TelegramLinkCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TelegramLinkCode>(
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
  Future<List<TelegramLinkCode>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TelegramLinkCodeTable> where,
    _is.OrderByBuilder<TelegramLinkCodeTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TelegramLinkCode>(
      where: where(TelegramLinkCode.t),
      orderBy: orderBy?.call(TelegramLinkCode.t),
      orderByList: orderByList?.call(TelegramLinkCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkCodeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TelegramLinkCode>(
      where: where?.call(TelegramLinkCode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TelegramLinkCode] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TelegramLinkCodeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TelegramLinkCode>(
      where: where(TelegramLinkCode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
