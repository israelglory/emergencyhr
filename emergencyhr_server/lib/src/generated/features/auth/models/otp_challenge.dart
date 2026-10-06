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
import '../../../features/auth/models/otp_purpose.dart' as _ioexns3b;

/// A one-time code sent by SMS. Only the hash of the code is stored.
abstract class OtpChallenge
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OtpChallenge._({
    this.id,
    required this.phone,
    required this.purpose,
    required this.codeHash,
    required this.expiresAt,
    int? attempts,
    DateTime? createdAt,
    this.consumedAt,
  }) : attempts = attempts ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory OtpChallenge({
    int? id,
    required String phone,
    required _ioexns3b.OtpPurpose purpose,
    required String codeHash,
    required DateTime expiresAt,
    int? attempts,
    DateTime? createdAt,
    DateTime? consumedAt,
  }) = _OtpChallengeImpl;

  factory OtpChallenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtpChallenge(
      id: jsonSerialization['id'] as int?,
      phone: jsonSerialization['phone'] as String,
      purpose: _ioexns3b.OtpPurpose.fromJson(
        (jsonSerialization['purpose'] as String),
      ),
      codeHash: jsonSerialization['codeHash'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      attempts: jsonSerialization['attempts'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      consumedAt: jsonSerialization['consumedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['consumedAt']),
    );
  }

  static final t = OtpChallengeTable();

  static const db = OtpChallengeRepository._();

  @override
  int? id;

  String phone;

  _ioexns3b.OtpPurpose purpose;

  String codeHash;

  DateTime expiresAt;

  int attempts;

  DateTime createdAt;

  DateTime? consumedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OtpChallenge copyWith({
    int? id,
    String? phone,
    _ioexns3b.OtpPurpose? purpose,
    String? codeHash,
    DateTime? expiresAt,
    int? attempts,
    DateTime? createdAt,
    DateTime? consumedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtpChallenge',
      if (id != null) 'id': id,
      'phone': phone,
      'purpose': purpose.toJson(),
      'codeHash': codeHash,
      'expiresAt': expiresAt.toJson(),
      'attempts': attempts,
      'createdAt': createdAt.toJson(),
      if (consumedAt != null) 'consumedAt': consumedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static OtpChallengeInclude include() {
    return OtpChallengeInclude._();
  }

  static OtpChallengeIncludeList includeList({
    _is.WhereExpressionBuilder<OtpChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    OtpChallengeInclude? include,
  }) {
    return OtpChallengeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtpChallengeImpl extends OtpChallenge {
  _OtpChallengeImpl({
    int? id,
    required String phone,
    required _ioexns3b.OtpPurpose purpose,
    required String codeHash,
    required DateTime expiresAt,
    int? attempts,
    DateTime? createdAt,
    DateTime? consumedAt,
  }) : super._(
         id: id,
         phone: phone,
         purpose: purpose,
         codeHash: codeHash,
         expiresAt: expiresAt,
         attempts: attempts,
         createdAt: createdAt,
         consumedAt: consumedAt,
       );

  /// Returns a shallow copy of this [OtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OtpChallenge copyWith({
    Object? id = _Undefined,
    String? phone,
    _ioexns3b.OtpPurpose? purpose,
    String? codeHash,
    DateTime? expiresAt,
    int? attempts,
    DateTime? createdAt,
    Object? consumedAt = _Undefined,
  }) {
    return OtpChallenge(
      id: id is int? ? id : this.id,
      phone: phone ?? this.phone,
      purpose: purpose ?? this.purpose,
      codeHash: codeHash ?? this.codeHash,
      expiresAt: expiresAt ?? this.expiresAt,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      consumedAt: consumedAt is DateTime? ? consumedAt : this.consumedAt,
    );
  }
}

class OtpChallengeUpdateTable extends _is.UpdateTable<OtpChallengeTable> {
  OtpChallengeUpdateTable(super.table);

  _is.ColumnValue<String, String> phone(String value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<_ioexns3b.OtpPurpose, _ioexns3b.OtpPurpose> purpose(
    _ioexns3b.OtpPurpose value,
  ) => _is.ColumnValue(
    table.purpose,
    value,
  );

  _is.ColumnValue<String, String> codeHash(String value) => _is.ColumnValue(
    table.codeHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<int, int> attempts(int value) => _is.ColumnValue(
    table.attempts,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> consumedAt(DateTime? value) =>
      _is.ColumnValue(
        table.consumedAt,
        value,
      );
}

class OtpChallengeTable extends _is.Table<int?> {
  OtpChallengeTable({super.tableRelation}) : super(tableName: 'otp_challenge') {
    updateTable = OtpChallengeUpdateTable(this);
    phone = _is.ColumnString(
      'phone',
      this,
    );
    purpose = _is.ColumnEnum(
      'purpose',
      this,
      _is.EnumSerialization.byName,
    );
    codeHash = _is.ColumnString(
      'codeHash',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    attempts = _is.ColumnInt(
      'attempts',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    consumedAt = _is.ColumnDateTime(
      'consumedAt',
      this,
    );
  }

  late final OtpChallengeUpdateTable updateTable;

  late final _is.ColumnString phone;

  late final _is.ColumnEnum<_ioexns3b.OtpPurpose> purpose;

  late final _is.ColumnString codeHash;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnInt attempts;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime consumedAt;

  @override
  List<_is.Column> get columns => [
    id,
    phone,
    purpose,
    codeHash,
    expiresAt,
    attempts,
    createdAt,
    consumedAt,
  ];
}

class OtpChallengeInclude extends _is.IncludeObject {
  OtpChallengeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OtpChallenge.t;
}

class OtpChallengeIncludeList extends _is.IncludeList {
  OtpChallengeIncludeList._({
    _is.WhereExpressionBuilder<OtpChallengeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OtpChallenge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OtpChallenge.t;
}

class OtpChallengeRepository {
  const OtpChallengeRepository._();

  /// Returns a list of [OtpChallenge]s matching the given query parameters.
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
  Future<List<OtpChallenge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OtpChallenge>(
      where: where?.call(OtpChallenge.t),
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OtpChallenge] matching the given query parameters.
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
  Future<OtpChallenge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpChallengeTable>? where,
    int? offset,
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OtpChallenge>(
      where: where?.call(OtpChallenge.t),
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OtpChallenge] by its [id] or null if no such row exists.
  Future<OtpChallenge?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OtpChallenge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OtpChallenge]s in the list and returns the inserted rows.
  ///
  /// The returned [OtpChallenge]s will have their `id` fields set.
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
  Future<List<OtpChallenge>> insert(
    _is.DatabaseSession session,
    List<OtpChallenge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OtpChallenge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OtpChallenge] and returns the inserted row.
  ///
  /// The returned [OtpChallenge] will have its `id` field set.
  Future<OtpChallenge> insertRow(
    _is.DatabaseSession session,
    OtpChallenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OtpChallenge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OtpChallenge]s in the list and returns the resulting rows.
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
  /// The returned [OtpChallenge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpChallenge>> upsert(
    _is.DatabaseSession session,
    List<OtpChallenge> rows, {
    required _is.ColumnSelections<OtpChallengeTable> conflictColumns,
    _is.ColumnSelections<OtpChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<OtpChallengeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OtpChallenge>(
      rows,
      conflictColumns: conflictColumns(OtpChallenge.t),
      updateColumns: updateColumns?.call(OtpChallenge.t),
      updateWhere: updateWhere?.call(OtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OtpChallenge] and returns the resulting row.
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
  /// The returned [OtpChallenge] will have its `id` field set.
  Future<OtpChallenge?> upsertRow(
    _is.DatabaseSession session,
    OtpChallenge row, {
    required _is.ColumnSelections<OtpChallengeTable> conflictColumns,
    _is.ColumnSelections<OtpChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<OtpChallengeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OtpChallenge>(
      row,
      conflictColumns: conflictColumns(OtpChallenge.t),
      updateColumns: updateColumns?.call(OtpChallenge.t),
      updateWhere: updateWhere?.call(OtpChallenge.t),
      transaction: transaction,
    );
  }

  /// Updates all [OtpChallenge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpChallenge>> update(
    _is.DatabaseSession session,
    List<OtpChallenge> rows, {
    _is.ColumnSelections<OtpChallengeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OtpChallenge>(
      rows,
      columns: columns?.call(OtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OtpChallenge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OtpChallenge> updateRow(
    _is.DatabaseSession session,
    OtpChallenge row, {
    _is.ColumnSelections<OtpChallengeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OtpChallenge>(
      row,
      columns: columns?.call(OtpChallenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtpChallenge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OtpChallenge?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OtpChallengeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OtpChallenge>(
      id,
      columnValues: columnValues(OtpChallenge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OtpChallenge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpChallenge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OtpChallengeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OtpChallengeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OtpChallenge>(
      columnValues: columnValues(OtpChallenge.t.updateTable),
      where: where(OtpChallenge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OtpChallenge]s in the list and returns the deleted rows.
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
  Future<List<OtpChallenge>> delete(
    _is.DatabaseSession session,
    List<OtpChallenge> rows, {
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OtpChallenge>(
      rows,
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OtpChallenge].
  Future<OtpChallenge> deleteRow(
    _is.DatabaseSession session,
    OtpChallenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OtpChallenge>(
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
  Future<List<OtpChallenge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OtpChallengeTable> where,
    _is.OrderByBuilder<OtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<OtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OtpChallenge>(
      where: where(OtpChallenge.t),
      orderBy: orderBy?.call(OtpChallenge.t),
      orderByList: orderByList?.call(OtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpChallengeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OtpChallenge>(
      where: where?.call(OtpChallenge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OtpChallenge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OtpChallengeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OtpChallenge>(
      where: where(OtpChallenge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
