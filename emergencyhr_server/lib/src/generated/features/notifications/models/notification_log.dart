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
import '../../../features/profile/models/contact_channel.dart' as _iid3hpvd;

/// Outbound SMS/WhatsApp record, used to avoid spamming reminders.
abstract class NotificationLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  NotificationLog._({
    this.id,
    this.facilityId,
    required this.toPhone,
    required this.kind,
    required this.channel,
    required this.success,
    required this.sentAt,
  });

  factory NotificationLog({
    int? id,
    int? facilityId,
    required String toPhone,
    required String kind,
    required _iid3hpvd.ContactChannel channel,
    required bool success,
    required DateTime sentAt,
  }) = _NotificationLogImpl;

  factory NotificationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationLog(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int?,
      toPhone: jsonSerialization['toPhone'] as String,
      kind: jsonSerialization['kind'] as String,
      channel: _iid3hpvd.ContactChannel.fromJson(
        (jsonSerialization['channel'] as String),
      ),
      success: _is.BoolJsonExtension.fromJson(jsonSerialization['success']),
      sentAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  static final t = NotificationLogTable();

  static const db = NotificationLogRepository._();

  @override
  int? id;

  int? facilityId;

  String toPhone;

  String kind;

  _iid3hpvd.ContactChannel channel;

  bool success;

  DateTime sentAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NotificationLog copyWith({
    int? id,
    int? facilityId,
    String? toPhone,
    String? kind,
    _iid3hpvd.ContactChannel? channel,
    bool? success,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationLog',
      if (id != null) 'id': id,
      if (facilityId != null) 'facilityId': facilityId,
      'toPhone': toPhone,
      'kind': kind,
      'channel': channel.toJson(),
      'success': success,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static NotificationLogInclude include() {
    return NotificationLogInclude._();
  }

  static NotificationLogIncludeList includeList({
    _is.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    NotificationLogInclude? include,
  }) {
    return NotificationLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationLogImpl extends NotificationLog {
  _NotificationLogImpl({
    int? id,
    int? facilityId,
    required String toPhone,
    required String kind,
    required _iid3hpvd.ContactChannel channel,
    required bool success,
    required DateTime sentAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         toPhone: toPhone,
         kind: kind,
         channel: channel,
         success: success,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NotificationLog copyWith({
    Object? id = _Undefined,
    Object? facilityId = _Undefined,
    String? toPhone,
    String? kind,
    _iid3hpvd.ContactChannel? channel,
    bool? success,
    DateTime? sentAt,
  }) {
    return NotificationLog(
      id: id is int? ? id : this.id,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      toPhone: toPhone ?? this.toPhone,
      kind: kind ?? this.kind,
      channel: channel ?? this.channel,
      success: success ?? this.success,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}

class NotificationLogUpdateTable extends _is.UpdateTable<NotificationLogTable> {
  NotificationLogUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int? value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<String, String> toPhone(String value) => _is.ColumnValue(
    table.toPhone,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<_iid3hpvd.ContactChannel, _iid3hpvd.ContactChannel> channel(
    _iid3hpvd.ContactChannel value,
  ) => _is.ColumnValue(
    table.channel,
    value,
  );

  _is.ColumnValue<bool, bool> success(bool value) => _is.ColumnValue(
    table.success,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> sentAt(DateTime value) => _is.ColumnValue(
    table.sentAt,
    value,
  );
}

class NotificationLogTable extends _is.Table<int?> {
  NotificationLogTable({super.tableRelation})
    : super(tableName: 'notification_log') {
    updateTable = NotificationLogUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    toPhone = _is.ColumnString(
      'toPhone',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    channel = _is.ColumnEnum(
      'channel',
      this,
      _is.EnumSerialization.byName,
    );
    success = _is.ColumnBool(
      'success',
      this,
    );
    sentAt = _is.ColumnDateTime(
      'sentAt',
      this,
    );
  }

  late final NotificationLogUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnString toPhone;

  late final _is.ColumnString kind;

  late final _is.ColumnEnum<_iid3hpvd.ContactChannel> channel;

  late final _is.ColumnBool success;

  late final _is.ColumnDateTime sentAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    toPhone,
    kind,
    channel,
    success,
    sentAt,
  ];
}

class NotificationLogInclude extends _is.IncludeObject {
  NotificationLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => NotificationLog.t;
}

class NotificationLogIncludeList extends _is.IncludeList {
  NotificationLogIncludeList._({
    _is.WhereExpressionBuilder<NotificationLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NotificationLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => NotificationLog.t;
}

class NotificationLogRepository {
  const NotificationLogRepository._();

  /// Returns a list of [NotificationLog]s matching the given query parameters.
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
  Future<List<NotificationLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NotificationLog>(
      where: where?.call(NotificationLog.t),
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NotificationLog] matching the given query parameters.
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
  Future<NotificationLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NotificationLogTable>? where,
    int? offset,
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NotificationLog>(
      where: where?.call(NotificationLog.t),
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NotificationLog] by its [id] or null if no such row exists.
  Future<NotificationLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NotificationLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NotificationLog]s in the list and returns the inserted rows.
  ///
  /// The returned [NotificationLog]s will have their `id` fields set.
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
  Future<List<NotificationLog>> insert(
    _is.DatabaseSession session,
    List<NotificationLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<NotificationLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [NotificationLog] and returns the inserted row.
  ///
  /// The returned [NotificationLog] will have its `id` field set.
  Future<NotificationLog> insertRow(
    _is.DatabaseSession session,
    NotificationLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<NotificationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [NotificationLog]s in the list and returns the resulting rows.
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
  /// The returned [NotificationLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NotificationLog>> upsert(
    _is.DatabaseSession session,
    List<NotificationLog> rows, {
    required _is.ColumnSelections<NotificationLogTable> conflictColumns,
    _is.ColumnSelections<NotificationLogTable>? updateColumns,
    _is.WhereExpressionBuilder<NotificationLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<NotificationLog>(
      rows,
      conflictColumns: conflictColumns(NotificationLog.t),
      updateColumns: updateColumns?.call(NotificationLog.t),
      updateWhere: updateWhere?.call(NotificationLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [NotificationLog] and returns the resulting row.
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
  /// The returned [NotificationLog] will have its `id` field set.
  Future<NotificationLog?> upsertRow(
    _is.DatabaseSession session,
    NotificationLog row, {
    required _is.ColumnSelections<NotificationLogTable> conflictColumns,
    _is.ColumnSelections<NotificationLogTable>? updateColumns,
    _is.WhereExpressionBuilder<NotificationLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<NotificationLog>(
      row,
      conflictColumns: conflictColumns(NotificationLog.t),
      updateColumns: updateColumns?.call(NotificationLog.t),
      updateWhere: updateWhere?.call(NotificationLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [NotificationLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NotificationLog>> update(
    _is.DatabaseSession session,
    List<NotificationLog> rows, {
    _is.ColumnSelections<NotificationLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<NotificationLog>(
      rows,
      columns: columns?.call(NotificationLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [NotificationLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NotificationLog> updateRow(
    _is.DatabaseSession session,
    NotificationLog row, {
    _is.ColumnSelections<NotificationLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<NotificationLog>(
      row,
      columns: columns?.call(NotificationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NotificationLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<NotificationLogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<NotificationLog>(
      id,
      columnValues: columnValues(NotificationLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NotificationLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NotificationLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<NotificationLogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<NotificationLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<NotificationLog>(
      columnValues: columnValues(NotificationLog.t.updateTable),
      where: where(NotificationLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [NotificationLog]s in the list and returns the deleted rows.
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
  Future<List<NotificationLog>> delete(
    _is.DatabaseSession session,
    List<NotificationLog> rows, {
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<NotificationLog>(
      rows,
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [NotificationLog].
  Future<NotificationLog> deleteRow(
    _is.DatabaseSession session,
    NotificationLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NotificationLog>(
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
  Future<List<NotificationLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NotificationLogTable> where,
    _is.OrderByBuilder<NotificationLogTable>? orderBy,
    _is.OrderByListBuilder<NotificationLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<NotificationLog>(
      where: where(NotificationLog.t),
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<NotificationLog>(
      where: where?.call(NotificationLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NotificationLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NotificationLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NotificationLog>(
      where: where(NotificationLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
