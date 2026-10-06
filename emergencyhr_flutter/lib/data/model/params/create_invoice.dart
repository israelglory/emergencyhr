import 'package:emergencyhr_flutter/data/model/customer_model.dart';
import 'package:flutter/material.dart';

class InvoiceItemInput {
  final TextEditingController nameController;
  final TextEditingController qtyController;
  final TextEditingController priceController;

  InvoiceItemInput()
    : nameController = TextEditingController(),
      qtyController = TextEditingController(),
      priceController = TextEditingController();

  double get total {
    final qty = int.tryParse(qtyController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0.0;
    return qty * price;
  }

  InvoiceItem toInvoiceItem() {
    return InvoiceItem(
      name: nameController.text.trim(),
      quantity: int.tryParse(qtyController.text) ?? 0,
      price: double.tryParse(priceController.text) ?? 0.0,
    );
  }

  void dispose() {
    nameController.dispose();
    qtyController.dispose();
    priceController.dispose();
  }
}

class InvoiceItem {
  final String name;
  final int quantity;
  final double price;
  final double? totalAmount;

  InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.totalAmount,
  });

  double get total => totalAmount ?? (quantity * price);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      if (totalAmount != null) 'total': totalAmount,
    };
  }

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      name: json['name']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total'] as num?)?.toDouble(),
    );
  }
}

enum InvoiceStatus {
  unpaid,
  partiallyPaid,
  paid;

  String get label {
    switch (this) {
      case InvoiceStatus.unpaid:
        return 'UNPAID';
      case InvoiceStatus.partiallyPaid:
        return 'PARTIALLY PAID';
      case InvoiceStatus.paid:
        return 'PAID';
    }
  }

  static InvoiceStatus fromString(String? status) {
    switch (status?.toUpperCase()) {
      case 'PAID':
        return InvoiceStatus.paid;
      case 'PARTIALLY_PAID':
      case 'PARTIALLY PAID':
      case 'PARTIAL':
        return InvoiceStatus.partiallyPaid;
      case 'UNPAID':
      default:
        return InvoiceStatus.unpaid;
    }
  }
}

class PaymentReceipt {
  final String id;
  final String receiptNumber;
  final String invoiceId;
  final String invoiceNumber;
  final DateTime paymentDate;
  final double amount;
  final String paymentMethod;
  final String? note;
  final double previousAmountPaid;
  final double totalAmountPaid;
  final double previousBalance;
  final double remainingBalance;
  final double invoiceTotal;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final DateTime createdAt;

  PaymentReceipt({
    required this.id,
    required this.receiptNumber,
    required this.invoiceId,
    required this.invoiceNumber,
    required this.paymentDate,
    required this.amount,
    this.paymentMethod = 'Bank Transfer',
    this.note,
    required this.previousAmountPaid,
    required this.totalAmountPaid,
    required this.previousBalance,
    required this.remainingBalance,
    required this.invoiceTotal,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiptNumber': receiptNumber,
      'invoiceId': invoiceId,
      'invoiceNumber': invoiceNumber,
      'paymentDate': paymentDate.toUtc().toIso8601String(),
      'amount': amount,
      'paymentMethod': paymentMethod,
      'note': note,
      'previousAmountPaid': previousAmountPaid,
      'totalAmountPaid': totalAmountPaid,
      'previousBalance': previousBalance,
      'remainingBalance': remainingBalance,
      'invoiceTotal': invoiceTotal,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }

  factory PaymentReceipt.fromJson(Map<String, dynamic> json) {
    return PaymentReceipt(
      id: json['id']?.toString() ?? '',
      receiptNumber: json['receiptNumber']?.toString() ?? '',
      invoiceId: json['invoiceId']?.toString() ?? '',
      invoiceNumber: json['invoiceNumber']?.toString() ?? '',
      paymentDate: json['paymentDate'] != null
          ? DateTime.tryParse(json['paymentDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod']?.toString() ?? 'Bank Transfer',
      note: json['note']?.toString(),
      previousAmountPaid:
          (json['previousAmountPaid'] as num?)?.toDouble() ?? 0.0,
      totalAmountPaid: (json['totalAmountPaid'] as num?)?.toDouble() ?? 0.0,
      previousBalance: (json['previousBalance'] as num?)?.toDouble() ?? 0.0,
      remainingBalance: (json['remainingBalance'] as num?)?.toDouble() ?? 0.0,
      invoiceTotal: (json['invoiceTotal'] as num?)?.toDouble() ?? 0.0,
      customerName: json['customerName']?.toString() ?? '',
      customerAddress: json['customerAddress']?.toString() ?? '',
      customerPhone: json['customerPhone']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class Invoice {
  final String id;
  final String? invoiceNumberRaw;
  final String? branchId;
  final Customer? customer;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final List<InvoiceItem> items;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final double subtotal;
  final double taxRate;
  final double tax;
  final double total;
  final double? amountPaidExplicit;
  final double? amountRemainingExplicit;
  final String? statusString;
  final DateTime createdAt;
  final List<PaymentReceipt> payments;

  Invoice({
    required this.id,
    this.invoiceNumberRaw,
    this.branchId,
    this.customer,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.items,
    required this.invoiceDate,
    required this.dueDate,
    required this.subtotal,
    this.taxRate = 0.0,
    required this.tax,
    required this.total,
    this.amountPaidExplicit,
    this.amountRemainingExplicit,
    this.statusString,
    required this.createdAt,
    this.payments = const [],
  });

  String get invoiceNumber {
    if (invoiceNumberRaw != null && invoiceNumberRaw!.isNotEmpty) {
      return invoiceNumberRaw!;
    }
    return 'INV-${id.length >= 8 ? id.substring(0, 8).toUpperCase() : id.toUpperCase()}';
  }

  double get amountPaid {
    if (amountPaidExplicit != null && amountPaidExplicit! > 0) {
      return amountPaidExplicit!;
    }
    return payments.fold(0.0, (sum, p) => sum + p.amount);
  }

  double get amountRemaining {
    if (amountRemainingExplicit != null) {
      return amountRemainingExplicit!;
    }
    final remaining = total - amountPaid;
    if (remaining <= 0.0001) return 0.0;
    return remaining;
  }

  InvoiceStatus get status {
    if (statusString != null && statusString!.isNotEmpty) {
      return InvoiceStatus.fromString(statusString);
    }
    if (amountPaid <= 0.0001) {
      return InvoiceStatus.unpaid;
    } else if (amountRemaining <= 0.0001) {
      return InvoiceStatus.paid;
    } else {
      return InvoiceStatus.partiallyPaid;
    }
  }

  Invoice copyWith({
    String? id,
    String? invoiceNumberRaw,
    String? branchId,
    Customer? customer,
    String? customerName,
    String? customerAddress,
    String? customerPhone,
    List<InvoiceItem>? items,
    DateTime? invoiceDate,
    DateTime? dueDate,
    double? subtotal,
    double? taxRate,
    double? tax,
    double? total,
    double? amountPaidExplicit,
    double? amountRemainingExplicit,
    String? statusString,
    DateTime? createdAt,
    List<PaymentReceipt>? payments,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumberRaw: invoiceNumberRaw ?? this.invoiceNumberRaw,
      branchId: branchId ?? this.branchId,
      customer: customer ?? this.customer,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      subtotal: subtotal ?? this.subtotal,
      taxRate: taxRate ?? this.taxRate,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      amountPaidExplicit: amountPaidExplicit ?? this.amountPaidExplicit,
      amountRemainingExplicit:
          amountRemainingExplicit ?? this.amountRemainingExplicit,
      statusString: statusString ?? this.statusString,
      createdAt: createdAt ?? this.createdAt,
      payments: payments ?? this.payments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (invoiceNumberRaw != null) 'invoiceNumber': invoiceNumberRaw,
      if (branchId != null) 'branchId': branchId,
      if (customer != null) 'customer': customer!.toJson(),
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'items': items.map((item) => item.toJson()).toList(),
      'invoiceDate': invoiceDate.toUtc().toIso8601String(),
      'dueDate': dueDate.toUtc().toIso8601String(),
      'subtotal': subtotal,
      'taxRate': taxRate,
      'tax': tax,
      'total': total,
      'amountPaid': amountPaid,
      'amountRemaining': amountRemaining,
      'status': status.label,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'payments': payments.map((p) => p.toJson()).toList(),
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    final subtotal = (json['subtotal'] as num?)?.toDouble() ?? 0.0;
    final tax = (json['tax'] as num?)?.toDouble() ?? 0.0;
    final taxRate =
        (json['taxRate'] as num?)?.toDouble() ??
        (subtotal > 0 && tax > 0 ? (tax / subtotal) * 100 : 0.0);

    Customer? customerObj;
    if (json['customer'] is Map<String, dynamic>) {
      customerObj = Customer.fromJson(json['customer'] as Map<String, dynamic>);
    }

    final name = customerObj?.name.isNotEmpty == true
        ? customerObj!.name
        : (json['customerName']?.toString() ?? '');
    final address = customerObj?.address.isNotEmpty == true
        ? customerObj!.address
        : (json['customerAddress']?.toString() ?? '');
    final phone = customerObj?.phone.isNotEmpty == true
        ? customerObj!.phone
        : (json['customerPhone']?.toString() ?? '');

    return Invoice(
      id: json['id']?.toString() ?? '',
      invoiceNumberRaw: json['invoiceNumber']?.toString(),
      branchId: json['branchId']?.toString(),
      customer: customerObj,
      customerName: name,
      customerAddress: address,
      customerPhone: phone,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => InvoiceItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      invoiceDate: json['invoiceDate'] != null
          ? DateTime.tryParse(json['invoiceDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      subtotal: subtotal,
      taxRate: taxRate,
      tax: tax,
      total: (json['total'] as num?)?.toDouble() ?? subtotal + tax,
      amountPaidExplicit: (json['amountPaid'] as num?)?.toDouble(),
      amountRemainingExplicit: (json['amountRemaining'] as num?)?.toDouble(),
      statusString: json['status']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((p) => PaymentReceipt.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class CreateInvoiceParam {
  final String branchId;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final double taxRate;
  final List<InvoiceItem> items;

  CreateInvoiceParam({
    required this.branchId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.invoiceDate,
    required this.dueDate,
    this.taxRate = 0.0,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "customerName": customerName,
    "customerAddress": customerAddress,
    "customerPhone": customerPhone,
    "invoiceDate": invoiceDate.toUtc().toIso8601String(),
    "dueDate": dueDate.toUtc().toIso8601String(),
    "taxRate": taxRate,
    "items": items.map((i) => i.toJson()).toList(),
  };

  factory CreateInvoiceParam.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceParam(
        branchId: json["branchId"]?.toString() ?? '',
        customerName: json["customerName"]?.toString() ?? '',
        customerAddress: json["customerAddress"]?.toString() ?? '',
        customerPhone: json["customerPhone"]?.toString() ?? '',
        invoiceDate: json["invoiceDate"] != null
            ? DateTime.tryParse(json["invoiceDate"].toString()) ??
                  DateTime.now()
            : DateTime.now(),
        dueDate: json["dueDate"] != null
            ? DateTime.tryParse(json["dueDate"].toString()) ?? DateTime.now()
            : DateTime.now(),
        taxRate: (json["taxRate"] as num?)?.toDouble() ?? 0.0,
        items:
            (json["items"] as List<dynamic>?)
                ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class RecordPaymentParam {
  final double amount;
  final DateTime paymentDate;
  final String paymentMethod;
  final String? note;

  RecordPaymentParam({
    required this.amount,
    required this.paymentDate,
    this.paymentMethod = 'Bank Transfer',
    this.note,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "paymentDate": paymentDate.toUtc().toIso8601String(),
    "paymentMethod": paymentMethod,
    if (note != null && note!.isNotEmpty) "note": note,
  };

  factory RecordPaymentParam.fromJson(Map<String, dynamic> json) =>
      RecordPaymentParam(
        amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
        paymentDate: json["paymentDate"] != null
            ? DateTime.tryParse(json["paymentDate"].toString()) ??
                  DateTime.now()
            : DateTime.now(),
        paymentMethod: json["paymentMethod"]?.toString() ?? 'Bank Transfer',
        note: json["note"]?.toString(),
      );
}
