import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  const DetailCard(
      {super.key,
      required this.title,
      required this.value,
      this.color = Pallete.dark3});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
          color: Pallete.textMainButton,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 10,
                color: Pallete.dark1.withOpacity(0.15))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeFont.bodySmallSemiBold),
          const SizedBox(
            height: 8,
          ),
          Text(value,
              style: ThemeFont.bodySmallSemiBold.copyWith(color: color)),
        ],
      ),
    );
  }
}
