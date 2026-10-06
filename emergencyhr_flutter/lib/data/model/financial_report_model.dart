import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';

class FinancialReport {
  final int totalInvoicesCount;
  final double totalInvoicedAmount;
  final double totalCollectedAmount;
  final double totalOutstandingAmount;
  final double collectionRate;
  final double totalExpensesAmount;
  final double netIncome;
  final ReportStatusBreakdown statusBreakdown;
  final List<MonthlyChartData> monthlyChartData;
  final List<PaymentMethodStat> paymentMethodStats;
  final List<PaymentReceipt> recentReceipts;

  FinancialReport({
    required this.totalInvoicesCount,
    required this.totalInvoicedAmount,
    required this.totalCollectedAmount,
    required this.totalOutstandingAmount,
    required this.collectionRate,
    required this.totalExpensesAmount,
    required this.netIncome,
    required this.statusBreakdown,
    required this.monthlyChartData,
    required this.paymentMethodStats,
    required this.recentReceipts,
  });

  factory FinancialReport.fromJson(Map<String, dynamic> json) {
    return FinancialReport(
      totalInvoicesCount: (json['totalInvoicesCount'] as num?)?.toInt() ?? 0,
      totalInvoicedAmount:
          (json['totalInvoicedAmount'] as num?)?.toDouble() ?? 0.0,
      totalCollectedAmount:
          (json['totalCollectedAmount'] as num?)?.toDouble() ?? 0.0,
      totalOutstandingAmount:
          (json['totalOutstandingAmount'] as num?)?.toDouble() ?? 0.0,
      collectionRate: (json['collectionRate'] as num?)?.toDouble() ?? 0.0,
      totalExpensesAmount:
          (json['totalExpensesAmount'] as num?)?.toDouble() ?? 0.0,
      netIncome: (json['netIncome'] as num?)?.toDouble() ?? 0.0,
      statusBreakdown: json['statusBreakdown'] != null
          ? ReportStatusBreakdown.fromJson(
              json['statusBreakdown'] as Map<String, dynamic>,
            )
          : ReportStatusBreakdown.empty(),
      monthlyChartData:
          (json['monthlyChartData'] as List<dynamic>?)
              ?.map(
                (item) =>
                    MonthlyChartData.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      paymentMethodStats:
          (json['paymentMethodStats'] as List<dynamic>?)
              ?.map(
                (item) =>
                    PaymentMethodStat.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      recentReceipts:
          (json['recentReceipts'] as List<dynamic>?)
              ?.map(
                (item) => PaymentReceipt.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'totalInvoicesCount': totalInvoicesCount,
    'totalInvoicedAmount': totalInvoicedAmount,
    'totalCollectedAmount': totalCollectedAmount,
    'totalOutstandingAmount': totalOutstandingAmount,
    'collectionRate': collectionRate,
    'totalExpensesAmount': totalExpensesAmount,
    'netIncome': netIncome,
    'statusBreakdown': statusBreakdown.toJson(),
    'monthlyChartData': monthlyChartData.map((item) => item.toJson()).toList(),
    'paymentMethodStats': paymentMethodStats
        .map((item) => item.toJson())
        .toList(),
    'recentReceipts': recentReceipts.map((item) => item.toJson()).toList(),
  };

  factory FinancialReport.empty() => FinancialReport(
    totalInvoicesCount: 0,
    totalInvoicedAmount: 0.0,
    totalCollectedAmount: 0.0,
    totalOutstandingAmount: 0.0,
    collectionRate: 0.0,
    totalExpensesAmount: 0.0,
    netIncome: 0.0,
    statusBreakdown: ReportStatusBreakdown.empty(),
    monthlyChartData: [],
    paymentMethodStats: [],
    recentReceipts: [],
  );
}

class ReportStatusBreakdown {
  final CountAmount paid;
  final PartiallyPaidBreakdown partiallyPaid;
  final CountAmount unpaid;

  ReportStatusBreakdown({
    required this.paid,
    required this.partiallyPaid,
    required this.unpaid,
  });

  factory ReportStatusBreakdown.fromJson(Map<String, dynamic> json) {
    return ReportStatusBreakdown(
      paid: json['paid'] != null
          ? CountAmount.fromJson(json['paid'] as Map<String, dynamic>)
          : CountAmount.empty(),
      partiallyPaid: json['partiallyPaid'] != null
          ? PartiallyPaidBreakdown.fromJson(
              json['partiallyPaid'] as Map<String, dynamic>,
            )
          : PartiallyPaidBreakdown.empty(),
      unpaid: json['unpaid'] != null
          ? CountAmount.fromJson(json['unpaid'] as Map<String, dynamic>)
          : CountAmount.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
    'paid': paid.toJson(),
    'partiallyPaid': partiallyPaid.toJson(),
    'unpaid': unpaid.toJson(),
  };

  factory ReportStatusBreakdown.empty() => ReportStatusBreakdown(
    paid: CountAmount.empty(),
    partiallyPaid: PartiallyPaidBreakdown.empty(),
    unpaid: CountAmount.empty(),
  );
}

class CountAmount {
  final int count;
  final double amount;

  CountAmount({required this.count, required this.amount});

  factory CountAmount.fromJson(Map<String, dynamic> json) => CountAmount(
    count: (json['count'] as num?)?.toInt() ?? 0,
    amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'amount': amount,
  };

  factory CountAmount.empty() => CountAmount(count: 0, amount: 0.0);
}

class PartiallyPaidBreakdown {
  final int count;
  final double collectedAmount;
  final double outstandingAmount;

  PartiallyPaidBreakdown({
    required this.count,
    required this.collectedAmount,
    required this.outstandingAmount,
  });

  double get totalAmount => collectedAmount + outstandingAmount;

  factory PartiallyPaidBreakdown.fromJson(Map<String, dynamic> json) =>
      PartiallyPaidBreakdown(
        count: (json['count'] as num?)?.toInt() ?? 0,
        collectedAmount: (json['collectedAmount'] as num?)?.toDouble() ?? 0.0,
        outstandingAmount:
            (json['outstandingAmount'] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    'count': count,
    'collectedAmount': collectedAmount,
    'outstandingAmount': outstandingAmount,
  };

  factory PartiallyPaidBreakdown.empty() => PartiallyPaidBreakdown(
    count: 0,
    collectedAmount: 0.0,
    outstandingAmount: 0.0,
  );
}

class MonthlyChartData {
  final String monthName;
  final double invoiced;
  final double collected;
  final double expenses;

  MonthlyChartData({
    required this.monthName,
    required this.invoiced,
    required this.collected,
    required this.expenses,
  });

  factory MonthlyChartData.fromJson(Map<String, dynamic> json) =>
      MonthlyChartData(
        monthName: json['monthName']?.toString() ?? '',
        invoiced: (json['invoiced'] as num?)?.toDouble() ?? 0.0,
        collected: (json['collected'] as num?)?.toDouble() ?? 0.0,
        expenses: (json['expenses'] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    'monthName': monthName,
    'invoiced': invoiced,
    'collected': collected,
    'expenses': expenses,
  };
}

class PaymentMethodStat {
  final String method;
  final double totalAmount;
  final int count;

  PaymentMethodStat({
    required this.method,
    required this.totalAmount,
    required this.count,
  });

  factory PaymentMethodStat.fromJson(Map<String, dynamic> json) =>
      PaymentMethodStat(
        method: json['method']?.toString() ?? 'Other',
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
        count: (json['count'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'method': method,
    'totalAmount': totalAmount,
    'count': count,
  };
}
