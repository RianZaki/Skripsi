import 'package:flutter/material.dart';

class ProgressStateBox extends StatelessWidget {
  final Widget child;
  final Color boxColor;

  const ProgressStateBox(
      {super.key, required this.child, required this.boxColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: child,
      ),
    );
  }
}
