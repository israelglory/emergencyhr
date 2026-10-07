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
import '../../../features/auth/models/user_role.dart' as _it1fawf0;

/// Single-use invite for a facility role. Only the token hash is stored.
abstract class FacilityInvite
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FacilityInvite._({
    this.id,
    required this.facilityId,
    required this.role,
    this.email,
    this.tokenHash,
    required this.shortCode,
    required this.createdByUserId,
    required this.expiresAt,
    this.usedAt,
    this.usedByUserId,
    this.revokedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FacilityInvite({
    int? id,
    required int facilityId,
    required _it1fawf0.UserRole role,
    String? email,
    String? tokenHash,
    required String shortCode,
    required int createdByUserId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) = _FacilityInviteImpl;

  factory FacilityInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityInvite(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      email: jsonSerialization['email'] as String?,
      tokenHash: jsonSerialization['tokenHash'] as String?,
      shortCode: jsonSerialization['shortCode'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      usedByUserId: jsonSerialization['usedByUserId'] as int?,
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = FacilityInviteTable();

  static const db = FacilityInviteRepository._();

  @override
  int? id;

  int facilityId;

  _it1fawf0.UserRole role;

  /// When set, only the account with this email can accept.
  String? email;

  String? tokenHash;

  String shortCode;

  int createdByUserId;

  DateTime expiresAt;

  DateTime? usedAt;

  int? usedByUserId;

  DateTime? revokedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FacilityInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityInvite copyWith({
    int? id,
    int? facilityId,
    _it1fawf0.UserRole? role,
    String? email,
    String? tokenHash,
    String? shortCode,
    int? createdByUserId,
    DateTime? expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityInvite',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'role': role.toJson(),
      if (email != null) 'email': email,
      if (tokenHash != null) 'tokenHash': tokenHash,
      'shortCode': shortCode,
      'createdByUserId': createdByUserId,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (usedByUserId != null) 'usedByUserId': usedByUserId,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityInvite',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'role': role.toJson(),
      if (email != null) 'email': email,
      'shortCode': shortCode,
      'createdByUserId': createdByUserId,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (usedByUserId != null) 'usedByUserId': usedByUserId,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static FacilityInviteInclude include() {
    return FacilityInviteInclude._();
  }

  static FacilityInviteIncludeList includeList({
    _is.WhereExpressionBuilder<FacilityInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    FacilityInviteInclude? include,
  }) {
    return FacilityInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityInviteImpl extends FacilityInvite {
  _FacilityInviteImpl({
    int? id,
    required int facilityId,
    required _it1fawf0.UserRole role,
    String? email,
    String? tokenHash,
    required String shortCode,
    required int createdByUserId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         role: role,
         email: email,
         tokenHash: tokenHash,
         shortCode: shortCode,
         createdByUserId: createdByUserId,
         expiresAt: expiresAt,
         usedAt: usedAt,
         usedByUserId: usedByUserId,
         revokedAt: revokedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FacilityInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityInvite copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _it1fawf0.UserRole? role,
    Object? email = _Undefined,
    Object? tokenHash = _Undefined,
    String? shortCode,
    int? createdByUserId,
    DateTime? expiresAt,
    Object? usedAt = _Undefined,
    Object? usedByUserId = _Undefined,
    Object? revokedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return FacilityInvite(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      role: role ?? this.role,
      email: email is String? ? email : this.email,
      tokenHash: tokenHash is String? ? tokenHash : this.tokenHash,
      shortCode: shortCode ?? this.shortCode,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
      usedByUserId: usedByUserId is int? ? usedByUserId : this.usedByUserId,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FacilityInviteUpdateTable extends _is.UpdateTable<FacilityInviteTable> {
  FacilityInviteUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<_it1fawf0.UserRole, _it1fawf0.UserRole> role(
    _it1fawf0.UserRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> tokenHash(String? value) => _is.ColumnValue(
    table.tokenHash,
    value,
  );

  _is.ColumnValue<String, String> shortCode(String value) => _is.ColumnValue(
    table.shortCode,
    value,
  );

  _is.ColumnValue<int, int> createdByUserId(int value) => _is.ColumnValue(
    table.createdByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> usedAt(DateTime? value) =>
      _is.ColumnValue(
        table.usedAt,
        value,
      );

  _is.ColumnValue<int, int> usedByUserId(int? value) => _is.ColumnValue(
    table.usedByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class FacilityInviteTable extends _is.Table<int?> {
  FacilityInviteTable({super.tableRelation})
    : super(tableName: 'facility_invite') {
    updateTable = FacilityInviteUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    tokenHash = _is.ColumnString(
      'tokenHash',
      this,
    );
    shortCode = _is.ColumnString(
      'shortCode',
      this,
    );
    createdByUserId = _is.ColumnInt(
      'createdByUserId',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    usedAt = _is.ColumnDateTime(
      'usedAt',
      this,
    );
    usedByUserId = _is.ColumnInt(
      'usedByUserId',
      this,
    );
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final FacilityInviteUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnEnum<_it1fawf0.UserRole> role;

  /// When set, only the account with this email can accept.
  late final _is.ColumnString email;

  late final _is.ColumnString tokenHash;

  late final _is.ColumnString shortCode;

  late final _is.ColumnInt createdByUserId;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime usedAt;

  late final _is.ColumnInt usedByUserId;

  late final _is.ColumnDateTime revokedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    role,
    email,
    tokenHash,
    shortCode,
    createdByUserId,
    expiresAt,
    usedAt,
    usedByUserId,
    revokedAt,
    createdAt,
  ];
}

class FacilityInviteInclude extends _is.IncludeObject {
  FacilityInviteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FacilityInvite.t;
}

class FacilityInviteIncludeList extends _is.IncludeList {
  FacilityInviteIncludeList._({
    _is.WhereExpressionBuilder<FacilityInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FacilityInvite.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FacilityInvite.t;
}

class FacilityInviteRepository {
  const FacilityInviteRepository._();

  /// Returns a list of [FacilityInvite]s matching the given query parameters.
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
  Future<List<FacilityInvite>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FacilityInvite>(
      where: where?.call(FacilityInvite.t),
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FacilityInvite] matching the given query parameters.
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
  Future<FacilityInvite?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityInviteTable>? where,
    int? offset,
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FacilityInvite>(
      where: where?.call(FacilityInvite.t),
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FacilityInvite] by its [id] or null if no such row exists.
  Future<FacilityInvite?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FacilityInvite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FacilityInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [FacilityInvite]s will have their `id` fields set.
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
  Future<List<FacilityInvite>> insert(
    _is.DatabaseSession session,
    List<FacilityInvite> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FacilityInvite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FacilityInvite] and returns the inserted row.
  ///
  /// The returned [FacilityInvite] will have its `id` field set.
  Future<FacilityInvite> insertRow(
    _is.DatabaseSession session,
    FacilityInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FacilityInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FacilityInvite]s in the list and returns the resulting rows.
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
  /// The returned [FacilityInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityInvite>> upsert(
    _is.DatabaseSession session,
    List<FacilityInvite> rows, {
    required _is.ColumnSelections<FacilityInviteTable> conflictColumns,
    _is.ColumnSelections<FacilityInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityInviteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FacilityInvite>(
      rows,
      conflictColumns: conflictColumns(FacilityInvite.t),
      updateColumns: updateColumns?.call(FacilityInvite.t),
      updateWhere: updateWhere?.call(FacilityInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FacilityInvite] and returns the resulting row.
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
  /// The returned [FacilityInvite] will have its `id` field set.
  Future<FacilityInvite?> upsertRow(
    _is.DatabaseSession session,
    FacilityInvite row, {
    required _is.ColumnSelections<FacilityInviteTable> conflictColumns,
    _is.ColumnSelections<FacilityInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityInviteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FacilityInvite>(
      row,
      conflictColumns: conflictColumns(FacilityInvite.t),
      updateColumns: updateColumns?.call(FacilityInvite.t),
      updateWhere: updateWhere?.call(FacilityInvite.t),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityInvite>> update(
    _is.DatabaseSession session,
    List<FacilityInvite> rows, {
    _is.ColumnSelections<FacilityInviteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FacilityInvite>(
      rows,
      columns: columns?.call(FacilityInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FacilityInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FacilityInvite> updateRow(
    _is.DatabaseSession session,
    FacilityInvite row, {
    _is.ColumnSelections<FacilityInviteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FacilityInvite>(
      row,
      columns: columns?.call(FacilityInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FacilityInvite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FacilityInvite?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FacilityInviteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FacilityInvite>(
      id,
      columnValues: columnValues(FacilityInvite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityInvite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityInvite>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FacilityInviteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FacilityInviteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FacilityInvite>(
      columnValues: columnValues(FacilityInvite.t.updateTable),
      where: where(FacilityInvite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FacilityInvite]s in the list and returns the deleted rows.
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
  Future<List<FacilityInvite>> delete(
    _is.DatabaseSession session,
    List<FacilityInvite> rows, {
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FacilityInvite>(
      rows,
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FacilityInvite].
  Future<FacilityInvite> deleteRow(
    _is.DatabaseSession session,
    FacilityInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FacilityInvite>(
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
  Future<List<FacilityInvite>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityInviteTable> where,
    _is.OrderByBuilder<FacilityInviteTable>? orderBy,
    _is.OrderByListBuilder<FacilityInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FacilityInvite>(
      where: where(FacilityInvite.t),
      orderBy: orderBy?.call(FacilityInvite.t),
      orderByList: orderByList?.call(FacilityInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityInviteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FacilityInvite>(
      where: where?.call(FacilityInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FacilityInvite] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityInviteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FacilityInvite>(
      where: where(FacilityInvite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
