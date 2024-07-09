import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final String? errorText;

  final TextEditingController? controller;
  final bool? enable;

  const PasswordTextField(
      {super.key,
      required this.label,
      this.controller,
      this.enable = true,
      this.errorText});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: widget.controller,
        enabled: widget.enable,
        focusNode: _focusNode,
        obscureText: _obscureText,
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
          labelStyle:
              TextStyle(color: _isFocused ? Pallete.info : Pallete.dark3),
          label: Text(widget.label),
          // hintText: "Masukan Email / No HP",
          prefixIcon: const Icon(
            IconlyLight.lock,
            color: Color.fromARGB(255, 173, 148, 148),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              IconlyLight.show,
              color: Color.fromARGB(255, 173, 148, 148),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          contentPadding: const EdgeInsets.all(18),
        ),
        style: ThemeFont.bodySmall,
      ),
    );
  }
}
