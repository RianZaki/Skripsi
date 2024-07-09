import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class MainTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final bool obscureText;
  final void Function(String)? onSubmitted;

  final bool enable;
  final bool? autofocus;

  final void Function()? onTap;
  final bool? enabled;
  final Widget? suffixIcon;
  final int maxLines;

  const MainTextField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.label,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.enable = true,
    this.onTap,
    this.autofocus,
    this.enabled = true,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus ?? false,
      controller: widget.controller,
      enabled: widget.enable,
      focusNode: _focusNode,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      obscuringCharacter: '●',
      onTap: widget.onTap,
      maxLines: widget.obscureText == false ? widget.maxLines : 1,
      decoration: InputDecoration(
        errorText: widget.errorText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Pallete.info),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusColor: Pallete.info,
        hintText: widget.hintText,
        labelStyle: TextStyle(color: _isFocused ? Pallete.info : Pallete.dark3),
        label: widget.label != null ? Text(widget.label ?? "") : null,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon!,
                color: Pallete.dark3,
              )
            : null,
        contentPadding: const EdgeInsets.all(18),
      ),
      style: ThemeFont.bodySmall,
    );
  }
}
