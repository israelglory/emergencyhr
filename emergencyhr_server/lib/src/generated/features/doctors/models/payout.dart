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
import '../../../features/doctors/models/payout_status.dart' as _i7nd3nn3;

/// V2 only.
abstract class Payout implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Payout._({
    this.id,
    required this.doctorId,
    required this.amountNgn,
    required this.commissionNgn,
    required this.status,
    this.providerRef,
  });

  factory Payout({
    int? id,
    required int doctorId,
    required int amountNgn,
    required int commissionNgn,
    required _i7nd3nn3.PayoutStatus status,
    String? providerRef,
  }) = _PayoutImpl;

  factory Payout.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payout(
      id: jsonSerialization['id'] as int?,
      doctorId: jsonSerialization['doctorId'] as int,
      amountNgn: jsonSerialization['amountNgn'] as int,
      commissionNgn: jsonSerialization['commissionNgn'] as int,
      status: _i7nd3nn3.PayoutStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      providerRef: jsonSerialization['providerRef'] as String?,
    );
  }

  static final t = PayoutTable();

  static const db = PayoutRepository._();

  @override
  int? id;

  int doctorId;

  int amountNgn;

  int commissionNgn;

  _i7nd3nn3.PayoutStatus status;

  String? providerRef;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Payout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Payout copyWith({
    int? id,
    int? doctorId,
    int? amountNgn,
    int? commissionNgn,
    _i7nd3nn3.PayoutStatus? status,
    String? providerRef,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payout',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'amountNgn': amountNgn,
      'commissionNgn': commissionNgn,
      'status': status.toJson(),
      if (providerRef != null) 'providerRef': providerRef,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payout',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'amountNgn': amountNgn,
      'commissionNgn': commissionNgn,
      'status': status.toJson(),
      if (providerRef != null) 'providerRef': providerRef,
    };
  }

  static PayoutInclude include() {
    return PayoutInclude._();
  }

  static PayoutIncludeList includeList({
    _is.WhereExpressionBuilder<PayoutTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    PayoutInclude? include,
  }) {
    return PayoutIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PayoutImpl extends Payout {
  _PayoutImpl({
    int? id,
    required int doctorId,
    required int amountNgn,
    required int commissionNgn,
    required _i7nd3nn3.PayoutStatus status,
    String? providerRef,
  }) : super._(
         id: id,
         doctorId: doctorId,
         amountNgn: amountNgn,
         commissionNgn: commissionNgn,
         status: status,
         providerRef: providerRef,
       );

  /// Returns a shallow copy of this [Payout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Payout copyWith({
    Object? id = _Undefined,
    int? doctorId,
    int? amountNgn,
    int? commissionNgn,
    _i7nd3nn3.PayoutStatus? status,
    Object? providerRef = _Undefined,
  }) {
    return Payout(
      id: id is int? ? id : this.id,
      doctorId: doctorId ?? this.doctorId,
      amountNgn: amountNgn ?? this.amountNgn,
      commissionNgn: commissionNgn ?? this.commissionNgn,
      status: status ?? this.status,
      providerRef: providerRef is String? ? providerRef : this.providerRef,
    );
  }
}

class PayoutUpdateTable extends _is.UpdateTable<PayoutTable> {
  PayoutUpdateTable(super.table);

  _is.ColumnValue<int, int> doctorId(int value) => _is.ColumnValue(
    table.doctorId,
    value,
  );

  _is.ColumnValue<int, int> amountNgn(int value) => _is.ColumnValue(
    table.amountNgn,
    value,
  );

  _is.ColumnValue<int, int> commissionNgn(int value) => _is.ColumnValue(
    table.commissionNgn,
    value,
  );

  _is.ColumnValue<_i7nd3nn3.PayoutStatus, _i7nd3nn3.PayoutStatus> status(
    _i7nd3nn3.PayoutStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> providerRef(String? value) => _is.ColumnValue(
    table.providerRef,
    value,
  );
}

class PayoutTable extends _is.Table<int?> {
  PayoutTable({super.tableRelation}) : super(tableName: 'payout') {
    updateTable = PayoutUpdateTable(this);
    doctorId = _is.ColumnInt(
      'doctorId',
      this,
    );
    amountNgn = _is.ColumnInt(
      'amountNgn',
      this,
    );
    commissionNgn = _is.ColumnInt(
      'commissionNgn',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    providerRef = _is.ColumnString(
      'providerRef',
      this,
    );
  }

  late final PayoutUpdateTable updateTable;

  late final _is.ColumnInt doctorId;

  late final _is.ColumnInt amountNgn;

  late final _is.ColumnInt commissionNgn;

  late final _is.ColumnEnum<_i7nd3nn3.PayoutStatus> status;

  late final _is.ColumnString providerRef;

  @override
  List<_is.Column> get columns => [
    id,
    doctorId,
    amountNgn,
    commissionNgn,
    status,
    providerRef,
  ];
}

class PayoutInclude extends _is.IncludeObject {
  PayoutInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Payout.t;
}

class PayoutIncludeList extends _is.IncludeList {
  PayoutIncludeList._({
    _is.WhereExpressionBuilder<PayoutTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Payout.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Payout.t;
}

class PayoutRepository {
  const PayoutRepository._();

  /// Returns a list of [Payout]s matching the given query parameters.
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
  Future<List<Payout>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PayoutTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Payout>(
      where: where?.call(Payout.t),
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Payout] matching the given query parameters.
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
  Future<Payout?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PayoutTable>? where,
    int? offset,
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Payout>(
      where: where?.call(Payout.t),
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Payout] by its [id] or null if no such row exists.
  Future<Payout?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Payout>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Payout]s in the list and returns the inserted rows.
  ///
  /// The returned [Payout]s will have their `id` fields set.
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
  Future<List<Payout>> insert(
    _is.DatabaseSession session,
    List<Payout> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Payout>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Payout] and returns the inserted row.
  ///
  /// The returned [Payout] will have its `id` field set.
  Future<Payout> insertRow(
    _is.DatabaseSession session,
    Payout row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Payout>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Payout]s in the list and returns the resulting rows.
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
  /// The returned [Payout]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payout>> upsert(
    _is.DatabaseSession session,
    List<Payout> rows, {
    required _is.ColumnSelections<PayoutTable> conflictColumns,
    _is.ColumnSelections<PayoutTable>? updateColumns,
    _is.WhereExpressionBuilder<PayoutTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Payout>(
      rows,
      conflictColumns: conflictColumns(Payout.t),
      updateColumns: updateColumns?.call(Payout.t),
      updateWhere: updateWhere?.call(Payout.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Payout] and returns the resulting row.
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
  /// The returned [Payout] will have its `id` field set.
  Future<Payout?> upsertRow(
    _is.DatabaseSession session,
    Payout row, {
    required _is.ColumnSelections<PayoutTable> conflictColumns,
    _is.ColumnSelections<PayoutTable>? updateColumns,
    _is.WhereExpressionBuilder<PayoutTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Payout>(
      row,
      conflictColumns: conflictColumns(Payout.t),
      updateColumns: updateColumns?.call(Payout.t),
      updateWhere: updateWhere?.call(Payout.t),
      transaction: transaction,
    );
  }

  /// Updates all [Payout]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payout>> update(
    _is.DatabaseSession session,
    List<Payout> rows, {
    _is.ColumnSelections<PayoutTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Payout>(
      rows,
      columns: columns?.call(Payout.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Payout]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Payout> updateRow(
    _is.DatabaseSession session,
    Payout row, {
    _is.ColumnSelections<PayoutTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Payout>(
      row,
      columns: columns?.call(Payout.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payout] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Payout?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PayoutUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Payout>(
      id,
      columnValues: columnValues(Payout.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Payout]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Payout>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PayoutUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PayoutTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Payout>(
      columnValues: columnValues(Payout.t.updateTable),
      where: where(Payout.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Payout]s in the list and returns the deleted rows.
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
  Future<List<Payout>> delete(
    _is.DatabaseSession session,
    List<Payout> rows, {
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Payout>(
      rows,
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Payout].
  Future<Payout> deleteRow(
    _is.DatabaseSession session,
    Payout row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Payout>(
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
  Future<List<Payout>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PayoutTable> where,
    _is.OrderByBuilder<PayoutTable>? orderBy,
    _is.OrderByListBuilder<PayoutTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Payout>(
      where: where(Payout.t),
      orderBy: orderBy?.call(Payout.t),
      orderByList: orderByList?.call(Payout.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PayoutTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Payout>(
      where: where?.call(Payout.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Payout] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PayoutTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Payout>(
      where: where(Payout.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
