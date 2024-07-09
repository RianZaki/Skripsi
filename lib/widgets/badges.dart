import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  const CustomBadge({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.light2,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Text(
        text,
        style: ThemeFont.bodySmallMedium.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class MainBadge extends StatelessWidget {
  final String text;
  const MainBadge({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.mainDarker,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Text(
        text,
        style: ThemeFont.bodySmallMedium
            .copyWith(fontWeight: FontWeight.w500, color: Pallete.light4),
      ),
    );
  }
}

// main badge
class MainSubtleBadge extends StatelessWidget {
  final String text;
  const MainSubtleBadge({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.mainSubtle,
        borderRadius: BorderRadius.circular(200),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Text(
        text,
        style: ThemeFont.bodySmallSemiBold
            .copyWith(fontWeight: FontWeight.w500, color: Pallete.main),
      ),
    );
  }
}
