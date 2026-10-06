import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCustomTextField extends StatelessWidget {
  final String? title, hintText, initialText, labelText;
  final TextInputType? textInputType;
  final Widget? icon, suffixIcon, prefixIcon;
  final bool? obscureText, enabled, autofocus, showCursor, isDense;
  final String? obscureChar, suffixText, errorText;
  final TextEditingController? textEditingController;
  final Function()? onTap;
  final double? fontSize,
      borderWidth,
      focusBorderWidth,
      borderRadius,
      textHeight;
  final int? maxLines, minLines, maxLength, hintMaxLines;
  final EdgeInsets? margin;
  final Iterable<String>? autofillHints;
  final EdgeInsets? padding, containerPadding;
  final Function(String)? onChanged, onSubmitted;
  final FormFieldValidator<String>? validator;
  final Function()? onEditingComplete;
  final TextStyle? errorStyle, labelTextStyle;
  final TextAlign? textAlign;
  final BoxConstraints? suffixBoxConstraints, prefixBoxConstraints, constraints;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final FontWeight? fontWeight;
  final bool? disableTyping;

  final OutlineInputBorder? disabledBorder,
      enabledBorder,
      focusedBorder,
      errorBorder;
  final Color? borderColor,
      focusBorderColor,
      backgroundColor,
      errorBorderColor,
      hintTextColor,
      cursorColor,
      textColor;
  final TextAlignVertical? textAlignVertical;
  final bool? readOnly;
  final TextStyle? suffixStyle;
  final TextCapitalization? textCapitalization;
  final Widget? counter;
  final Widget? Function(BuildContext context,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;

  const AppCustomTextField(
      {super.key,
      this.title,
      this.hintText,
      this.textInputType,
      this.icon,
      this.disableTyping,
      this.suffixIcon,
      this.obscureText,
      this.obscureChar,
      this.onTap,
      this.fontSize,
      this.maxLines,
      this.minLines,
      this.margin,
      this.padding,
      this.onChanged,
      this.onEditingComplete,
      this.counter,
      this.suffixText,
      this.validator,
      this.initialText,
      this.textEditingController,
      this.enabled,
      this.suffixBoxConstraints,
      this.prefixBoxConstraints,
      this.errorText,
      this.errorStyle,
      this.maxLength,
      this.inputFormatters,
      this.autofocus,
      this.textAlign,
      this.focusNode,
      this.showCursor,
      this.borderWidth,
      this.autofillHints,
      this.prefixIcon,
      this.borderColor,
      this.borderRadius,
      this.backgroundColor,
      this.focusBorderColor,
      this.focusBorderWidth,
      this.textHeight,
      this.errorBorderColor,
      this.textInputAction,
      this.onSubmitted,
      this.disabledBorder,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.labelText,
      this.labelTextStyle,
      this.textAlignVertical,
      this.constraints,
      this.textColor,
      this.fontWeight,
      this.buildCounter,
      this.textCapitalization,
      this.isDense,
      this.hintTextColor,
      this.hintMaxLines,
      this.suffixStyle,
      this.readOnly,
      this.containerPadding,
      this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Padding(
        padding: containerPadding ?? EdgeInsets.only(right: 0, left: 0),
        child: IgnorePointer(
          ignoring: disableTyping ?? false,
          child: TextFormField(
            readOnly: readOnly ?? false,
            autofillHints: autofillHints,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            maxLength: maxLength,
            textCapitalization:
                textCapitalization ?? TextCapitalization.sentences,
            validator: validator,
            textAlign: textAlign ?? TextAlign.start,
            style: TextStyle(
                fontSize: fontSize ?? 15,
                height: textHeight,
                fontFamily: GoogleFonts.inter().fontFamily,
                color: textColor ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.w500),
            initialValue: initialText,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            onTap: onTap,
            cursorColor: cursorColor ?? Colors.black,
            showCursor: showCursor ?? true,
            obscureText: obscureText == null ? false : obscureText!,
            obscuringCharacter: obscureChar != null ? obscureChar! : '*',
            keyboardType: textInputType,
            textInputAction: textInputAction,
            onFieldSubmitted: onSubmitted,
            maxLines: maxLines,
            textAlignVertical: textAlignVertical,
            minLines: minLines,
            buildCounter: buildCounter ??
                (
                  BuildContext context, {
                  int? currentLength,
                  int? maxLength,
                  bool? isFocused,
                }) {
                  return null; // This hides the counter altogether
                },
            controller: textEditingController,
            enabled: enabled ?? true,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              suffixStyle: suffixStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Inter",
                  ),
              counter: counter,
              alignLabelWithHint: true,
              labelText: labelText,
              labelStyle: labelTextStyle,
              prefixIcon: prefixIcon,
              errorStyle: errorStyle,
              errorText: errorText,
              isDense: isDense ?? true,
              contentPadding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixText: suffixText,
              suffixIconConstraints: suffixBoxConstraints,
              suffixIcon: suffixIcon,
              icon: icon == null
                  ? null
                  : Container(
                      margin: const EdgeInsets.only(left: 16), child: icon),
              constraints: constraints,
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                    borderSide: BorderSide(
                        color: focusBorderColor ?? Colors.black,
                        width: focusBorderWidth ?? 1),
                  ),
              disabledBorder: disabledBorder,
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                    borderSide: BorderSide(
                        color: borderColor ?? Colors.grey,
                        width: borderWidth ?? 1),
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(
                    color: borderColor ?? Colors.grey, width: borderWidth ?? 1),
              ),
              errorBorder: errorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8),
                    borderSide: BorderSide(
                        color: errorBorderColor ?? Colors.red,
                        width: borderWidth ?? 1),
                  ),
              filled: true,
              fillColor: backgroundColor ?? Colors.transparent,
              hintText: hintText,
              hintMaxLines: hintMaxLines,
              hintStyle: GoogleFonts.outfit(
                textStyle: TextStyle(
                  color: hintTextColor ?? Colors.grey,
                  fontSize: fontSize,
                  fontFamily: "Inter",
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
