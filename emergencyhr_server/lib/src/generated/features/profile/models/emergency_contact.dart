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
import '../../../features/profile/models/contact_channel.dart' as _iid3hpvd;

abstract class EmergencyContact
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EmergencyContact._({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.channel,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EmergencyContact({
    int? id,
    required int userId,
    required String name,
    required String phone,
    required _iid3hpvd.ContactChannel channel,
    DateTime? createdAt,
  }) = _EmergencyContactImpl;

  factory EmergencyContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyContact(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      channel: _iid3hpvd.ContactChannel.fromJson(
        (jsonSerialization['channel'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EmergencyContactTable();

  static const db = EmergencyContactRepository._();

  @override
  int? id;

  int userId;

  String name;

  String phone;

  _iid3hpvd.ContactChannel channel;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmergencyContact copyWith({
    int? id,
    int? userId,
    String? name,
    String? phone,
    _iid3hpvd.ContactChannel? channel,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencyContact',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'channel': channel.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencyContact',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'channel': channel.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static EmergencyContactInclude include() {
    return EmergencyContactInclude._();
  }

  static EmergencyContactIncludeList includeList({
    _is.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    EmergencyContactInclude? include,
  }) {
    return EmergencyContactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyContactImpl extends EmergencyContact {
  _EmergencyContactImpl({
    int? id,
    required int userId,
    required String name,
    required String phone,
    required _iid3hpvd.ContactChannel channel,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         phone: phone,
         channel: channel,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmergencyContact copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? phone,
    _iid3hpvd.ContactChannel? channel,
    DateTime? createdAt,
  }) {
    return EmergencyContact(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EmergencyContactUpdateTable
    extends _is.UpdateTable<EmergencyContactTable> {
  EmergencyContactUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> phone(String value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<_iid3hpvd.ContactChannel, _iid3hpvd.ContactChannel> channel(
    _iid3hpvd.ContactChannel value,
  ) => _is.ColumnValue(
    table.channel,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EmergencyContactTable extends _is.Table<int?> {
  EmergencyContactTable({super.tableRelation})
    : super(tableName: 'emergency_contact') {
    updateTable = EmergencyContactUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    channel = _is.ColumnEnum(
      'channel',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final EmergencyContactUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString name;

  late final _is.ColumnString phone;

  late final _is.ColumnEnum<_iid3hpvd.ContactChannel> channel;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    name,
    phone,
    channel,
    createdAt,
  ];
}

class EmergencyContactInclude extends _is.IncludeObject {
  EmergencyContactInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EmergencyContact.t;
}

class EmergencyContactIncludeList extends _is.IncludeList {
  EmergencyContactIncludeList._({
    _is.WhereExpressionBuilder<EmergencyContactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmergencyContact.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EmergencyContact.t;
}

class EmergencyContactRepository {
  const EmergencyContactRepository._();

  /// Returns a list of [EmergencyContact]s matching the given query parameters.
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
  Future<List<EmergencyContact>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmergencyContact] matching the given query parameters.
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
  Future<EmergencyContact?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? offset,
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmergencyContact] by its [id] or null if no such row exists.
  Future<EmergencyContact?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmergencyContact>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmergencyContact]s in the list and returns the inserted rows.
  ///
  /// The returned [EmergencyContact]s will have their `id` fields set.
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
  Future<List<EmergencyContact>> insert(
    _is.DatabaseSession session,
    List<EmergencyContact> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EmergencyContact>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EmergencyContact] and returns the inserted row.
  ///
  /// The returned [EmergencyContact] will have its `id` field set.
  Future<EmergencyContact> insertRow(
    _is.DatabaseSession session,
    EmergencyContact row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmergencyContact>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EmergencyContact]s in the list and returns the resulting rows.
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
  /// The returned [EmergencyContact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencyContact>> upsert(
    _is.DatabaseSession session,
    List<EmergencyContact> rows, {
    required _is.ColumnSelections<EmergencyContactTable> conflictColumns,
    _is.ColumnSelections<EmergencyContactTable>? updateColumns,
    _is.WhereExpressionBuilder<EmergencyContactTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EmergencyContact>(
      rows,
      conflictColumns: conflictColumns(EmergencyContact.t),
      updateColumns: updateColumns?.call(EmergencyContact.t),
      updateWhere: updateWhere?.call(EmergencyContact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EmergencyContact] and returns the resulting row.
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
  /// The returned [EmergencyContact] will have its `id` field set.
  Future<EmergencyContact?> upsertRow(
    _is.DatabaseSession session,
    EmergencyContact row, {
    required _is.ColumnSelections<EmergencyContactTable> conflictColumns,
    _is.ColumnSelections<EmergencyContactTable>? updateColumns,
    _is.WhereExpressionBuilder<EmergencyContactTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EmergencyContact>(
      row,
      conflictColumns: conflictColumns(EmergencyContact.t),
      updateColumns: updateColumns?.call(EmergencyContact.t),
      updateWhere: updateWhere?.call(EmergencyContact.t),
      transaction: transaction,
    );
  }

  /// Updates all [EmergencyContact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencyContact>> update(
    _is.DatabaseSession session,
    List<EmergencyContact> rows, {
    _is.ColumnSelections<EmergencyContactTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EmergencyContact>(
      rows,
      columns: columns?.call(EmergencyContact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EmergencyContact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmergencyContact> updateRow(
    _is.DatabaseSession session,
    EmergencyContact row, {
    _is.ColumnSelections<EmergencyContactTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmergencyContact>(
      row,
      columns: columns?.call(EmergencyContact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmergencyContact] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmergencyContact?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EmergencyContactUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EmergencyContact>(
      id,
      columnValues: columnValues(EmergencyContact.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmergencyContact]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmergencyContact>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmergencyContactUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EmergencyContactTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EmergencyContact>(
      columnValues: columnValues(EmergencyContact.t.updateTable),
      where: where(EmergencyContact.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EmergencyContact]s in the list and returns the deleted rows.
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
  Future<List<EmergencyContact>> delete(
    _is.DatabaseSession session,
    List<EmergencyContact> rows, {
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EmergencyContact>(
      rows,
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EmergencyContact].
  Future<EmergencyContact> deleteRow(
    _is.DatabaseSession session,
    EmergencyContact row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmergencyContact>(
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
  Future<List<EmergencyContact>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmergencyContactTable> where,
    _is.OrderByBuilder<EmergencyContactTable>? orderBy,
    _is.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EmergencyContact>(
      where: where(EmergencyContact.t),
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmergencyContact] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmergencyContactTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmergencyContact>(
      where: where(EmergencyContact.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
