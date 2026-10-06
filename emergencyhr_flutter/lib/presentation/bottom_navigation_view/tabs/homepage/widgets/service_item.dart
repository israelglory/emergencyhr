import 'package:flutter/material.dart';

import '../../../../../core/cores.dart';

class ServiceItem extends StatelessWidget {
  final String asset;
  final String text;
  final Color backgroundColor;
  final Function() onTap;
  const ServiceItem({
    super.key,
    required this.asset,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              asset,
              height: 22,
              width: 22,
            ),
          ),
          SizedBox(height: 8),
          AppText(
            text,
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
