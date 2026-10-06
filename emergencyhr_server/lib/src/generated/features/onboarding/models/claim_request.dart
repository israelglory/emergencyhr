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
import 'package:emergencyhr_server/src/generated/protocol.dart' as _ilvcm0hz;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/onboarding/models/claim_status.dart' as _iya0t7il;

abstract class ClaimRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ClaimRequest._({
    this.id,
    required this.facilityId,
    required this.userId,
    required this.contactName,
    required this.documents,
    bool? deskPhoneVerified,
    required this.status,
    this.reviewedByUserId,
    this.reason,
    DateTime? createdAt,
    this.reviewedAt,
  }) : deskPhoneVerified = deskPhoneVerified ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ClaimRequest({
    int? id,
    required int facilityId,
    required int userId,
    required String contactName,
    required List<String> documents,
    bool? deskPhoneVerified,
    required _iya0t7il.ClaimStatus status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  }) = _ClaimRequestImpl;

  factory ClaimRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimRequest(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int,
      contactName: jsonSerialization['contactName'] as String,
      documents: _ilvcm0hz.Protocol().deserialize<List<String>>(
        jsonSerialization['documents'],
      ),
      deskPhoneVerified: jsonSerialization['deskPhoneVerified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['deskPhoneVerified'],
            ),
      status: _iya0t7il.ClaimStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
      reason: jsonSerialization['reason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  static final t = ClaimRequestTable();

  static const db = ClaimRequestRepository._();

  @override
  int? id;

  int facilityId;

  int userId;

  String contactName;

  /// Storage paths of uploaded documents.
  List<String> documents;

  bool deskPhoneVerified;

  _iya0t7il.ClaimStatus status;

  int? reviewedByUserId;

  String? reason;

  DateTime createdAt;

  DateTime? reviewedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClaimRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClaimRequest copyWith({
    int? id,
    int? facilityId,
    int? userId,
    String? contactName,
    List<String>? documents,
    bool? deskPhoneVerified,
    _iya0t7il.ClaimStatus? status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimRequest',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'userId': userId,
      'contactName': contactName,
      'documents': documents.toJson(),
      'deskPhoneVerified': deskPhoneVerified,
      'status': status.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimRequest',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'userId': userId,
      'contactName': contactName,
      'documents': documents.toJson(),
      'deskPhoneVerified': deskPhoneVerified,
      'status': status.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  static ClaimRequestInclude include() {
    return ClaimRequestInclude._();
  }

  static ClaimRequestIncludeList includeList({
    _is.WhereExpressionBuilder<ClaimRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    ClaimRequestInclude? include,
  }) {
    return ClaimRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClaimRequestImpl extends ClaimRequest {
  _ClaimRequestImpl({
    int? id,
    required int facilityId,
    required int userId,
    required String contactName,
    required List<String> documents,
    bool? deskPhoneVerified,
    required _iya0t7il.ClaimStatus status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         userId: userId,
         contactName: contactName,
         documents: documents,
         deskPhoneVerified: deskPhoneVerified,
         status: status,
         reviewedByUserId: reviewedByUserId,
         reason: reason,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [ClaimRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClaimRequest copyWith({
    Object? id = _Undefined,
    int? facilityId,
    int? userId,
    String? contactName,
    List<String>? documents,
    bool? deskPhoneVerified,
    _iya0t7il.ClaimStatus? status,
    Object? reviewedByUserId = _Undefined,
    Object? reason = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return ClaimRequest(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      userId: userId ?? this.userId,
      contactName: contactName ?? this.contactName,
      documents: documents ?? this.documents.map((e0) => e0).toList(),
      deskPhoneVerified: deskPhoneVerified ?? this.deskPhoneVerified,
      status: status ?? this.status,
      reviewedByUserId: reviewedByUserId is int?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}

class ClaimRequestUpdateTable extends _is.UpdateTable<ClaimRequestTable> {
  ClaimRequestUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> contactName(String value) => _is.ColumnValue(
    table.contactName,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> documents(List<String> value) =>
      _is.ColumnValue(
        table.documents,
        value,
      );

  _is.ColumnValue<bool, bool> deskPhoneVerified(bool value) => _is.ColumnValue(
    table.deskPhoneVerified,
    value,
  );

  _is.ColumnValue<_iya0t7il.ClaimStatus, _iya0t7il.ClaimStatus> status(
    _iya0t7il.ClaimStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> reviewedByUserId(int? value) => _is.ColumnValue(
    table.reviewedByUserId,
    value,
  );

  _is.ColumnValue<String, String> reason(String? value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _is.ColumnValue(
        table.reviewedAt,
        value,
      );
}

class ClaimRequestTable extends _is.Table<int?> {
  ClaimRequestTable({super.tableRelation}) : super(tableName: 'claim_request') {
    updateTable = ClaimRequestUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    contactName = _is.ColumnString(
      'contactName',
      this,
    );
    documents = _is.ColumnSerializable<List<String>>(
      'documents',
      this,
    );
    deskPhoneVerified = _is.ColumnBool(
      'deskPhoneVerified',
      this,
      hasDefault: true,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    reviewedByUserId = _is.ColumnInt(
      'reviewedByUserId',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    reviewedAt = _is.ColumnDateTime(
      'reviewedAt',
      this,
    );
  }

  late final ClaimRequestUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnInt userId;

  late final _is.ColumnString contactName;

  /// Storage paths of uploaded documents.
  late final _is.ColumnSerializable<List<String>> documents;

  late final _is.ColumnBool deskPhoneVerified;

  late final _is.ColumnEnum<_iya0t7il.ClaimStatus> status;

  late final _is.ColumnInt reviewedByUserId;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime reviewedAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    userId,
    contactName,
    documents,
    deskPhoneVerified,
    status,
    reviewedByUserId,
    reason,
    createdAt,
    reviewedAt,
  ];
}

class ClaimRequestInclude extends _is.IncludeObject {
  ClaimRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ClaimRequest.t;
}

class ClaimRequestIncludeList extends _is.IncludeList {
  ClaimRequestIncludeList._({
    _is.WhereExpressionBuilder<ClaimRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClaimRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ClaimRequest.t;
}

class ClaimRequestRepository {
  const ClaimRequestRepository._();

  /// Returns a list of [ClaimRequest]s matching the given query parameters.
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
  Future<List<ClaimRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ClaimRequest>(
      where: where?.call(ClaimRequest.t),
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ClaimRequest] matching the given query parameters.
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
  Future<ClaimRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ClaimRequest>(
      where: where?.call(ClaimRequest.t),
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ClaimRequest] by its [id] or null if no such row exists.
  Future<ClaimRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ClaimRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ClaimRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [ClaimRequest]s will have their `id` fields set.
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
  Future<List<ClaimRequest>> insert(
    _is.DatabaseSession session,
    List<ClaimRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ClaimRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ClaimRequest] and returns the inserted row.
  ///
  /// The returned [ClaimRequest] will have its `id` field set.
  Future<ClaimRequest> insertRow(
    _is.DatabaseSession session,
    ClaimRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClaimRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ClaimRequest]s in the list and returns the resulting rows.
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
  /// The returned [ClaimRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClaimRequest>> upsert(
    _is.DatabaseSession session,
    List<ClaimRequest> rows, {
    required _is.ColumnSelections<ClaimRequestTable> conflictColumns,
    _is.ColumnSelections<ClaimRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ClaimRequest>(
      rows,
      conflictColumns: conflictColumns(ClaimRequest.t),
      updateColumns: updateColumns?.call(ClaimRequest.t),
      updateWhere: updateWhere?.call(ClaimRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ClaimRequest] and returns the resulting row.
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
  /// The returned [ClaimRequest] will have its `id` field set.
  Future<ClaimRequest?> upsertRow(
    _is.DatabaseSession session,
    ClaimRequest row, {
    required _is.ColumnSelections<ClaimRequestTable> conflictColumns,
    _is.ColumnSelections<ClaimRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ClaimRequest>(
      row,
      conflictColumns: conflictColumns(ClaimRequest.t),
      updateColumns: updateColumns?.call(ClaimRequest.t),
      updateWhere: updateWhere?.call(ClaimRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [ClaimRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClaimRequest>> update(
    _is.DatabaseSession session,
    List<ClaimRequest> rows, {
    _is.ColumnSelections<ClaimRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ClaimRequest>(
      rows,
      columns: columns?.call(ClaimRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ClaimRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClaimRequest> updateRow(
    _is.DatabaseSession session,
    ClaimRequest row, {
    _is.ColumnSelections<ClaimRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClaimRequest>(
      row,
      columns: columns?.call(ClaimRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClaimRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClaimRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClaimRequestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ClaimRequest>(
      id,
      columnValues: columnValues(ClaimRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClaimRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClaimRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClaimRequestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ClaimRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ClaimRequest>(
      columnValues: columnValues(ClaimRequest.t.updateTable),
      where: where(ClaimRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ClaimRequest]s in the list and returns the deleted rows.
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
  Future<List<ClaimRequest>> delete(
    _is.DatabaseSession session,
    List<ClaimRequest> rows, {
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ClaimRequest>(
      rows,
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ClaimRequest].
  Future<ClaimRequest> deleteRow(
    _is.DatabaseSession session,
    ClaimRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClaimRequest>(
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
  Future<List<ClaimRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimRequestTable> where,
    _is.OrderByBuilder<ClaimRequestTable>? orderBy,
    _is.OrderByListBuilder<ClaimRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ClaimRequest>(
      where: where(ClaimRequest.t),
      orderBy: orderBy?.call(ClaimRequest.t),
      orderByList: orderByList?.call(ClaimRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ClaimRequest>(
      where: where?.call(ClaimRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ClaimRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ClaimRequest>(
      where: where(ClaimRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
