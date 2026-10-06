import 'package:flutter/material.dart';

class AppRectangle extends StatelessWidget {
  const AppRectangle(
      {super.key,
      this.color,
      this.radius,
      this.child,
      this.margin,
      this.padding,
      this.height,
      this.borderColor,
      this.borderWidth,
      this.width,
      this.alignment,
      this.image,
      this.shadow});
  final Color? color, borderColor;
  final double? radius;
  final double? height, width;
  final double? borderWidth;
  final Widget? child;
  final AlignmentGeometry? alignment;
  final EdgeInsets? margin, padding;
  final BoxShadow? shadow;
  final DecorationImage? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: shadow == null ? null : [shadow!],
        image: image,
        borderRadius: BorderRadius.circular(radius ?? 0),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1,
              )
            : null,
        color: color,
      ),
      child: child,
    );
  }
}
