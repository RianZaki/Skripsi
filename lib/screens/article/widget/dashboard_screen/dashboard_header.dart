import 'package:flutter/material.dart';
import 'package:recything_mobile/screens/article/theme/text_style.dart';

class ArticleDashboardHeader extends StatelessWidget {
  const ArticleDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42),
      child: Container(
        width: 360,
        // width: double.infinity,
        height: 53,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(color: Colors.white),
        child: SizedBox(
          height: 21,
          width: 360,
          child: Center(
            child: Text(
              "Daur Ulang",
              style: ThemeText().heading6Medium,
            ),
          ),
        ),
      ),
    );
  }
}
