import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Small circular progress indicator: primary arc on a border-coloured ring.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: color ?? p.primary,
        backgroundColor: color == null ? p.border : Colors.transparent,
      ),
    );
  }
}
