import 'package:flutter/material.dart';

import '../cores.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;
  final bool isBack;
  final Function()? onBack;
  final Widget? trailing;
  final Color? backColor;

  const CustomAppBar(
      {super.key,
      this.actions,
      this.title,
      required this.isBack,
      this.backColor,
      this.onBack,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(
        //   width: 12,
        // ),
        if (isBack)
          GestureDetector(
            onTap: onBack ??
                () {
                  if (Navigator.of(context).canPop()) {
                    navigationService.pop();
                  }
                },
            child: Icon(
              Icons.arrow_back_ios,
              color: backColor ?? Colors.black,
            ),
          )
        else
          const SizedBox(
            height: 32,
            width: 32,
          ),
        // const Spacer(),
        Expanded(
          child: AppText(
            title ?? '',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            alignment: TextAlign.center,
          ),
        ),
        // const Spacer(),
        trailing ??
            const SizedBox(
              height: 32,
              width: 32,
            )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
