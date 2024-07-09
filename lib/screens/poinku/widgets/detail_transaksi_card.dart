import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/history_poin_model.dart';

class DetailTransaksiCard extends StatelessWidget {
  final HistoryPoinModel item;
  const DetailTransaksiCard({super.key, required this.item});

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
        children: [
          Text(
            item.typeTransaction == "tukar poin"
                ? "-${item.point}"
                : "+${item.point}",
            style: ThemeFont.interText.copyWith(
                fontWeight: FontWeight.w700,
                color: Pallete.dark1,
                fontSize: 28),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Pallete.successSubtle),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: Pallete.textMainButton,
                ),
              ),
              Text(
                "   Berhasil",
                style: ThemeFont.interText
                    .copyWith(fontSize: 16, color: Pallete.successSubtle),
              )
            ],
          )
        ],
      ),
    );
  }
}
