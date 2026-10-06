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

/// Health data, encrypted field by field. Saved only after explicit consent.
abstract class MedicalProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MedicalProfile._({
    this.id,
    required this.userId,
    this.bloodGroupEnc,
    this.allergiesEnc,
    this.conditionsEnc,
    this.medicationsEnc,
    required this.consentAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory MedicalProfile({
    int? id,
    required int userId,
    String? bloodGroupEnc,
    String? allergiesEnc,
    String? conditionsEnc,
    String? medicationsEnc,
    required DateTime consentAt,
    DateTime? updatedAt,
  }) = _MedicalProfileImpl;

  factory MedicalProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return MedicalProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      bloodGroupEnc: jsonSerialization['bloodGroupEnc'] as String?,
      allergiesEnc: jsonSerialization['allergiesEnc'] as String?,
      conditionsEnc: jsonSerialization['conditionsEnc'] as String?,
      medicationsEnc: jsonSerialization['medicationsEnc'] as String?,
      consentAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['consentAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MedicalProfileTable();

  static const db = MedicalProfileRepository._();

  @override
  int? id;

  int userId;

  String? bloodGroupEnc;

  String? allergiesEnc;

  String? conditionsEnc;

  String? medicationsEnc;

  DateTime consentAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MedicalProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MedicalProfile copyWith({
    int? id,
    int? userId,
    String? bloodGroupEnc,
    String? allergiesEnc,
    String? conditionsEnc,
    String? medicationsEnc,
    DateTime? consentAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MedicalProfile',
      if (id != null) 'id': id,
      'userId': userId,
      if (bloodGroupEnc != null) 'bloodGroupEnc': bloodGroupEnc,
      if (allergiesEnc != null) 'allergiesEnc': allergiesEnc,
      if (conditionsEnc != null) 'conditionsEnc': conditionsEnc,
      if (medicationsEnc != null) 'medicationsEnc': medicationsEnc,
      'consentAt': consentAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static MedicalProfileInclude include() {
    return MedicalProfileInclude._();
  }

  static MedicalProfileIncludeList includeList({
    _is.WhereExpressionBuilder<MedicalProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    MedicalProfileInclude? include,
  }) {
    return MedicalProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MedicalProfileImpl extends MedicalProfile {
  _MedicalProfileImpl({
    int? id,
    required int userId,
    String? bloodGroupEnc,
    String? allergiesEnc,
    String? conditionsEnc,
    String? medicationsEnc,
    required DateTime consentAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bloodGroupEnc: bloodGroupEnc,
         allergiesEnc: allergiesEnc,
         conditionsEnc: conditionsEnc,
         medicationsEnc: medicationsEnc,
         consentAt: consentAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MedicalProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MedicalProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? bloodGroupEnc = _Undefined,
    Object? allergiesEnc = _Undefined,
    Object? conditionsEnc = _Undefined,
    Object? medicationsEnc = _Undefined,
    DateTime? consentAt,
    DateTime? updatedAt,
  }) {
    return MedicalProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bloodGroupEnc: bloodGroupEnc is String?
          ? bloodGroupEnc
          : this.bloodGroupEnc,
      allergiesEnc: allergiesEnc is String? ? allergiesEnc : this.allergiesEnc,
      conditionsEnc: conditionsEnc is String?
          ? conditionsEnc
          : this.conditionsEnc,
      medicationsEnc: medicationsEnc is String?
          ? medicationsEnc
          : this.medicationsEnc,
      consentAt: consentAt ?? this.consentAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MedicalProfileUpdateTable extends _is.UpdateTable<MedicalProfileTable> {
  MedicalProfileUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> bloodGroupEnc(String? value) =>
      _is.ColumnValue(
        table.bloodGroupEnc,
        value,
      );

  _is.ColumnValue<String, String> allergiesEnc(String? value) =>
      _is.ColumnValue(
        table.allergiesEnc,
        value,
      );

  _is.ColumnValue<String, String> conditionsEnc(String? value) =>
      _is.ColumnValue(
        table.conditionsEnc,
        value,
      );

  _is.ColumnValue<String, String> medicationsEnc(String? value) =>
      _is.ColumnValue(
        table.medicationsEnc,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> consentAt(DateTime value) =>
      _is.ColumnValue(
        table.consentAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class MedicalProfileTable extends _is.Table<int?> {
  MedicalProfileTable({super.tableRelation})
    : super(tableName: 'medical_profile') {
    updateTable = MedicalProfileUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    bloodGroupEnc = _is.ColumnString(
      'bloodGroupEnc',
      this,
    );
    allergiesEnc = _is.ColumnString(
      'allergiesEnc',
      this,
    );
    conditionsEnc = _is.ColumnString(
      'conditionsEnc',
      this,
    );
    medicationsEnc = _is.ColumnString(
      'medicationsEnc',
      this,
    );
    consentAt = _is.ColumnDateTime(
      'consentAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final MedicalProfileUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnString bloodGroupEnc;

  late final _is.ColumnString allergiesEnc;

  late final _is.ColumnString conditionsEnc;

  late final _is.ColumnString medicationsEnc;

  late final _is.ColumnDateTime consentAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    bloodGroupEnc,
    allergiesEnc,
    conditionsEnc,
    medicationsEnc,
    consentAt,
    updatedAt,
  ];
}

class MedicalProfileInclude extends _is.IncludeObject {
  MedicalProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MedicalProfile.t;
}

class MedicalProfileIncludeList extends _is.IncludeList {
  MedicalProfileIncludeList._({
    _is.WhereExpressionBuilder<MedicalProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MedicalProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MedicalProfile.t;
}

class MedicalProfileRepository {
  const MedicalProfileRepository._();

  /// Returns a list of [MedicalProfile]s matching the given query parameters.
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
  Future<List<MedicalProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicalProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MedicalProfile>(
      where: where?.call(MedicalProfile.t),
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MedicalProfile] matching the given query parameters.
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
  Future<MedicalProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicalProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MedicalProfile>(
      where: where?.call(MedicalProfile.t),
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MedicalProfile] by its [id] or null if no such row exists.
  Future<MedicalProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MedicalProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MedicalProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [MedicalProfile]s will have their `id` fields set.
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
  Future<List<MedicalProfile>> insert(
    _is.DatabaseSession session,
    List<MedicalProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MedicalProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MedicalProfile] and returns the inserted row.
  ///
  /// The returned [MedicalProfile] will have its `id` field set.
  Future<MedicalProfile> insertRow(
    _is.DatabaseSession session,
    MedicalProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MedicalProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MedicalProfile]s in the list and returns the resulting rows.
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
  /// The returned [MedicalProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MedicalProfile>> upsert(
    _is.DatabaseSession session,
    List<MedicalProfile> rows, {
    required _is.ColumnSelections<MedicalProfileTable> conflictColumns,
    _is.ColumnSelections<MedicalProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<MedicalProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MedicalProfile>(
      rows,
      conflictColumns: conflictColumns(MedicalProfile.t),
      updateColumns: updateColumns?.call(MedicalProfile.t),
      updateWhere: updateWhere?.call(MedicalProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MedicalProfile] and returns the resulting row.
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
  /// The returned [MedicalProfile] will have its `id` field set.
  Future<MedicalProfile?> upsertRow(
    _is.DatabaseSession session,
    MedicalProfile row, {
    required _is.ColumnSelections<MedicalProfileTable> conflictColumns,
    _is.ColumnSelections<MedicalProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<MedicalProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MedicalProfile>(
      row,
      conflictColumns: conflictColumns(MedicalProfile.t),
      updateColumns: updateColumns?.call(MedicalProfile.t),
      updateWhere: updateWhere?.call(MedicalProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [MedicalProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MedicalProfile>> update(
    _is.DatabaseSession session,
    List<MedicalProfile> rows, {
    _is.ColumnSelections<MedicalProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MedicalProfile>(
      rows,
      columns: columns?.call(MedicalProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MedicalProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MedicalProfile> updateRow(
    _is.DatabaseSession session,
    MedicalProfile row, {
    _is.ColumnSelections<MedicalProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MedicalProfile>(
      row,
      columns: columns?.call(MedicalProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MedicalProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MedicalProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MedicalProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MedicalProfile>(
      id,
      columnValues: columnValues(MedicalProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MedicalProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MedicalProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MedicalProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MedicalProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MedicalProfile>(
      columnValues: columnValues(MedicalProfile.t.updateTable),
      where: where(MedicalProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MedicalProfile]s in the list and returns the deleted rows.
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
  Future<List<MedicalProfile>> delete(
    _is.DatabaseSession session,
    List<MedicalProfile> rows, {
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MedicalProfile>(
      rows,
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MedicalProfile].
  Future<MedicalProfile> deleteRow(
    _is.DatabaseSession session,
    MedicalProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MedicalProfile>(
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
  Future<List<MedicalProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MedicalProfileTable> where,
    _is.OrderByBuilder<MedicalProfileTable>? orderBy,
    _is.OrderByListBuilder<MedicalProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MedicalProfile>(
      where: where(MedicalProfile.t),
      orderBy: orderBy?.call(MedicalProfile.t),
      orderByList: orderByList?.call(MedicalProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MedicalProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MedicalProfile>(
      where: where?.call(MedicalProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MedicalProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MedicalProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MedicalProfile>(
      where: where(MedicalProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
