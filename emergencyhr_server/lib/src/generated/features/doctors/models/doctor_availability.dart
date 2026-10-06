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

/// V2 only.
abstract class DoctorAvailability
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DoctorAvailability._({
    this.id,
    required this.doctorId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    bool? onlineNow,
  }) : onlineNow = onlineNow ?? false;

  factory DoctorAvailability({
    int? id,
    required int doctorId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    bool? onlineNow,
  }) = _DoctorAvailabilityImpl;

  factory DoctorAvailability.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoctorAvailability(
      id: jsonSerialization['id'] as int?,
      doctorId: jsonSerialization['doctorId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      onlineNow: jsonSerialization['onlineNow'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['onlineNow']),
    );
  }

  static final t = DoctorAvailabilityTable();

  static const db = DoctorAvailabilityRepository._();

  @override
  int? id;

  int doctorId;

  int weekday;

  int startMinute;

  int endMinute;

  bool onlineNow;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DoctorAvailability]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DoctorAvailability copyWith({
    int? id,
    int? doctorId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    bool? onlineNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoctorAvailability',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'onlineNow': onlineNow,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoctorAvailability',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'onlineNow': onlineNow,
    };
  }

  static DoctorAvailabilityInclude include() {
    return DoctorAvailabilityInclude._();
  }

  static DoctorAvailabilityIncludeList includeList({
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    DoctorAvailabilityInclude? include,
  }) {
    return DoctorAvailabilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoctorAvailabilityImpl extends DoctorAvailability {
  _DoctorAvailabilityImpl({
    int? id,
    required int doctorId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    bool? onlineNow,
  }) : super._(
         id: id,
         doctorId: doctorId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         onlineNow: onlineNow,
       );

  /// Returns a shallow copy of this [DoctorAvailability]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DoctorAvailability copyWith({
    Object? id = _Undefined,
    int? doctorId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    bool? onlineNow,
  }) {
    return DoctorAvailability(
      id: id is int? ? id : this.id,
      doctorId: doctorId ?? this.doctorId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      onlineNow: onlineNow ?? this.onlineNow,
    );
  }
}

class DoctorAvailabilityUpdateTable
    extends _is.UpdateTable<DoctorAvailabilityTable> {
  DoctorAvailabilityUpdateTable(super.table);

  _is.ColumnValue<int, int> doctorId(int value) => _is.ColumnValue(
    table.doctorId,
    value,
  );

  _is.ColumnValue<int, int> weekday(int value) => _is.ColumnValue(
    table.weekday,
    value,
  );

  _is.ColumnValue<int, int> startMinute(int value) => _is.ColumnValue(
    table.startMinute,
    value,
  );

  _is.ColumnValue<int, int> endMinute(int value) => _is.ColumnValue(
    table.endMinute,
    value,
  );

  _is.ColumnValue<bool, bool> onlineNow(bool value) => _is.ColumnValue(
    table.onlineNow,
    value,
  );
}

class DoctorAvailabilityTable extends _is.Table<int?> {
  DoctorAvailabilityTable({super.tableRelation})
    : super(tableName: 'doctor_availability') {
    updateTable = DoctorAvailabilityUpdateTable(this);
    doctorId = _is.ColumnInt(
      'doctorId',
      this,
    );
    weekday = _is.ColumnInt(
      'weekday',
      this,
    );
    startMinute = _is.ColumnInt(
      'startMinute',
      this,
    );
    endMinute = _is.ColumnInt(
      'endMinute',
      this,
    );
    onlineNow = _is.ColumnBool(
      'onlineNow',
      this,
      hasDefault: true,
    );
  }

  late final DoctorAvailabilityUpdateTable updateTable;

  late final _is.ColumnInt doctorId;

  late final _is.ColumnInt weekday;

  late final _is.ColumnInt startMinute;

  late final _is.ColumnInt endMinute;

  late final _is.ColumnBool onlineNow;

  @override
  List<_is.Column> get columns => [
    id,
    doctorId,
    weekday,
    startMinute,
    endMinute,
    onlineNow,
  ];
}

class DoctorAvailabilityInclude extends _is.IncludeObject {
  DoctorAvailabilityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DoctorAvailability.t;
}

class DoctorAvailabilityIncludeList extends _is.IncludeList {
  DoctorAvailabilityIncludeList._({
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DoctorAvailability.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DoctorAvailability.t;
}

class DoctorAvailabilityRepository {
  const DoctorAvailabilityRepository._();

  /// Returns a list of [DoctorAvailability]s matching the given query parameters.
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
  Future<List<DoctorAvailability>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DoctorAvailability>(
      where: where?.call(DoctorAvailability.t),
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DoctorAvailability] matching the given query parameters.
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
  Future<DoctorAvailability?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? where,
    int? offset,
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DoctorAvailability>(
      where: where?.call(DoctorAvailability.t),
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DoctorAvailability] by its [id] or null if no such row exists.
  Future<DoctorAvailability?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DoctorAvailability>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DoctorAvailability]s in the list and returns the inserted rows.
  ///
  /// The returned [DoctorAvailability]s will have their `id` fields set.
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
  Future<List<DoctorAvailability>> insert(
    _is.DatabaseSession session,
    List<DoctorAvailability> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DoctorAvailability>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DoctorAvailability] and returns the inserted row.
  ///
  /// The returned [DoctorAvailability] will have its `id` field set.
  Future<DoctorAvailability> insertRow(
    _is.DatabaseSession session,
    DoctorAvailability row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DoctorAvailability>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DoctorAvailability]s in the list and returns the resulting rows.
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
  /// The returned [DoctorAvailability]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorAvailability>> upsert(
    _is.DatabaseSession session,
    List<DoctorAvailability> rows, {
    required _is.ColumnSelections<DoctorAvailabilityTable> conflictColumns,
    _is.ColumnSelections<DoctorAvailabilityTable>? updateColumns,
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DoctorAvailability>(
      rows,
      conflictColumns: conflictColumns(DoctorAvailability.t),
      updateColumns: updateColumns?.call(DoctorAvailability.t),
      updateWhere: updateWhere?.call(DoctorAvailability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DoctorAvailability] and returns the resulting row.
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
  /// The returned [DoctorAvailability] will have its `id` field set.
  Future<DoctorAvailability?> upsertRow(
    _is.DatabaseSession session,
    DoctorAvailability row, {
    required _is.ColumnSelections<DoctorAvailabilityTable> conflictColumns,
    _is.ColumnSelections<DoctorAvailabilityTable>? updateColumns,
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DoctorAvailability>(
      row,
      conflictColumns: conflictColumns(DoctorAvailability.t),
      updateColumns: updateColumns?.call(DoctorAvailability.t),
      updateWhere: updateWhere?.call(DoctorAvailability.t),
      transaction: transaction,
    );
  }

  /// Updates all [DoctorAvailability]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorAvailability>> update(
    _is.DatabaseSession session,
    List<DoctorAvailability> rows, {
    _is.ColumnSelections<DoctorAvailabilityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DoctorAvailability>(
      rows,
      columns: columns?.call(DoctorAvailability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DoctorAvailability]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DoctorAvailability> updateRow(
    _is.DatabaseSession session,
    DoctorAvailability row, {
    _is.ColumnSelections<DoctorAvailabilityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DoctorAvailability>(
      row,
      columns: columns?.call(DoctorAvailability.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DoctorAvailability] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DoctorAvailability?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DoctorAvailabilityUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DoctorAvailability>(
      id,
      columnValues: columnValues(DoctorAvailability.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DoctorAvailability]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorAvailability>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DoctorAvailabilityUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DoctorAvailabilityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DoctorAvailability>(
      columnValues: columnValues(DoctorAvailability.t.updateTable),
      where: where(DoctorAvailability.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DoctorAvailability]s in the list and returns the deleted rows.
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
  Future<List<DoctorAvailability>> delete(
    _is.DatabaseSession session,
    List<DoctorAvailability> rows, {
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DoctorAvailability>(
      rows,
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DoctorAvailability].
  Future<DoctorAvailability> deleteRow(
    _is.DatabaseSession session,
    DoctorAvailability row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DoctorAvailability>(
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
  Future<List<DoctorAvailability>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoctorAvailabilityTable> where,
    _is.OrderByBuilder<DoctorAvailabilityTable>? orderBy,
    _is.OrderByListBuilder<DoctorAvailabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DoctorAvailability>(
      where: where(DoctorAvailability.t),
      orderBy: orderBy?.call(DoctorAvailability.t),
      orderByList: orderByList?.call(DoctorAvailability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorAvailabilityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DoctorAvailability>(
      where: where?.call(DoctorAvailability.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DoctorAvailability] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoctorAvailabilityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DoctorAvailability>(
      where: where(DoctorAvailability.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
