import 'package:flutter/material.dart';
import 'package:recything_mobile/screens/article/theme/text_style.dart';

import '../../theme/color_style.dart';

class ButtonKategoriDaurUlang extends StatelessWidget {
  final String assetImage;
  final String title;
  const ButtonKategoriDaurUlang({
    super.key,
    required this.assetImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      width: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: ThemeColor().grayScae100,
                width: 1,
              ),
            ),
            child: Image.asset(
              assetImage,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 24,
            child: Center(
              child: Text(
                title,
                style: ThemeText().bodySmallRegular,
              ),
            ),
          )
        ],
      ),
    );
  }
}
