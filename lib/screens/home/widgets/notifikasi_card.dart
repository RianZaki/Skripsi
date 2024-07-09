import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class NotifikasiCard extends StatelessWidget {
  final String image;
  final String title;
  final String? teksbold;
  final String? nextTeks;
  final String subtitle;
  final Color color;

  const NotifikasiCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.color,
      this.teksbold,
      this.nextTeks});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Image.asset(
            image,
            width: 22,
          ),
        ),
      ),
      title: Text(
        title,
        style: ThemeFont.interText,
      ),
      subtitle: Text(
        subtitle,
        style: ThemeFont.interText.copyWith(color: Pallete.dark4),
      ),
    );
  }
}
