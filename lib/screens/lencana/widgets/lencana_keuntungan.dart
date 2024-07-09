import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class LencanaKeuntungan extends StatelessWidget {
  final String persen;
  final Color color;
  const LencanaKeuntungan(
      {super.key, required this.persen, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keuntungan",
            style: ThemeFont.bodyNormalSemiBold,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: const Icon(
                  IconlyLight.star,
                  color: Pallete.textMainButton,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(
                "Dapatkan Bonus Poin $persen% dari missions yang kamu selesaikan",
                style: ThemeFont.bodySmallMedium,
              )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: const Icon(
                  IconlyLight.ticket_star,
                  color: Pallete.textMainButton,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(
                "Bonus Poin dapat ditukar menjadi voucher reward di menu Poinku",
                style: ThemeFont.bodySmallMedium,
              )),
            ],
          )
        ],
      ),
    );
  }
}
