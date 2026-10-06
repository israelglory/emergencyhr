import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/invoice/create_invoice/components/customer_selector_bottom_sheet.dart';
import 'package:emergencyhr_flutter/presentation/invoice/create_invoice/components/invoice_items.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_invoice_viewmodel.dart';

class CreateInvoiceView extends StatelessWidget {
  final String? prefilledCustomerName;
  final String? prefilledCustomerAddress;
  final String? prefilledCustomerPhone;

  const CreateInvoiceView({
    super.key,
    this.prefilledCustomerName,
    this.prefilledCustomerAddress,
    this.prefilledCustomerPhone,
  });

  void _openCustomerSelector(
    BuildContext context,
    CreateInvoiceViewModel model,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomerSelectorBottomSheet(
        customers: model.customers,
        onCustomerSelected: model.selectCustomer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateInvoiceViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => CreateInvoiceViewModel(
        prefilledCustomerName: prefilledCustomerName,
        prefilledCustomerAddress: prefilledCustomerAddress,
        prefilledCustomerPhone: prefilledCustomerPhone,
      ),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(isBack: true),
                    const SizedBox(height: 16),
                    const AppText(
                      'Create Invoice',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),

                    // Branch Selection / Display
                    if (appGlobals.isAdmin) ...[
                      const AppText(
                        'Store Branch *',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: model.branchError != null
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: model.selectedBranchId,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            hint: const AppText(
                              'Select store branch',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            items: model.branches.map((b) {
                              return DropdownMenuItem<String>(
                                value: b.id,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.storefront_outlined,
                                      size: 16,
                                      color: AppColors.primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: AppText(
                                        '${b.name}${b.isMainBranch ? ' (Main Branch)' : ''}',
                                        fontSize: 13,
                                        fontWeight: b.isMainBranch
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: model.setSelectedBranch,
                          ),
                        ),
                      ),
                      if (model.branchError != null) ...[
                        const SizedBox(height: 4),
                        AppText(
                          model.branchError!,
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ],
                      const SizedBox(height: 16),
                    ] else ...[
                      // Non-admin branch card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.storefront_outlined,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    'Assigned Store Branch',
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 2),
                                  AppText(
                                    model.assignedBranchName,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Customer Information Header & Quick Picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          'Customer Details',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        if (model.customers.isNotEmpty)
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            icon: const Icon(
                              Icons.people_alt_outlined,
                              size: 16,
                              color: AppColors.buttonColor,
                            ),
                            label: const AppText(
                              'Select Saved',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                            ),
                            onPressed: () =>
                                _openCustomerSelector(context, model),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Customer Name
                    AppCustomTextField(
                      hintText: 'Enter customer name',
                      textEditingController: model.customerNameController,
                      errorText: model.customerNameError,
                      textCapitalization: TextCapitalization.words,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Address
                    AppCustomTextField(
                      hintText: 'Enter customer address',
                      textEditingController: model.addressController,
                      errorText: model.addressError,
                      textCapitalization: TextCapitalization.sentences,
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Phone Number
                    AppCustomTextField(
                      hintText: 'Enter phone number',
                      textEditingController: model.phoneNumberController,
                      errorText: model.phoneError,
                      textInputType: TextInputType.phone,
                      prefixIcon: const Icon(
                        Icons.phone_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.contacts_outlined,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                        onPressed: model.selectContactPhone,
                        tooltip: 'Select from contacts',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dates (Invoice Date & Due Date)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                'Invoice Date',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: model.invoiceDate,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2035),
                                  );
                                  if (picked != null) {
                                    model.updateInvoiceDate(picked);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        '${model.invoiceDate.day}/${model.invoiceDate.month}/${model.invoiceDate.year}',
                                        fontSize: 13,
                                      ),
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                'Due Date',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: model.dueDate,
                                    firstDate: model.invoiceDate,
                                    lastDate: DateTime(2035),
                                  );
                                  if (picked != null) {
                                    model.updateDueDate(picked);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        '${model.dueDate.day}/${model.dueDate.month}/${model.dueDate.year}',
                                        fontSize: 13,
                                      ),
                                      const Icon(
                                        Icons.event_available_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Items Section
                    const AppText(
                      'Invoice Items',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 12),

                    // Dynamic Items List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.items.length,
                      itemBuilder: (context, index) {
                        return InvoiceItemForm(
                          item: model.items[index],
                          index: index,
                          errorText: model.itemErrors.length > index
                              ? model.itemErrors[index]
                              : null,
                          onRemove: model.items.length > 1
                              ? () => model.removeItem(index)
                              : null,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                    const SizedBox(height: 14),

                    // Add Item Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: model.addNewItem,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              AppText(
                                'Add Another Item',
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Divider(height: 32),

                    // Tax Toggle & Input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Include Value Added Tax (VAT)',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            AppText(
                              'Apply standard sales tax to invoice total',
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          value: model.isTaxEnabled,
                          onChanged: model.toggleTax,
                          activeTrackColor: AppColors.primaryColor,
                        ),
                      ],
                    ),

                    if (model.isTaxEnabled) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 3,
                            child: AppText(
                              'Tax Rate (%)',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: AppCustomTextField(
                              hintText: '7.5',
                              textEditingController: model.taxRateController,
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              suffixText: '%',
                            ),
                          ),
                        ],
                      ),
                    ],

                    const Divider(height: 32),

                    // Financial Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText(
                                'Subtotal',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              AppText(
                                CurrencyFormatter.formatNaira(model.subtotal),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                model.isTaxEnabled
                                    ? 'VAT (${model.formattedTaxRate}%)'
                                    : 'VAT (0%)',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              AppText(
                                CurrencyFormatter.formatNaira(model.tax),
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText(
                                'Invoice Total',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              AppText(
                                CurrencyFormatter.formatNaira(model.total),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    AppButton(
                      title: model.isCreatingInvoice
                          ? 'Generating Invoice...'
                          : 'Create & Issue Invoice',
                      loading: model.isCreatingInvoice,
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      radius: 10,
                      height: 48,
                      onPressed: model.isCreatingInvoice
                          ? null
                          : model.createInvoice,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
