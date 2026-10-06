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
import '../../../features/facilities/models/verification_status.dart'
    as _ipq8k6fl;

/// V2 only. Schema exists so the doctor launch needs no migration.
abstract class DoctorProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DoctorProfile._({
    this.id,
    required this.userId,
    required this.mdcnNumber,
    required this.licenceExpiry,
    required this.specialty,
    required this.feeNgn,
    required this.sessionMinutes,
    this.facilityId,
    required this.verificationStatus,
  });

  factory DoctorProfile({
    int? id,
    required int userId,
    required String mdcnNumber,
    required DateTime licenceExpiry,
    required String specialty,
    required int feeNgn,
    required int sessionMinutes,
    int? facilityId,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) = _DoctorProfileImpl;

  factory DoctorProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoctorProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      mdcnNumber: jsonSerialization['mdcnNumber'] as String,
      licenceExpiry: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['licenceExpiry'],
      ),
      specialty: jsonSerialization['specialty'] as String,
      feeNgn: jsonSerialization['feeNgn'] as int,
      sessionMinutes: jsonSerialization['sessionMinutes'] as int,
      facilityId: jsonSerialization['facilityId'] as int?,
      verificationStatus: _ipq8k6fl.VerificationStatus.fromJson(
        (jsonSerialization['verificationStatus'] as String),
      ),
    );
  }

  static final t = DoctorProfileTable();

  static const db = DoctorProfileRepository._();

  @override
  int? id;

  int userId;

  String mdcnNumber;

  DateTime licenceExpiry;

  String specialty;

  int feeNgn;

  int sessionMinutes;

  int? facilityId;

  _ipq8k6fl.VerificationStatus verificationStatus;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DoctorProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DoctorProfile copyWith({
    int? id,
    int? userId,
    String? mdcnNumber,
    DateTime? licenceExpiry,
    String? specialty,
    int? feeNgn,
    int? sessionMinutes,
    int? facilityId,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoctorProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'mdcnNumber': mdcnNumber,
      'licenceExpiry': licenceExpiry.toJson(),
      'specialty': specialty,
      'feeNgn': feeNgn,
      'sessionMinutes': sessionMinutes,
      if (facilityId != null) 'facilityId': facilityId,
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoctorProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'mdcnNumber': mdcnNumber,
      'licenceExpiry': licenceExpiry.toJson(),
      'specialty': specialty,
      'feeNgn': feeNgn,
      'sessionMinutes': sessionMinutes,
      if (facilityId != null) 'facilityId': facilityId,
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  static DoctorProfileInclude include() {
    return DoctorProfileInclude._();
  }

  static DoctorProfileIncludeList includeList({
    _is.WhereExpressionBuilder<DoctorProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    DoctorProfileInclude? include,
  }) {
    return DoctorProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoctorProfileImpl extends DoctorProfile {
  _DoctorProfileImpl({
    int? id,
    required int userId,
    required String mdcnNumber,
    required DateTime licenceExpiry,
    required String specialty,
    required int feeNgn,
    required int sessionMinutes,
    int? facilityId,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) : super._(
         id: id,
         userId: userId,
         mdcnNumber: mdcnNumber,
         licenceExpiry: licenceExpiry,
         specialty: specialty,
         feeNgn: feeNgn,
         sessionMinutes: sessionMinutes,
         facilityId: facilityId,
         verificationStatus: verificationStatus,
       );

  /// Returns a shallow copy of this [DoctorProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DoctorProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    String? mdcnNumber,
    DateTime? licenceExpiry,
    String? specialty,
    int? feeNgn,
    int? sessionMinutes,
    Object? facilityId = _Undefined,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  }) {
    return DoctorProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      mdcnNumber: mdcnNumber ?? this.mdcnNumber,
      licenceExpiry: licenceExpiry ?? this.licenceExpiry,
      specialty: specialty ?? this.specialty,
      feeNgn: feeNgn ?? this.feeNgn,
      sessionMinutes: sessionMinutes ?? this.sessionMinutes,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

class DoctorProfileUpdateTable extends _is.UpdateTable<DoctorProfileTable> {
  DoctorProfileUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> mdcnNumber(String value) => _is.ColumnValue(
    table.mdcnNumber,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> licenceExpiry(DateTime value) =>
      _is.ColumnValue(
        table.licenceExpiry,
        value,
      );

  _is.ColumnValue<String, String> specialty(String value) => _is.ColumnValue(
    table.specialty,
    value,
  );

  _is.ColumnValue<int, int> feeNgn(int value) => _is.ColumnValue(
    table.feeNgn,
    value,
  );

  _is.ColumnValue<int, int> sessionMinutes(int value) => _is.ColumnValue(
    table.sessionMinutes,
    value,
  );

  _is.ColumnValue<int, int> facilityId(int? value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<_ipq8k6fl.VerificationStatus, _ipq8k6fl.VerificationStatus>
  verificationStatus(_ipq8k6fl.VerificationStatus value) => _is.ColumnValue(
    table.verificationStatus,
    value,
  );
}

class DoctorProfileTable extends _is.Table<int?> {
  DoctorProfileTable({super.tableRelation})
    : super(tableName: 'doctor_profile') {
    updateTable = DoctorProfileUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    mdcnNumber = _is.ColumnString(
      'mdcnNumber',
      this,
    );
    licenceExpiry = _is.ColumnDateTime(
      'licenceExpiry',
      this,
    );
    specialty = _is.ColumnString(
      'specialty',
      this,
    );
    feeNgn = _is.ColumnInt(
      'feeNgn',
      this,
    );
    sessionMinutes = _is.ColumnInt(
      'sessionMinutes',
      this,
    );
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    verificationStatus = _is.ColumnEnum(
      'verificationStatus',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final DoctorProfileUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString mdcnNumber;

  late final _is.ColumnDateTime licenceExpiry;

  late final _is.ColumnString specialty;

  late final _is.ColumnInt feeNgn;

  late final _is.ColumnInt sessionMinutes;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnEnum<_ipq8k6fl.VerificationStatus> verificationStatus;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    mdcnNumber,
    licenceExpiry,
    specialty,
    feeNgn,
    sessionMinutes,
    facilityId,
    verificationStatus,
  ];
}

class DoctorProfileInclude extends _is.IncludeObject {
  DoctorProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DoctorProfile.t;
}

class DoctorProfileIncludeList extends _is.IncludeList {
  DoctorProfileIncludeList._({
    _is.WhereExpressionBuilder<DoctorProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DoctorProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DoctorProfile.t;
}

class DoctorProfileRepository {
  const DoctorProfileRepository._();

  /// Returns a list of [DoctorProfile]s matching the given query parameters.
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
  Future<List<DoctorProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DoctorProfile>(
      where: where?.call(DoctorProfile.t),
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DoctorProfile] matching the given query parameters.
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
  Future<DoctorProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DoctorProfile>(
      where: where?.call(DoctorProfile.t),
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DoctorProfile] by its [id] or null if no such row exists.
  Future<DoctorProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DoctorProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DoctorProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [DoctorProfile]s will have their `id` fields set.
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
  Future<List<DoctorProfile>> insert(
    _is.DatabaseSession session,
    List<DoctorProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DoctorProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DoctorProfile] and returns the inserted row.
  ///
  /// The returned [DoctorProfile] will have its `id` field set.
  Future<DoctorProfile> insertRow(
    _is.DatabaseSession session,
    DoctorProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DoctorProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DoctorProfile]s in the list and returns the resulting rows.
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
  /// The returned [DoctorProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorProfile>> upsert(
    _is.DatabaseSession session,
    List<DoctorProfile> rows, {
    required _is.ColumnSelections<DoctorProfileTable> conflictColumns,
    _is.ColumnSelections<DoctorProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<DoctorProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DoctorProfile>(
      rows,
      conflictColumns: conflictColumns(DoctorProfile.t),
      updateColumns: updateColumns?.call(DoctorProfile.t),
      updateWhere: updateWhere?.call(DoctorProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DoctorProfile] and returns the resulting row.
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
  /// The returned [DoctorProfile] will have its `id` field set.
  Future<DoctorProfile?> upsertRow(
    _is.DatabaseSession session,
    DoctorProfile row, {
    required _is.ColumnSelections<DoctorProfileTable> conflictColumns,
    _is.ColumnSelections<DoctorProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<DoctorProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DoctorProfile>(
      row,
      conflictColumns: conflictColumns(DoctorProfile.t),
      updateColumns: updateColumns?.call(DoctorProfile.t),
      updateWhere: updateWhere?.call(DoctorProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [DoctorProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorProfile>> update(
    _is.DatabaseSession session,
    List<DoctorProfile> rows, {
    _is.ColumnSelections<DoctorProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DoctorProfile>(
      rows,
      columns: columns?.call(DoctorProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DoctorProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DoctorProfile> updateRow(
    _is.DatabaseSession session,
    DoctorProfile row, {
    _is.ColumnSelections<DoctorProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DoctorProfile>(
      row,
      columns: columns?.call(DoctorProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DoctorProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DoctorProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DoctorProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DoctorProfile>(
      id,
      columnValues: columnValues(DoctorProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DoctorProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoctorProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DoctorProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DoctorProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DoctorProfile>(
      columnValues: columnValues(DoctorProfile.t.updateTable),
      where: where(DoctorProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DoctorProfile]s in the list and returns the deleted rows.
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
  Future<List<DoctorProfile>> delete(
    _is.DatabaseSession session,
    List<DoctorProfile> rows, {
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DoctorProfile>(
      rows,
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DoctorProfile].
  Future<DoctorProfile> deleteRow(
    _is.DatabaseSession session,
    DoctorProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DoctorProfile>(
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
  Future<List<DoctorProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoctorProfileTable> where,
    _is.OrderByBuilder<DoctorProfileTable>? orderBy,
    _is.OrderByListBuilder<DoctorProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DoctorProfile>(
      where: where(DoctorProfile.t),
      orderBy: orderBy?.call(DoctorProfile.t),
      orderByList: orderByList?.call(DoctorProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoctorProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DoctorProfile>(
      where: where?.call(DoctorProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DoctorProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoctorProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DoctorProfile>(
      where: where(DoctorProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
