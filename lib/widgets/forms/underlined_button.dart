import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class UnderLinedButton extends StatelessWidget {
  final String title;
  final bool active;
  final void Function()? onTap;
  const UnderLinedButton({
    super.key,
    required this.title,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: active == true ? Pallete.main : Colors.transparent,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: ThemeFont.bodySmall.copyWith(
              color: active == true ? Pallete.main : Pallete.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
