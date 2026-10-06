import 'package:emergencyhr_flutter/data/model/customer_model.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';

class CustomerStatement {
  final Customer customer;
  final double totalAmount;
  final double totalPaid;
  final double totalRemaining;
  final int totalInvoices;
  final List<Invoice> invoices;

  CustomerStatement({
    required this.customer,
    required this.totalAmount,
    required this.totalPaid,
    required this.totalRemaining,
    required this.totalInvoices,
    required this.invoices,
  });

  double get collectionRate =>
      totalAmount > 0 ? (totalPaid / totalAmount) * 100 : 0.0;

  int get paidCount =>
      invoices.where((inv) => inv.status == InvoiceStatus.paid).length;

  int get partiallyPaidCount =>
      invoices.where((inv) => inv.status == InvoiceStatus.partiallyPaid).length;

  int get unpaidCount =>
      invoices.where((inv) => inv.status == InvoiceStatus.unpaid).length;

  factory CustomerStatement.fromJson(Map<String, dynamic> json) {
    return CustomerStatement(
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : Customer(id: '', name: '', address: '', phone: ''),
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0.0,
      totalRemaining: (json['totalRemaining'] as num?)?.toDouble() ?? 0.0,
      totalInvoices: (json['totalInvoices'] as num?)?.toInt() ?? 0,
      invoices:
          (json['invoices'] as List<dynamic>?)
              ?.map((item) => Invoice.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'customer': customer.toJson(),
    'totalAmount': totalAmount,
    'totalPaid': totalPaid,
    'totalRemaining': totalRemaining,
    'totalInvoices': totalInvoices,
    'invoices': invoices.map((inv) => inv.toJson()).toList(),
  };

  factory CustomerStatement.empty({Customer? customer}) => CustomerStatement(
    customer: customer ?? Customer(id: '', name: '', address: '', phone: ''),
    totalAmount: 0.0,
    totalPaid: 0.0,
    totalRemaining: 0.0,
    totalInvoices: 0,
    invoices: [],
  );
}
