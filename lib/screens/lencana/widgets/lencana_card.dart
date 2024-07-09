import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class LencanaCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String angka;
  const LencanaCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.angka});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage(
                "assets/images/$image.png",
              ),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: ThemeFont.bodyMediumBold
                  .copyWith(color: Pallete.textMainButton),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
            child: Text(
              subtitle,
              style: ThemeFont.bodySmallRegular
                  .copyWith(color: Pallete.light4.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Poin Dibutuhkan",
                  style: ThemeFont.bodySmallRegular
                      .copyWith(color: Pallete.textMainButton),
                ),
                Text(
                  "$angka Poin",
                  style: ThemeFont.bodyMediumBold
                      .copyWith(color: Pallete.textMainButton),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Pallete.dark1.withOpacity(0.25),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  IconlyLight.unlock,
                  color: Pallete.textMainButton,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Lencana ini sudah kamu dapatkan",
                  style: ThemeFont.bodySmallRegular
                      .copyWith(color: Pallete.textMainButton),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
