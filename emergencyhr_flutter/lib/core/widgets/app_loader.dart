import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Small circular progress indicator.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? context.palette.text,
      ),
    );
  }
}
