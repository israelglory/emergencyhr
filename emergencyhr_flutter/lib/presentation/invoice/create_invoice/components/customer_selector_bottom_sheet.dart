import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class CustomerSelectorBottomSheet extends StatefulWidget {
  final List<Customer> customers;
  final ValueChanged<Customer> onCustomerSelected;

  const CustomerSelectorBottomSheet({
    super.key,
    required this.customers,
    required this.onCustomerSelected,
  });

  @override
  State<CustomerSelectorBottomSheet> createState() =>
      _CustomerSelectorBottomSheetState();
}

class _CustomerSelectorBottomSheetState
    extends State<CustomerSelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Customer> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.customers;
  }

  void _onSearch(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = widget.customers;
      } else {
        _filtered = widget.customers
            .where(
              (c) =>
                  c.name.toLowerCase().contains(q) ||
                  c.phone.toLowerCase().contains(q) ||
                  c.address.toLowerCase().contains(q),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Select Customer',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 22, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Search
          AppCustomTextField(
            textEditingController: _searchController,
            hintText: 'Search customer name or phone...',
            onChanged: _onSearch,
            prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
          ),
          const SizedBox(height: 12),

          // List
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_off_outlined,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          'No customers found',
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final customer = _filtered[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            customer.name.isNotEmpty
                                ? customer.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: AppText(
                          customer.name,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (customer.phone.isNotEmpty)
                              AppText(
                                customer.phone,
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            if (customer.address.isNotEmpty)
                              AppText(
                                customer.address,
                                fontSize: 11,
                                color: Colors.grey.shade500,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          widget.onCustomerSelected(customer);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
