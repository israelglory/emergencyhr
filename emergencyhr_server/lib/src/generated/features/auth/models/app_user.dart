/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:emergencyhr_server/src/generated/protocol.dart' as _ilvcm0hz;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;

/// One account per person, identified by phone number.
abstract class AppUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AppUser._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.phone,
    this.name,
    DateTime? createdAt,
    this.suspendedAt,
    this.suspendReason,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      phone: jsonSerialization['phone'] as String,
      name: jsonSerialization['name'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      suspendedAt: jsonSerialization['suspendedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedAt'],
            ),
      suspendReason: jsonSerialization['suspendReason'] as String?,
    );
  }

  static final t = AppUserTable();

  static const db = AppUserRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// The Serverpod auth user this account signs in as.
  _iacs.AuthUser? authUser;

  /// E.164 phone number, e.g. +2348012345678.
  String phone;

  String? name;

  DateTime createdAt;

  DateTime? suspendedAt;

  String? suspendReason;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppUser copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'phone': phone,
      if (name != null) 'name': name,
      'createdAt': createdAt.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'phone': phone,
      if (name != null) 'name': name,
      'createdAt': createdAt.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
    };
  }

  static AppUserInclude include({_iacs.AuthUserInclude? authUser}) {
    return AppUserInclude._(authUser: authUser);
  }

  static AppUserIncludeList includeList({
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    AppUserInclude? include,
  }) {
    return AppUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         phone: phone,
         name: name,
         createdAt: createdAt,
         suspendedAt: suspendedAt,
         suspendReason: suspendReason,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? phone,
    Object? name = _Undefined,
    DateTime? createdAt,
    Object? suspendedAt = _Undefined,
    Object? suspendReason = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      phone: phone ?? this.phone,
      name: name is String? ? name : this.name,
      createdAt: createdAt ?? this.createdAt,
      suspendedAt: suspendedAt is DateTime? ? suspendedAt : this.suspendedAt,
      suspendReason: suspendReason is String?
          ? suspendReason
          : this.suspendReason,
    );
  }
}

class AppUserUpdateTable extends _is.UpdateTable<AppUserTable> {
  AppUserUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> phone(String value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<String, String> name(String? value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> suspendedAt(DateTime? value) =>
      _is.ColumnValue(
        table.suspendedAt,
        value,
      );

  _is.ColumnValue<String, String> suspendReason(String? value) =>
      _is.ColumnValue(
        table.suspendReason,
        value,
      );
}

class AppUserTable extends _is.Table<int?> {
  AppUserTable({super.tableRelation}) : super(tableName: 'app_user') {
    updateTable = AppUserUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    suspendedAt = _is.ColumnDateTime(
      'suspendedAt',
      this,
    );
    suspendReason = _is.ColumnString(
      'suspendReason',
      this,
    );
  }

  late final AppUserUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// The Serverpod auth user this account signs in as.
  _iacs.AuthUserTable? _authUser;

  /// E.164 phone number, e.g. +2348012345678.
  late final _is.ColumnString phone;

  late final _is.ColumnString name;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime suspendedAt;

  late final _is.ColumnString suspendReason;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: AppUser.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    phone,
    name,
    createdAt,
    suspendedAt,
    suspendReason,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class AppUserInclude extends _is.IncludeObject {
  AppUserInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => AppUser.t;
}

class AppUserIncludeList extends _is.IncludeList {
  AppUserIncludeList._({
    _is.WhereExpressionBuilder<AppUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AppUser.t;
}

class AppUserRepository {
  const AppUserRepository._();

  final attachRow = const AppUserAttachRowRepository._();

  /// Returns a list of [AppUser]s matching the given query parameters.
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
  Future<List<AppUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    AppUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppUser] matching the given query parameters.
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
  Future<AppUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    AppUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppUser] by its [id] or null if no such row exists.
  Future<AppUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AppUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppUser>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUser]s will have their `id` fields set.
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
  Future<List<AppUser>> insert(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AppUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AppUser] and returns the inserted row.
  ///
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser> insertRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AppUser]s in the list and returns the resulting rows.
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
  /// The returned [AppUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> upsert(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    required _is.ColumnSelections<AppUserTable> conflictColumns,
    _is.ColumnSelections<AppUserTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AppUser>(
      rows,
      conflictColumns: conflictColumns(AppUser.t),
      updateColumns: updateColumns?.call(AppUser.t),
      updateWhere: updateWhere?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AppUser] and returns the resulting row.
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
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser?> upsertRow(
    _is.DatabaseSession session,
    AppUser row, {
    required _is.ColumnSelections<AppUserTable> conflictColumns,
    _is.ColumnSelections<AppUserTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AppUser>(
      row,
      conflictColumns: conflictColumns(AppUser.t),
      updateColumns: updateColumns?.call(AppUser.t),
      updateWhere: updateWhere?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> update(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.ColumnSelections<AppUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AppUser>(
      rows,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AppUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUser> updateRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.ColumnSelections<AppUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUser>(
      row,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AppUser>(
      id,
      columnValues: columnValues(AppUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AppUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AppUser>(
      columnValues: columnValues(AppUser.t.updateTable),
      where: where(AppUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AppUser]s in the list and returns the deleted rows.
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
  Future<List<AppUser>> delete(
    _is.DatabaseSession session,
    List<AppUser> rows, {
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AppUser>(
      rows,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AppUser].
  Future<AppUser> deleteRow(
    _is.DatabaseSession session,
    AppUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUser>(
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
  Future<List<AppUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUserTable> where,
    _is.OrderByBuilder<AppUserTable>? orderBy,
    _is.OrderByListBuilder<AppUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AppUser>(
      where: where(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AppUser>(
      where: where?.call(AppUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppUser>(
      where: where(AppUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AppUserAttachRowRepository {
  const AppUserAttachRowRepository._();

  /// Creates a relation between the given [AppUser] and [AuthUser]
  /// by setting the [AppUser]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    AppUser appUser,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $appUser = appUser.copyWith(authUserId: authUser.id);
    await session.db.updateRow<AppUser>(
      $appUser,
      columns: [AppUser.t.authUserId],
      transaction: transaction,
    );
  }
}
