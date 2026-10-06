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
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;

abstract class OnboardingEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OnboardingEvent._({
    this.id,
    required this.facilityId,
    this.fromStage,
    required this.toStage,
    this.byUserId,
    this.note,
    required this.at,
  });

  factory OnboardingEvent({
    int? id,
    required int facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    required _ibrba1hx.OnboardingStage toStage,
    int? byUserId,
    String? note,
    required DateTime at,
  }) = _OnboardingEventImpl;

  factory OnboardingEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return OnboardingEvent(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      fromStage: jsonSerialization['fromStage'] == null
          ? null
          : _ibrba1hx.OnboardingStage.fromJson(
              (jsonSerialization['fromStage'] as String),
            ),
      toStage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['toStage'] as String),
      ),
      byUserId: jsonSerialization['byUserId'] as int?,
      note: jsonSerialization['note'] as String?,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  static final t = OnboardingEventTable();

  static const db = OnboardingEventRepository._();

  @override
  int? id;

  int facilityId;

  _ibrba1hx.OnboardingStage? fromStage;

  _ibrba1hx.OnboardingStage toStage;

  int? byUserId;

  String? note;

  DateTime at;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OnboardingEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OnboardingEvent copyWith({
    int? id,
    int? facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    _ibrba1hx.OnboardingStage? toStage,
    int? byUserId,
    String? note,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnboardingEvent',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (fromStage != null) 'fromStage': fromStage?.toJson(),
      'toStage': toStage.toJson(),
      if (byUserId != null) 'byUserId': byUserId,
      if (note != null) 'note': note,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnboardingEvent',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (fromStage != null) 'fromStage': fromStage?.toJson(),
      'toStage': toStage.toJson(),
      if (byUserId != null) 'byUserId': byUserId,
      if (note != null) 'note': note,
      'at': at.toJson(),
    };
  }

  static OnboardingEventInclude include() {
    return OnboardingEventInclude._();
  }

  static OnboardingEventIncludeList includeList({
    _is.WhereExpressionBuilder<OnboardingEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    OnboardingEventInclude? include,
  }) {
    return OnboardingEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnboardingEventImpl extends OnboardingEvent {
  _OnboardingEventImpl({
    int? id,
    required int facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    required _ibrba1hx.OnboardingStage toStage,
    int? byUserId,
    String? note,
    required DateTime at,
  }) : super._(
         id: id,
         facilityId: facilityId,
         fromStage: fromStage,
         toStage: toStage,
         byUserId: byUserId,
         note: note,
         at: at,
       );

  /// Returns a shallow copy of this [OnboardingEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OnboardingEvent copyWith({
    Object? id = _Undefined,
    int? facilityId,
    Object? fromStage = _Undefined,
    _ibrba1hx.OnboardingStage? toStage,
    Object? byUserId = _Undefined,
    Object? note = _Undefined,
    DateTime? at,
  }) {
    return OnboardingEvent(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      fromStage: fromStage is _ibrba1hx.OnboardingStage?
          ? fromStage
          : this.fromStage,
      toStage: toStage ?? this.toStage,
      byUserId: byUserId is int? ? byUserId : this.byUserId,
      note: note is String? ? note : this.note,
      at: at ?? this.at,
    );
  }
}

class OnboardingEventUpdateTable extends _is.UpdateTable<OnboardingEventTable> {
  OnboardingEventUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<_ibrba1hx.OnboardingStage, _ibrba1hx.OnboardingStage>
  fromStage(_ibrba1hx.OnboardingStage? value) => _is.ColumnValue(
    table.fromStage,
    value,
  );

  _is.ColumnValue<_ibrba1hx.OnboardingStage, _ibrba1hx.OnboardingStage> toStage(
    _ibrba1hx.OnboardingStage value,
  ) => _is.ColumnValue(
    table.toStage,
    value,
  );

  _is.ColumnValue<int, int> byUserId(int? value) => _is.ColumnValue(
    table.byUserId,
    value,
  );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );
}

class OnboardingEventTable extends _is.Table<int?> {
  OnboardingEventTable({super.tableRelation})
    : super(tableName: 'onboarding_event') {
    updateTable = OnboardingEventUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    fromStage = _is.ColumnEnum(
      'fromStage',
      this,
      _is.EnumSerialization.byName,
    );
    toStage = _is.ColumnEnum(
      'toStage',
      this,
      _is.EnumSerialization.byName,
    );
    byUserId = _is.ColumnInt(
      'byUserId',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
    );
  }

  late final OnboardingEventUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnEnum<_ibrba1hx.OnboardingStage> fromStage;

  late final _is.ColumnEnum<_ibrba1hx.OnboardingStage> toStage;

  late final _is.ColumnInt byUserId;

  late final _is.ColumnString note;

  late final _is.ColumnDateTime at;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    fromStage,
    toStage,
    byUserId,
    note,
    at,
  ];
}

class OnboardingEventInclude extends _is.IncludeObject {
  OnboardingEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OnboardingEvent.t;
}

class OnboardingEventIncludeList extends _is.IncludeList {
  OnboardingEventIncludeList._({
    _is.WhereExpressionBuilder<OnboardingEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OnboardingEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OnboardingEvent.t;
}

class OnboardingEventRepository {
  const OnboardingEventRepository._();

  /// Returns a list of [OnboardingEvent]s matching the given query parameters.
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
  Future<List<OnboardingEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OnboardingEvent>(
      where: where?.call(OnboardingEvent.t),
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OnboardingEvent] matching the given query parameters.
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
  Future<OnboardingEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingEventTable>? where,
    int? offset,
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OnboardingEvent>(
      where: where?.call(OnboardingEvent.t),
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OnboardingEvent] by its [id] or null if no such row exists.
  Future<OnboardingEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OnboardingEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OnboardingEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [OnboardingEvent]s will have their `id` fields set.
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
  Future<List<OnboardingEvent>> insert(
    _is.DatabaseSession session,
    List<OnboardingEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OnboardingEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OnboardingEvent] and returns the inserted row.
  ///
  /// The returned [OnboardingEvent] will have its `id` field set.
  Future<OnboardingEvent> insertRow(
    _is.DatabaseSession session,
    OnboardingEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OnboardingEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OnboardingEvent]s in the list and returns the resulting rows.
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
  /// The returned [OnboardingEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingEvent>> upsert(
    _is.DatabaseSession session,
    List<OnboardingEvent> rows, {
    required _is.ColumnSelections<OnboardingEventTable> conflictColumns,
    _is.ColumnSelections<OnboardingEventTable>? updateColumns,
    _is.WhereExpressionBuilder<OnboardingEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OnboardingEvent>(
      rows,
      conflictColumns: conflictColumns(OnboardingEvent.t),
      updateColumns: updateColumns?.call(OnboardingEvent.t),
      updateWhere: updateWhere?.call(OnboardingEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OnboardingEvent] and returns the resulting row.
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
  /// The returned [OnboardingEvent] will have its `id` field set.
  Future<OnboardingEvent?> upsertRow(
    _is.DatabaseSession session,
    OnboardingEvent row, {
    required _is.ColumnSelections<OnboardingEventTable> conflictColumns,
    _is.ColumnSelections<OnboardingEventTable>? updateColumns,
    _is.WhereExpressionBuilder<OnboardingEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OnboardingEvent>(
      row,
      conflictColumns: conflictColumns(OnboardingEvent.t),
      updateColumns: updateColumns?.call(OnboardingEvent.t),
      updateWhere: updateWhere?.call(OnboardingEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [OnboardingEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingEvent>> update(
    _is.DatabaseSession session,
    List<OnboardingEvent> rows, {
    _is.ColumnSelections<OnboardingEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OnboardingEvent>(
      rows,
      columns: columns?.call(OnboardingEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OnboardingEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OnboardingEvent> updateRow(
    _is.DatabaseSession session,
    OnboardingEvent row, {
    _is.ColumnSelections<OnboardingEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OnboardingEvent>(
      row,
      columns: columns?.call(OnboardingEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OnboardingEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OnboardingEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OnboardingEventUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OnboardingEvent>(
      id,
      columnValues: columnValues(OnboardingEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OnboardingEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OnboardingEventUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<OnboardingEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OnboardingEvent>(
      columnValues: columnValues(OnboardingEvent.t.updateTable),
      where: where(OnboardingEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OnboardingEvent]s in the list and returns the deleted rows.
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
  Future<List<OnboardingEvent>> delete(
    _is.DatabaseSession session,
    List<OnboardingEvent> rows, {
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OnboardingEvent>(
      rows,
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OnboardingEvent].
  Future<OnboardingEvent> deleteRow(
    _is.DatabaseSession session,
    OnboardingEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OnboardingEvent>(
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
  Future<List<OnboardingEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OnboardingEventTable> where,
    _is.OrderByBuilder<OnboardingEventTable>? orderBy,
    _is.OrderByListBuilder<OnboardingEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OnboardingEvent>(
      where: where(OnboardingEvent.t),
      orderBy: orderBy?.call(OnboardingEvent.t),
      orderByList: orderByList?.call(OnboardingEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OnboardingEvent>(
      where: where?.call(OnboardingEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OnboardingEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OnboardingEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OnboardingEvent>(
      where: where(OnboardingEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
