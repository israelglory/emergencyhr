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
import '../../../features/doctors/models/consultation_status.dart' as _iuk5krsu;

/// V2 only.
abstract class Consultation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Consultation._({
    this.id,
    required this.userId,
    required this.doctorId,
    required this.status,
    required this.feeNgn,
    this.startedAt,
    this.endedAt,
    this.note,
  });

  factory Consultation({
    int? id,
    required int userId,
    required int doctorId,
    required _iuk5krsu.ConsultationStatus status,
    required int feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  }) = _ConsultationImpl;

  factory Consultation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Consultation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      doctorId: jsonSerialization['doctorId'] as int,
      status: _iuk5krsu.ConsultationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      feeNgn: jsonSerialization['feeNgn'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      note: jsonSerialization['note'] as String?,
    );
  }

  static final t = ConsultationTable();

  static const db = ConsultationRepository._();

  @override
  int? id;

  int userId;

  int doctorId;

  _iuk5krsu.ConsultationStatus status;

  int feeNgn;

  DateTime? startedAt;

  DateTime? endedAt;

  String? note;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Consultation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Consultation copyWith({
    int? id,
    int? userId,
    int? doctorId,
    _iuk5krsu.ConsultationStatus? status,
    int? feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Consultation',
      if (id != null) 'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'status': status.toJson(),
      'feeNgn': feeNgn,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Consultation',
      if (id != null) 'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'status': status.toJson(),
      'feeNgn': feeNgn,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  static ConsultationInclude include() {
    return ConsultationInclude._();
  }

  static ConsultationIncludeList includeList({
    _is.WhereExpressionBuilder<ConsultationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    ConsultationInclude? include,
  }) {
    return ConsultationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConsultationImpl extends Consultation {
  _ConsultationImpl({
    int? id,
    required int userId,
    required int doctorId,
    required _iuk5krsu.ConsultationStatus status,
    required int feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  }) : super._(
         id: id,
         userId: userId,
         doctorId: doctorId,
         status: status,
         feeNgn: feeNgn,
         startedAt: startedAt,
         endedAt: endedAt,
         note: note,
       );

  /// Returns a shallow copy of this [Consultation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Consultation copyWith({
    Object? id = _Undefined,
    int? userId,
    int? doctorId,
    _iuk5krsu.ConsultationStatus? status,
    int? feeNgn,
    Object? startedAt = _Undefined,
    Object? endedAt = _Undefined,
    Object? note = _Undefined,
  }) {
    return Consultation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      status: status ?? this.status,
      feeNgn: feeNgn ?? this.feeNgn,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      note: note is String? ? note : this.note,
    );
  }
}

class ConsultationUpdateTable extends _is.UpdateTable<ConsultationTable> {
  ConsultationUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> doctorId(int value) => _is.ColumnValue(
    table.doctorId,
    value,
  );

  _is.ColumnValue<_iuk5krsu.ConsultationStatus, _iuk5krsu.ConsultationStatus>
  status(_iuk5krsu.ConsultationStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> feeNgn(int value) => _is.ColumnValue(
    table.feeNgn,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _is.ColumnValue(
        table.endedAt,
        value,
      );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );
}

class ConsultationTable extends _is.Table<int?> {
  ConsultationTable({super.tableRelation}) : super(tableName: 'consultation') {
    updateTable = ConsultationUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    doctorId = _is.ColumnInt(
      'doctorId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    feeNgn = _is.ColumnInt(
      'feeNgn',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    endedAt = _is.ColumnDateTime(
      'endedAt',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
  }

  late final ConsultationUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt doctorId;

  late final _is.ColumnEnum<_iuk5krsu.ConsultationStatus> status;

  late final _is.ColumnInt feeNgn;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime endedAt;

  late final _is.ColumnString note;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    doctorId,
    status,
    feeNgn,
    startedAt,
    endedAt,
    note,
  ];
}

class ConsultationInclude extends _is.IncludeObject {
  ConsultationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Consultation.t;
}

class ConsultationIncludeList extends _is.IncludeList {
  ConsultationIncludeList._({
    _is.WhereExpressionBuilder<ConsultationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Consultation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Consultation.t;
}

class ConsultationRepository {
  const ConsultationRepository._();

  /// Returns a list of [Consultation]s matching the given query parameters.
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
  Future<List<Consultation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConsultationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Consultation>(
      where: where?.call(Consultation.t),
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Consultation] matching the given query parameters.
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
  Future<Consultation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConsultationTable>? where,
    int? offset,
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Consultation>(
      where: where?.call(Consultation.t),
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Consultation] by its [id] or null if no such row exists.
  Future<Consultation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Consultation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Consultation]s in the list and returns the inserted rows.
  ///
  /// The returned [Consultation]s will have their `id` fields set.
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
  Future<List<Consultation>> insert(
    _is.DatabaseSession session,
    List<Consultation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Consultation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Consultation] and returns the inserted row.
  ///
  /// The returned [Consultation] will have its `id` field set.
  Future<Consultation> insertRow(
    _is.DatabaseSession session,
    Consultation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Consultation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Consultation]s in the list and returns the resulting rows.
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
  /// The returned [Consultation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Consultation>> upsert(
    _is.DatabaseSession session,
    List<Consultation> rows, {
    required _is.ColumnSelections<ConsultationTable> conflictColumns,
    _is.ColumnSelections<ConsultationTable>? updateColumns,
    _is.WhereExpressionBuilder<ConsultationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Consultation>(
      rows,
      conflictColumns: conflictColumns(Consultation.t),
      updateColumns: updateColumns?.call(Consultation.t),
      updateWhere: updateWhere?.call(Consultation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Consultation] and returns the resulting row.
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
  /// The returned [Consultation] will have its `id` field set.
  Future<Consultation?> upsertRow(
    _is.DatabaseSession session,
    Consultation row, {
    required _is.ColumnSelections<ConsultationTable> conflictColumns,
    _is.ColumnSelections<ConsultationTable>? updateColumns,
    _is.WhereExpressionBuilder<ConsultationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Consultation>(
      row,
      conflictColumns: conflictColumns(Consultation.t),
      updateColumns: updateColumns?.call(Consultation.t),
      updateWhere: updateWhere?.call(Consultation.t),
      transaction: transaction,
    );
  }

  /// Updates all [Consultation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Consultation>> update(
    _is.DatabaseSession session,
    List<Consultation> rows, {
    _is.ColumnSelections<ConsultationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Consultation>(
      rows,
      columns: columns?.call(Consultation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Consultation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Consultation> updateRow(
    _is.DatabaseSession session,
    Consultation row, {
    _is.ColumnSelections<ConsultationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Consultation>(
      row,
      columns: columns?.call(Consultation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Consultation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Consultation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ConsultationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Consultation>(
      id,
      columnValues: columnValues(Consultation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Consultation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Consultation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ConsultationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ConsultationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Consultation>(
      columnValues: columnValues(Consultation.t.updateTable),
      where: where(Consultation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Consultation]s in the list and returns the deleted rows.
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
  Future<List<Consultation>> delete(
    _is.DatabaseSession session,
    List<Consultation> rows, {
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Consultation>(
      rows,
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Consultation].
  Future<Consultation> deleteRow(
    _is.DatabaseSession session,
    Consultation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Consultation>(
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
  Future<List<Consultation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConsultationTable> where,
    _is.OrderByBuilder<ConsultationTable>? orderBy,
    _is.OrderByListBuilder<ConsultationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Consultation>(
      where: where(Consultation.t),
      orderBy: orderBy?.call(Consultation.t),
      orderByList: orderByList?.call(Consultation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConsultationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Consultation>(
      where: where?.call(Consultation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Consultation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConsultationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Consultation>(
      where: where(Consultation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
