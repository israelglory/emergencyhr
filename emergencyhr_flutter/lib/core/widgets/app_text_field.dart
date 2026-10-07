import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_text.dart';

/// Labelled text input: 14/600 label, 48 high field with a 12 radius, hint
/// or error underneath.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.large = false,
    this.rounded = false,
    this.semanticsLabel,
  });

  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;

  /// 20 / 600 with letter spacing 4, for codes.
  final bool large;

  /// Pill shape, 44 high, e.g. the Health Assistant composer.
  final bool rounded;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final multiline = (maxLines ?? 2) > 1 && !rounded;
    OutlineInputBorder pill(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(color: c, width: w),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          AppText.label(label!),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onTap: onTap,
          maxLines: maxLines,
          minLines: minLines ?? (multiline ? 3 : null),
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscureText,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
          textAlign: textAlign,
          cursorColor: p.primary,
          style: large
              ? AppTypography.title.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                  color: p.text,
                )
              : AppTypography.body.copyWith(color: p.text),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            errorMaxLines: 3,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counterText: '',
            semanticCounterText: '',
            contentPadding: rounded
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 11)
                : multiline
                ? const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
                : null,
            enabledBorder: rounded ? pill(p.inputBorder) : null,
            focusedBorder: rounded ? pill(p.primary, 1.5) : null,
            border: rounded ? pill(p.inputBorder) : null,
          ),
        ),
        if (helperText != null && errorText == null) ...[
          const SizedBox(height: 6),
          AppText.caption(helperText!),
        ],
      ],
    );
  }
}
