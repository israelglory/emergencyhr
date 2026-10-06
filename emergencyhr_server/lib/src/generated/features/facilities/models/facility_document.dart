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
import '../../../features/facilities/models/document_kind.dart' as _i2c0pm7z;

/// A file stored in Serverpod private storage.
abstract class FacilityDocument
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FacilityDocument._({
    this.id,
    this.facilityId,
    this.claimRequestId,
    required this.kind,
    required this.storagePath,
    required this.fileName,
    this.uploadedByUserId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FacilityDocument({
    int? id,
    int? facilityId,
    int? claimRequestId,
    required _i2c0pm7z.DocumentKind kind,
    required String storagePath,
    required String fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  }) = _FacilityDocumentImpl;

  factory FacilityDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityDocument(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int?,
      claimRequestId: jsonSerialization['claimRequestId'] as int?,
      kind: _i2c0pm7z.DocumentKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      storagePath: jsonSerialization['storagePath'] as String,
      fileName: jsonSerialization['fileName'] as String,
      uploadedByUserId: jsonSerialization['uploadedByUserId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = FacilityDocumentTable();

  static const db = FacilityDocumentRepository._();

  @override
  int? id;

  int? facilityId;

  int? claimRequestId;

  _i2c0pm7z.DocumentKind kind;

  String storagePath;

  String fileName;

  int? uploadedByUserId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FacilityDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityDocument copyWith({
    int? id,
    int? facilityId,
    int? claimRequestId,
    _i2c0pm7z.DocumentKind? kind,
    String? storagePath,
    String? fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityDocument',
      if (id != null) 'id': id,
      if (facilityId != null) 'facilityId': facilityId,
      if (claimRequestId != null) 'claimRequestId': claimRequestId,
      'kind': kind.toJson(),
      'storagePath': storagePath,
      'fileName': fileName,
      if (uploadedByUserId != null) 'uploadedByUserId': uploadedByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityDocument',
      if (id != null) 'id': id,
      if (facilityId != null) 'facilityId': facilityId,
      if (claimRequestId != null) 'claimRequestId': claimRequestId,
      'kind': kind.toJson(),
      'storagePath': storagePath,
      'fileName': fileName,
      if (uploadedByUserId != null) 'uploadedByUserId': uploadedByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  static FacilityDocumentInclude include() {
    return FacilityDocumentInclude._();
  }

  static FacilityDocumentIncludeList includeList({
    _is.WhereExpressionBuilder<FacilityDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    FacilityDocumentInclude? include,
  }) {
    return FacilityDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityDocumentImpl extends FacilityDocument {
  _FacilityDocumentImpl({
    int? id,
    int? facilityId,
    int? claimRequestId,
    required _i2c0pm7z.DocumentKind kind,
    required String storagePath,
    required String fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         claimRequestId: claimRequestId,
         kind: kind,
         storagePath: storagePath,
         fileName: fileName,
         uploadedByUserId: uploadedByUserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FacilityDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityDocument copyWith({
    Object? id = _Undefined,
    Object? facilityId = _Undefined,
    Object? claimRequestId = _Undefined,
    _i2c0pm7z.DocumentKind? kind,
    String? storagePath,
    String? fileName,
    Object? uploadedByUserId = _Undefined,
    DateTime? createdAt,
  }) {
    return FacilityDocument(
      id: id is int? ? id : this.id,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      claimRequestId: claimRequestId is int?
          ? claimRequestId
          : this.claimRequestId,
      kind: kind ?? this.kind,
      storagePath: storagePath ?? this.storagePath,
      fileName: fileName ?? this.fileName,
      uploadedByUserId: uploadedByUserId is int?
          ? uploadedByUserId
          : this.uploadedByUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FacilityDocumentUpdateTable
    extends _is.UpdateTable<FacilityDocumentTable> {
  FacilityDocumentUpdateTable(super.table);

  _is.ColumnValue<int, int> facilityId(int? value) => _is.ColumnValue(
    table.facilityId,
    value,
  );

  _is.ColumnValue<int, int> claimRequestId(int? value) => _is.ColumnValue(
    table.claimRequestId,
    value,
  );

  _is.ColumnValue<_i2c0pm7z.DocumentKind, _i2c0pm7z.DocumentKind> kind(
    _i2c0pm7z.DocumentKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> storagePath(String value) => _is.ColumnValue(
    table.storagePath,
    value,
  );

  _is.ColumnValue<String, String> fileName(String value) => _is.ColumnValue(
    table.fileName,
    value,
  );

  _is.ColumnValue<int, int> uploadedByUserId(int? value) => _is.ColumnValue(
    table.uploadedByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class FacilityDocumentTable extends _is.Table<int?> {
  FacilityDocumentTable({super.tableRelation})
    : super(tableName: 'facility_document') {
    updateTable = FacilityDocumentUpdateTable(this);
    facilityId = _is.ColumnInt(
      'facilityId',
      this,
    );
    claimRequestId = _is.ColumnInt(
      'claimRequestId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    fileName = _is.ColumnString(
      'fileName',
      this,
    );
    uploadedByUserId = _is.ColumnInt(
      'uploadedByUserId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final FacilityDocumentUpdateTable updateTable;

  late final _is.ColumnInt facilityId;

  late final _is.ColumnInt claimRequestId;

  late final _is.ColumnEnum<_i2c0pm7z.DocumentKind> kind;

  late final _is.ColumnString storagePath;

  late final _is.ColumnString fileName;

  late final _is.ColumnInt uploadedByUserId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    facilityId,
    claimRequestId,
    kind,
    storagePath,
    fileName,
    uploadedByUserId,
    createdAt,
  ];
}

class FacilityDocumentInclude extends _is.IncludeObject {
  FacilityDocumentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FacilityDocument.t;
}

class FacilityDocumentIncludeList extends _is.IncludeList {
  FacilityDocumentIncludeList._({
    _is.WhereExpressionBuilder<FacilityDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FacilityDocument.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FacilityDocument.t;
}

class FacilityDocumentRepository {
  const FacilityDocumentRepository._();

  /// Returns a list of [FacilityDocument]s matching the given query parameters.
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
  Future<List<FacilityDocument>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FacilityDocument>(
      where: where?.call(FacilityDocument.t),
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FacilityDocument] matching the given query parameters.
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
  Future<FacilityDocument?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityDocumentTable>? where,
    int? offset,
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FacilityDocument>(
      where: where?.call(FacilityDocument.t),
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FacilityDocument] by its [id] or null if no such row exists.
  Future<FacilityDocument?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FacilityDocument>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FacilityDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [FacilityDocument]s will have their `id` fields set.
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
  Future<List<FacilityDocument>> insert(
    _is.DatabaseSession session,
    List<FacilityDocument> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FacilityDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FacilityDocument] and returns the inserted row.
  ///
  /// The returned [FacilityDocument] will have its `id` field set.
  Future<FacilityDocument> insertRow(
    _is.DatabaseSession session,
    FacilityDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FacilityDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FacilityDocument]s in the list and returns the resulting rows.
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
  /// The returned [FacilityDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityDocument>> upsert(
    _is.DatabaseSession session,
    List<FacilityDocument> rows, {
    required _is.ColumnSelections<FacilityDocumentTable> conflictColumns,
    _is.ColumnSelections<FacilityDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityDocumentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FacilityDocument>(
      rows,
      conflictColumns: conflictColumns(FacilityDocument.t),
      updateColumns: updateColumns?.call(FacilityDocument.t),
      updateWhere: updateWhere?.call(FacilityDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FacilityDocument] and returns the resulting row.
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
  /// The returned [FacilityDocument] will have its `id` field set.
  Future<FacilityDocument?> upsertRow(
    _is.DatabaseSession session,
    FacilityDocument row, {
    required _is.ColumnSelections<FacilityDocumentTable> conflictColumns,
    _is.ColumnSelections<FacilityDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<FacilityDocumentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FacilityDocument>(
      row,
      conflictColumns: conflictColumns(FacilityDocument.t),
      updateColumns: updateColumns?.call(FacilityDocument.t),
      updateWhere: updateWhere?.call(FacilityDocument.t),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityDocument>> update(
    _is.DatabaseSession session,
    List<FacilityDocument> rows, {
    _is.ColumnSelections<FacilityDocumentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FacilityDocument>(
      rows,
      columns: columns?.call(FacilityDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FacilityDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FacilityDocument> updateRow(
    _is.DatabaseSession session,
    FacilityDocument row, {
    _is.ColumnSelections<FacilityDocumentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FacilityDocument>(
      row,
      columns: columns?.call(FacilityDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FacilityDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FacilityDocument?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FacilityDocumentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FacilityDocument>(
      id,
      columnValues: columnValues(FacilityDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FacilityDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FacilityDocument>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FacilityDocumentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FacilityDocumentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FacilityDocument>(
      columnValues: columnValues(FacilityDocument.t.updateTable),
      where: where(FacilityDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FacilityDocument]s in the list and returns the deleted rows.
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
  Future<List<FacilityDocument>> delete(
    _is.DatabaseSession session,
    List<FacilityDocument> rows, {
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FacilityDocument>(
      rows,
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FacilityDocument].
  Future<FacilityDocument> deleteRow(
    _is.DatabaseSession session,
    FacilityDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FacilityDocument>(
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
  Future<List<FacilityDocument>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityDocumentTable> where,
    _is.OrderByBuilder<FacilityDocumentTable>? orderBy,
    _is.OrderByListBuilder<FacilityDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FacilityDocument>(
      where: where(FacilityDocument.t),
      orderBy: orderBy?.call(FacilityDocument.t),
      orderByList: orderByList?.call(FacilityDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FacilityDocumentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FacilityDocument>(
      where: where?.call(FacilityDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FacilityDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FacilityDocumentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FacilityDocument>(
      where: where(FacilityDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
