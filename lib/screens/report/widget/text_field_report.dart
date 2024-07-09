import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class TextFieldReport extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final Color? focusColor;
  final TextStyle? labelStyle, hintStyle;
  final String? label;
  final bool? enabled;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  const TextFieldReport({
    Key? key,
    this.hintText,
    this.maxLines,
    this.focusColor,
    this.labelStyle,
    this.enabled,
    this.contentPadding,
    this.controller,
    this.onChanged,
    this.label,
    this.prefixIcon,
    this.hintStyle,
    this.onPressed,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: ThemeFont.bodySmallMedium.copyWith(color: Pallete.dark1),
        hintStyle: ThemeFont.bodySmallMedium.copyWith(color: Pallete.dark3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor ?? Pallete.dark1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor ?? Pallete.info),
        ),
        labelText: label,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Pallete.dark3) : null,
        hintText: hintText,
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
      ),
      maxLines: maxLines,
      onTap: onPressed,
      focusNode: focusNode,
    );
  }
}
