import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/cores.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            height: 30,
            child: CircleAvatar(
              backgroundImage: AssetImage(AppAssets.userProfilePNG),
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppText(
                    'Hello ',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  Flexible(
                    child: AppText(
                      toBeginningOfSentenceCase(
                          appGlobals.user?.fullName.split(' ').first ?? "Bglow"),
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const AppText(
                '...imagine it, we create it',
                fontSize: 12,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
