import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class BodyLink extends StatelessWidget {
  final String text;
  const BodyLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Pallete.main,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
