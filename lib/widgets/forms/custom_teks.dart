import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomTeks extends StatelessWidget {
  final String name;
  final Color color;
  final double size;
  const CustomTeks(
      {super.key, required this.name, required this.color, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      child: Text(
        name,
        style: ThemeFont.interText.copyWith(
            fontSize: size,
            fontWeight: FontWeight.w600,
            color: Pallete.textMainButton),
      ),
    );
  }
}
