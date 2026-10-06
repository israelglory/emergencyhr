import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/home_viewmodel.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/widgets/carousel.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/widgets/home_header.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/widgets/report_overview.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/widgets/service_item.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/report/report_view.dart';
import 'package:emergencyhr_flutter/presentation/customers/customer_list_view.dart';
import 'package:emergencyhr_flutter/presentation/expense/expense_home_view.dart';
import 'package:emergencyhr_flutter/presentation/invoice/invoice_home_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            spacing: 16.0,
            children: [
              HomeHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 16,
                    children: [
                      ///Carosel
                      CarouselWidget(
                        quotes: model.quotes,
                        onPageChanged: (index, reason) {
                          model.setCarouselIndex(index);
                        },
                      ),

                      //Services
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppText(
                          "Services",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //Service Items
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ServiceItem(
                              asset: AppAssets.invoiceIcon,
                              text: "Invoice",
                              backgroundColor: Colors.grey.shade300,
                              onTap: () {
                                navigationService.push(InvoiceHomeView());
                              },
                            ),
                            ServiceItem(
                              asset: AppAssets.expensesIcon,
                              text: "Expenses",
                              backgroundColor: Colors.grey.shade300,
                              onTap: () {
                                navigationService.push(const ExpenseHomeView());
                              },
                            ),
                            ServiceItem(
                              asset: AppAssets.incomeIcon,
                              text: "Customers",
                              backgroundColor: Colors.grey.shade300,
                              onTap: () {
                                navigationService.push(
                                  const CustomerListView(),
                                );
                              },
                            ),
                            if (appGlobals.canViewFinancialReports)
                              ServiceItem(
                                asset: AppAssets.reportIcon,
                                text: "Report",
                                backgroundColor: Colors.grey.shade300,
                                onTap: () {
                                  navigationService.push(
                                    const ReportView(isBack: true),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),

                      //Report Overview (Admin and Staff only)
                      if (appGlobals.canViewFinancialReports) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: AppText(
                            "Report Overview",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ReportOverview(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
