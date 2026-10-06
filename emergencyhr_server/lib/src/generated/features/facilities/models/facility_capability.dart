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
import '../../../features/facilities/models/capability.dart' as _ilg1kmfo;

abstract class FacilityCapability
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FacilityCapability._({
    this.id,
    required this.facilityId,
    required this.capability,
  });

  factory FacilityCapability({
    int? id,
    required int facilityId,
    required _ilg1kmfo.Capability capability,
  }) = _FacilityCapabilityImpl;

  factory FacilityCapability.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityCapability(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      capability: _ilg1kmfo.Capability.fromJson(
        (jsonSerialization['capability'] as String),
      ),
    );
  }

  static final t = FacilityCapabilityTable();

  static const db = FacilityCapabilityRepository._();

  @override
  int? id;

  int facilityId;

  _ilg1kmfo.Capability capability;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FacilityCapability]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityCapability copyWith({
    int? id,
    int? facilityId,
    _ilg1kmfo.Capability? capability,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityCapability',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'capability': capability.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityCapability',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'capability': capability.toJson(),
    };
  }

  static FacilityCapabilityInclude include() {
    return FacilityCapabilityInclude._();
  }

  static FacilityCapabilityIncludeList includeList({
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    FacilityCapabilityInclude? include,
  }) {
    return FacilityCapabilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityCapabilityImpl extends FacilityCapability {
  _FacilityCapabilityImpl({
    int? id,
    required int facilityId,
    required _ilg1kmfo.Capability capability,
  }) : super._(
         id: id,
         facilityId: facilityId,
         capability: capability,
       );

  /// Returns a shallow copy of this [FacilityCapability]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityCapability copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _ilg1kmfo.Capability? capability,
  }) {
    return FacilityCapability(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      capability: capability ?? this.capability,
    );
  }
}

class FacilityCapabilityUpdateTable
    extends _is.UpdateTable<FacilityCapabilityTable> {
  FacilityCapabilityUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<_ilg1kmfo.Capability, _ilg1kmfo.Capability> capability(
    _ilg1kmfo.Capability value,
  ) => _is.ColumnValue(
    table.capability,
    value,
  );
}

class FacilityCapabilityTable extends _is.Table<int?> {
  FacilityCapabilityTable({super.tableRelation})
    : super(tableName: 'facility_capability') {
    updateTable = FacilityCapabilityUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    capability = _is.ColumnEnum(
      'capability',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final FacilityCapabilityUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnEnum<_ilg1kmfo.Capability> capability;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    capability,
  ];
}

class FacilityCapabilityInclude extends _is.IncludeObject {
  FacilityCapabilityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FacilityCapability.t;
}

class FacilityCapabilityIncludeList extends _is.IncludeList {
  FacilityCapabilityIncludeList._({
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FacilityCapability.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FacilityCapability.t;
}

class FacilityCapabilityRepository {
  const FacilityCapabilityRepository._();

  /// Returns a list of [FacilityCapability]s matching the given query parameters.
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
  Future<List<FacilityCapability>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FacilityCapability>(
      where: where?.call(FacilityCapability.t),
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FacilityCapability] matching the given query parameters.
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
  Future<FacilityCapability?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? where,
    int? offset,
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FacilityCapability>(
      where: where?.call(FacilityCapability.t),
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FacilityCapability] by its [id] or null if no such row exists.
  Future<FacilityCapability?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FacilityCapability>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FacilityCapability]s in the list and returns the inserted rows.
  ///
  /// The returned [FacilityCapability]s will have their `id` fields set.
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
  Future<List<FacilityCapability>> insert(
    _is.DatabaseSession session,
    List<FacilityCapability> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FacilityCapability>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FacilityCapability] and returns the inserted row.
  ///
  /// The returned [FacilityCapability] will have its `id` field set.
  Future<FacilityCapability> insertRow(
    _is.DatabaseSession session,
    FacilityCapability row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FacilityCapability>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FacilityCapability]s in the list and returns the resulting rows.
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
  /// The returned [FacilityCapability]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityCapability>> upsert(
    _is.DatabaseSession session,
    List<FacilityCapability> rows, {
    required _is.ColumnSelections<FacilityCapabilityTable> conflictColumns,
    _is.ColumnSelections<FacilityCapabilityTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FacilityCapability>(
      rows,
      conflictColumns: conflictColumns(FacilityCapability.t),
      updateColumns: updateColumns?.call(FacilityCapability.t),
      updateWhere: updateWhere?.call(FacilityCapability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FacilityCapability] and returns the resulting row.
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
  /// The returned [FacilityCapability] will have its `id` field set.
  Future<FacilityCapability?> upsertRow(
    _is.DatabaseSession session,
    FacilityCapability row, {
    required _is.ColumnSelections<FacilityCapabilityTable> conflictColumns,
    _is.ColumnSelections<FacilityCapabilityTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FacilityCapability>(
      row,
      conflictColumns: conflictColumns(FacilityCapability.t),
      updateColumns: updateColumns?.call(FacilityCapability.t),
      updateWhere: updateWhere?.call(FacilityCapability.t),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityCapability]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityCapability>> update(
    _is.DatabaseSession session,
    List<FacilityCapability> rows, {
    _is.ColumnSelections<FacilityCapabilityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FacilityCapability>(
      rows,
      columns: columns?.call(FacilityCapability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FacilityCapability]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FacilityCapability> updateRow(
    _is.DatabaseSession session,
    FacilityCapability row, {
    _is.ColumnSelections<FacilityCapabilityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FacilityCapability>(
      row,
      columns: columns?.call(FacilityCapability.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FacilityCapability] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FacilityCapability?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FacilityCapabilityUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FacilityCapability>(
      id,
      columnValues: columnValues(FacilityCapability.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityCapability]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityCapability>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FacilityCapabilityUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FacilityCapabilityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FacilityCapability>(
      columnValues: columnValues(FacilityCapability.t.updateTable),
      where: where(FacilityCapability.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FacilityCapability]s in the list and returns the deleted rows.
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
  Future<List<FacilityCapability>> delete(
    _is.DatabaseSession session,
    List<FacilityCapability> rows, {
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FacilityCapability>(
      rows,
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FacilityCapability].
  Future<FacilityCapability> deleteRow(
    _is.DatabaseSession session,
    FacilityCapability row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FacilityCapability>(
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
  Future<List<FacilityCapability>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityCapabilityTable> where,
    _is.OrderByBuilder<FacilityCapabilityTable>? orderBy,
    _is.OrderByListBuilder<FacilityCapabilityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FacilityCapability>(
      where: where(FacilityCapability.t),
      orderBy: orderBy?.call(FacilityCapability.t),
      orderByList: orderByList?.call(FacilityCapability.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityCapabilityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FacilityCapability>(
      where: where?.call(FacilityCapability.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FacilityCapability] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityCapabilityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FacilityCapability>(
      where: where(FacilityCapability.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
