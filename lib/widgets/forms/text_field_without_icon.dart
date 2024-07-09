import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class TextFieldWithoutIcon extends StatelessWidget {
  final String label;
  const TextFieldWithoutIcon({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusColor: Pallete.dark1,
        labelStyle: const TextStyle(color: Pallete.dark2),
        label: Text(label),
        contentPadding: const EdgeInsets.all(16),
      ),
      style: const TextStyle(
        backgroundColor: Colors.white,
      ),
    );
  }
}
