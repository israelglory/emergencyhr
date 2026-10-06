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

abstract class OnboardingRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OnboardingRecord._({
    this.id,
    required this.facilityId,
    required this.stage,
    this.assignedAgentUserId,
    this.notes,
    this.nextActionAt,
    this.submittedAt,
    this.submittedByUserId,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory OnboardingRecord({
    int? id,
    required int facilityId,
    required _ibrba1hx.OnboardingStage stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  }) = _OnboardingRecordImpl;

  factory OnboardingRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OnboardingRecord(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      stage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      assignedAgentUserId: jsonSerialization['assignedAgentUserId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      nextActionAt: jsonSerialization['nextActionAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextActionAt'],
            ),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      submittedByUserId: jsonSerialization['submittedByUserId'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = OnboardingRecordTable();

  static const db = OnboardingRecordRepository._();

  @override
  int? id;

  int facilityId;

  _ibrba1hx.OnboardingStage stage;

  int? assignedAgentUserId;

  String? notes;

  DateTime? nextActionAt;

  DateTime? submittedAt;

  int? submittedByUserId;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OnboardingRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OnboardingRecord copyWith({
    int? id,
    int? facilityId,
    _ibrba1hx.OnboardingStage? stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnboardingRecord',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'stage': stage.toJson(),
      if (assignedAgentUserId != null)
        'assignedAgentUserId': assignedAgentUserId,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByUserId != null) 'submittedByUserId': submittedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnboardingRecord',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'stage': stage.toJson(),
      if (assignedAgentUserId != null)
        'assignedAgentUserId': assignedAgentUserId,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByUserId != null) 'submittedByUserId': submittedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OnboardingRecordInclude include() {
    return OnboardingRecordInclude._();
  }

  static OnboardingRecordIncludeList includeList({
    _is.WhereExpressionBuilder<OnboardingRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    OnboardingRecordInclude? include,
  }) {
    return OnboardingRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnboardingRecordImpl extends OnboardingRecord {
  _OnboardingRecordImpl({
    int? id,
    required int facilityId,
    required _ibrba1hx.OnboardingStage stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         stage: stage,
         assignedAgentUserId: assignedAgentUserId,
         notes: notes,
         nextActionAt: nextActionAt,
         submittedAt: submittedAt,
         submittedByUserId: submittedByUserId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OnboardingRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OnboardingRecord copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _ibrba1hx.OnboardingStage? stage,
    Object? assignedAgentUserId = _Undefined,
    Object? notes = _Undefined,
    Object? nextActionAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? submittedByUserId = _Undefined,
    DateTime? updatedAt,
  }) {
    return OnboardingRecord(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      stage: stage ?? this.stage,
      assignedAgentUserId: assignedAgentUserId is int?
          ? assignedAgentUserId
          : this.assignedAgentUserId,
      notes: notes is String? ? notes : this.notes,
      nextActionAt: nextActionAt is DateTime?
          ? nextActionAt
          : this.nextActionAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      submittedByUserId: submittedByUserId is int?
          ? submittedByUserId
          : this.submittedByUserId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OnboardingRecordUpdateTable
    extends _is.UpdateTable<OnboardingRecordTable> {
  OnboardingRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<_ibrba1hx.OnboardingStage, _ibrba1hx.OnboardingStage> stage(
    _ibrba1hx.OnboardingStage value,
  ) => _is.ColumnValue(
    table.stage,
    value,
  );

  _is.ColumnValue<int, int> assignedAgentUserId(int? value) => _is.ColumnValue(
    table.assignedAgentUserId,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> nextActionAt(DateTime? value) =>
      _is.ColumnValue(
        table.nextActionAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> submittedAt(DateTime? value) =>
      _is.ColumnValue(
        table.submittedAt,
        value,
      );

  _is.ColumnValue<int, int> submittedByUserId(int? value) => _is.ColumnValue(
    table.submittedByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class OnboardingRecordTable extends _is.Table<int?> {
  OnboardingRecordTable({super.tableRelation})
    : super(tableName: 'onboarding_record') {
    updateTable = OnboardingRecordUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    stage = _is.ColumnEnum(
      'stage',
      this,
      _is.EnumSerialization.byName,
    );
    assignedAgentUserId = _is.ColumnInt(
      'assignedAgentUserId',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    nextActionAt = _is.ColumnDateTime(
      'nextActionAt',
      this,
    );
    submittedAt = _is.ColumnDateTime(
      'submittedAt',
      this,
    );
    submittedByUserId = _is.ColumnInt(
      'submittedByUserId',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final OnboardingRecordUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnEnum<_ibrba1hx.OnboardingStage> stage;

  late final _is.ColumnInt assignedAgentUserId;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime nextActionAt;

  late final _is.ColumnDateTime submittedAt;

  late final _is.ColumnInt submittedByUserId;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    stage,
    assignedAgentUserId,
    notes,
    nextActionAt,
    submittedAt,
    submittedByUserId,
    updatedAt,
  ];
}

class OnboardingRecordInclude extends _is.IncludeObject {
  OnboardingRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OnboardingRecord.t;
}

class OnboardingRecordIncludeList extends _is.IncludeList {
  OnboardingRecordIncludeList._({
    _is.WhereExpressionBuilder<OnboardingRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OnboardingRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OnboardingRecord.t;
}

class OnboardingRecordRepository {
  const OnboardingRecordRepository._();

  /// Returns a list of [OnboardingRecord]s matching the given query parameters.
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
  Future<List<OnboardingRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OnboardingRecord>(
      where: where?.call(OnboardingRecord.t),
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OnboardingRecord] matching the given query parameters.
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
  Future<OnboardingRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OnboardingRecord>(
      where: where?.call(OnboardingRecord.t),
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OnboardingRecord] by its [id] or null if no such row exists.
  Future<OnboardingRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OnboardingRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OnboardingRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [OnboardingRecord]s will have their `id` fields set.
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
  Future<List<OnboardingRecord>> insert(
    _is.DatabaseSession session,
    List<OnboardingRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OnboardingRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OnboardingRecord] and returns the inserted row.
  ///
  /// The returned [OnboardingRecord] will have its `id` field set.
  Future<OnboardingRecord> insertRow(
    _is.DatabaseSession session,
    OnboardingRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OnboardingRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OnboardingRecord]s in the list and returns the resulting rows.
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
  /// The returned [OnboardingRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingRecord>> upsert(
    _is.DatabaseSession session,
    List<OnboardingRecord> rows, {
    required _is.ColumnSelections<OnboardingRecordTable> conflictColumns,
    _is.ColumnSelections<OnboardingRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<OnboardingRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OnboardingRecord>(
      rows,
      conflictColumns: conflictColumns(OnboardingRecord.t),
      updateColumns: updateColumns?.call(OnboardingRecord.t),
      updateWhere: updateWhere?.call(OnboardingRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OnboardingRecord] and returns the resulting row.
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
  /// The returned [OnboardingRecord] will have its `id` field set.
  Future<OnboardingRecord?> upsertRow(
    _is.DatabaseSession session,
    OnboardingRecord row, {
    required _is.ColumnSelections<OnboardingRecordTable> conflictColumns,
    _is.ColumnSelections<OnboardingRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<OnboardingRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OnboardingRecord>(
      row,
      conflictColumns: conflictColumns(OnboardingRecord.t),
      updateColumns: updateColumns?.call(OnboardingRecord.t),
      updateWhere: updateWhere?.call(OnboardingRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [OnboardingRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingRecord>> update(
    _is.DatabaseSession session,
    List<OnboardingRecord> rows, {
    _is.ColumnSelections<OnboardingRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OnboardingRecord>(
      rows,
      columns: columns?.call(OnboardingRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OnboardingRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OnboardingRecord> updateRow(
    _is.DatabaseSession session,
    OnboardingRecord row, {
    _is.ColumnSelections<OnboardingRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OnboardingRecord>(
      row,
      columns: columns?.call(OnboardingRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OnboardingRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OnboardingRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OnboardingRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OnboardingRecord>(
      id,
      columnValues: columnValues(OnboardingRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OnboardingRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OnboardingRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OnboardingRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<OnboardingRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OnboardingRecord>(
      columnValues: columnValues(OnboardingRecord.t.updateTable),
      where: where(OnboardingRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OnboardingRecord]s in the list and returns the deleted rows.
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
  Future<List<OnboardingRecord>> delete(
    _is.DatabaseSession session,
    List<OnboardingRecord> rows, {
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OnboardingRecord>(
      rows,
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OnboardingRecord].
  Future<OnboardingRecord> deleteRow(
    _is.DatabaseSession session,
    OnboardingRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OnboardingRecord>(
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
  Future<List<OnboardingRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OnboardingRecordTable> where,
    _is.OrderByBuilder<OnboardingRecordTable>? orderBy,
    _is.OrderByListBuilder<OnboardingRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OnboardingRecord>(
      where: where(OnboardingRecord.t),
      orderBy: orderBy?.call(OnboardingRecord.t),
      orderByList: orderByList?.call(OnboardingRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OnboardingRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OnboardingRecord>(
      where: where?.call(OnboardingRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OnboardingRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OnboardingRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OnboardingRecord>(
      where: where(OnboardingRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
