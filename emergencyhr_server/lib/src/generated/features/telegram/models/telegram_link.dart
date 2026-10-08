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

/// A hospital staff member's Telegram account, connected from the app with
/// a one-time link. The bot acts as this user for status updates.
abstract class TelegramLink
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TelegramLink._({
    this.id,
    required this.userId,
    required this.telegramUserId,
    required this.chatId,
    required this.linkedAt,
  });

  factory TelegramLink({
    int? id,
    required int userId,
    required int telegramUserId,
    required int chatId,
    required DateTime linkedAt,
  }) = _TelegramLinkImpl;

  factory TelegramLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelegramLink(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      telegramUserId: jsonSerialization['telegramUserId'] as int,
      chatId: jsonSerialization['chatId'] as int,
      linkedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['linkedAt'],
      ),
    );
  }

  static final t = TelegramLinkTable();

  static const db = TelegramLinkRepository._();

  @override
  int? id;

  int userId;

  /// Telegram's id for the person (from.id), set by Telegram, not the user.
  int telegramUserId;

  int chatId;

  DateTime linkedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TelegramLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TelegramLink copyWith({
    int? id,
    int? userId,
    int? telegramUserId,
    int? chatId,
    DateTime? linkedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelegramLink',
      if (id != null) 'id': id,
      'userId': userId,
      'telegramUserId': telegramUserId,
      'chatId': chatId,
      'linkedAt': linkedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static TelegramLinkInclude include() {
    return TelegramLinkInclude._();
  }

  static TelegramLinkIncludeList includeList({
    _is.WhereExpressionBuilder<TelegramLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    TelegramLinkInclude? include,
  }) {
    return TelegramLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelegramLinkImpl extends TelegramLink {
  _TelegramLinkImpl({
    int? id,
    required int userId,
    required int telegramUserId,
    required int chatId,
    required DateTime linkedAt,
  }) : super._(
         id: id,
         userId: userId,
         telegramUserId: telegramUserId,
         chatId: chatId,
         linkedAt: linkedAt,
       );

  /// Returns a shallow copy of this [TelegramLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TelegramLink copyWith({
    Object? id = _Undefined,
    int? userId,
    int? telegramUserId,
    int? chatId,
    DateTime? linkedAt,
  }) {
    return TelegramLink(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      telegramUserId: telegramUserId ?? this.telegramUserId,
      chatId: chatId ?? this.chatId,
      linkedAt: linkedAt ?? this.linkedAt,
    );
  }
}

class TelegramLinkUpdateTable extends _is.UpdateTable<TelegramLinkTable> {
  TelegramLinkUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> telegramUserId(int value) => _is.ColumnValue(
    table.telegramUserId,
    value,
  );

  _is.ColumnValue<int, int> chatId(int value) => _is.ColumnValue(
    table.chatId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> linkedAt(DateTime value) =>
      _is.ColumnValue(
        table.linkedAt,
        value,
      );
}

class TelegramLinkTable extends _is.Table<int?> {
  TelegramLinkTable({super.tableRelation}) : super(tableName: 'telegram_link') {
    updateTable = TelegramLinkUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    telegramUserId = _is.ColumnInt(
      'telegramUserId',
      this,
    );
    chatId = _is.ColumnInt(
      'chatId',
      this,
    );
    linkedAt = _is.ColumnDateTime(
      'linkedAt',
      this,
    );
  }

  late final TelegramLinkUpdateTable updateTable;

  late final _is.ColumnInt userId;

  /// Telegram's id for the person (from.id), set by Telegram, not the user.
  late final _is.ColumnInt telegramUserId;

  late final _is.ColumnInt chatId;

  late final _is.ColumnDateTime linkedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    telegramUserId,
    chatId,
    linkedAt,
  ];
}

class TelegramLinkInclude extends _is.IncludeObject {
  TelegramLinkInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TelegramLink.t;
}

class TelegramLinkIncludeList extends _is.IncludeList {
  TelegramLinkIncludeList._({
    _is.WhereExpressionBuilder<TelegramLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TelegramLink.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TelegramLink.t;
}

class TelegramLinkRepository {
  const TelegramLinkRepository._();

  /// Returns a list of [TelegramLink]s matching the given query parameters.
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
  Future<List<TelegramLink>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TelegramLink>(
      where: where?.call(TelegramLink.t),
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TelegramLink] matching the given query parameters.
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
  Future<TelegramLink?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkTable>? where,
    int? offset,
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TelegramLink>(
      where: where?.call(TelegramLink.t),
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TelegramLink] by its [id] or null if no such row exists.
  Future<TelegramLink?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TelegramLink>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TelegramLink]s in the list and returns the inserted rows.
  ///
  /// The returned [TelegramLink]s will have their `id` fields set.
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
  Future<List<TelegramLink>> insert(
    _is.DatabaseSession session,
    List<TelegramLink> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TelegramLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TelegramLink] and returns the inserted row.
  ///
  /// The returned [TelegramLink] will have its `id` field set.
  Future<TelegramLink> insertRow(
    _is.DatabaseSession session,
    TelegramLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TelegramLink>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TelegramLink]s in the list and returns the resulting rows.
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
  /// The returned [TelegramLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLink>> upsert(
    _is.DatabaseSession session,
    List<TelegramLink> rows, {
    required _is.ColumnSelections<TelegramLinkTable> conflictColumns,
    _is.ColumnSelections<TelegramLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<TelegramLinkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TelegramLink>(
      rows,
      conflictColumns: conflictColumns(TelegramLink.t),
      updateColumns: updateColumns?.call(TelegramLink.t),
      updateWhere: updateWhere?.call(TelegramLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TelegramLink] and returns the resulting row.
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
  /// The returned [TelegramLink] will have its `id` field set.
  Future<TelegramLink?> upsertRow(
    _is.DatabaseSession session,
    TelegramLink row, {
    required _is.ColumnSelections<TelegramLinkTable> conflictColumns,
    _is.ColumnSelections<TelegramLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<TelegramLinkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TelegramLink>(
      row,
      conflictColumns: conflictColumns(TelegramLink.t),
      updateColumns: updateColumns?.call(TelegramLink.t),
      updateWhere: updateWhere?.call(TelegramLink.t),
      transaction: transaction,
    );
  }

  /// Updates all [TelegramLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLink>> update(
    _is.DatabaseSession session,
    List<TelegramLink> rows, {
    _is.ColumnSelections<TelegramLinkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TelegramLink>(
      rows,
      columns: columns?.call(TelegramLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TelegramLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TelegramLink> updateRow(
    _is.DatabaseSession session,
    TelegramLink row, {
    _is.ColumnSelections<TelegramLinkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TelegramLink>(
      row,
      columns: columns?.call(TelegramLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelegramLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TelegramLink?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TelegramLinkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TelegramLink>(
      id,
      columnValues: columnValues(TelegramLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TelegramLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TelegramLink>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TelegramLinkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TelegramLinkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TelegramLink>(
      columnValues: columnValues(TelegramLink.t.updateTable),
      where: where(TelegramLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TelegramLink]s in the list and returns the deleted rows.
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
  Future<List<TelegramLink>> delete(
    _is.DatabaseSession session,
    List<TelegramLink> rows, {
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TelegramLink>(
      rows,
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TelegramLink].
  Future<TelegramLink> deleteRow(
    _is.DatabaseSession session,
    TelegramLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TelegramLink>(
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
  Future<List<TelegramLink>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TelegramLinkTable> where,
    _is.OrderByBuilder<TelegramLinkTable>? orderBy,
    _is.OrderByListBuilder<TelegramLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TelegramLink>(
      where: where(TelegramLink.t),
      orderBy: orderBy?.call(TelegramLink.t),
      orderByList: orderByList?.call(TelegramLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TelegramLinkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TelegramLink>(
      where: where?.call(TelegramLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TelegramLink] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TelegramLinkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TelegramLink>(
      where: where(TelegramLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
