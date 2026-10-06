class Expense {
  final String id;
  final String? branchId;
  final String title;
  final double amount;
  final String category;
  final String? note;
  final DateTime date;
  final DateTime createdAt;

  Expense({
    required this.id,
    this.branchId,
    required this.title,
    required this.amount,
    this.category = 'General',
    this.note,
    required this.date,
    required this.createdAt,
  });

  Expense copyWith({
    String? id,
    String? branchId,
    String? title,
    double? amount,
    String? category,
    String? note,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      note: note ?? this.note,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (branchId != null) 'branchId': branchId,
      'title': title,
      'amount': amount,
      'category': category,
      'note': note,
      'date': date.toUtc().toIso8601String(),
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id']?.toString() ?? '',
      branchId: json['branchId']?.toString(),
      title: json['title']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString() ?? 'General',
      note: json['note']?.toString(),
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class CreateExpenseParam {
  final String branchId;
  final String title;
  final double amount;
  final String category;
  final String? note;
  final DateTime date;

  CreateExpenseParam({
    required this.branchId,
    required this.title,
    required this.amount,
    this.category = 'General',
    this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'title': title,
      'amount': amount,
      'category': category,
      if (note != null && note!.isNotEmpty) 'note': note,
      'date': date.toUtc().toIso8601String(),
    };
  }

  factory CreateExpenseParam.fromJson(Map<String, dynamic> json) {
    return CreateExpenseParam(
      branchId: json['branchId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString() ?? 'General',
      note: json['note']?.toString(),
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class PaginatedExpenses {
  final List<Expense> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  PaginatedExpenses({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PaginatedExpenses.fromJson(Map<String, dynamic> json) {
    return PaginatedExpenses(
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 20,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content.map((e) => e.toJson()).toList(),
        'page': page,
        'size': size,
        'totalElements': totalElements,
        'totalPages': totalPages,
      };

  factory PaginatedExpenses.empty() => PaginatedExpenses(
        content: [],
        page: 0,
        size: 20,
        totalElements: 0,
        totalPages: 0,
      );
}
