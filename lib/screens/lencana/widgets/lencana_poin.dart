import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/models/user_model.dart';

class LencanaPoin extends StatefulWidget {
  final LencanaModel lencana;
  final UserModel item;
  final Color color;
  final double nilai;
  const LencanaPoin(
      {super.key,
      required this.color,
      required this.nilai,
      required this.item,
      required this.lencana});

  @override
  State<LencanaPoin> createState() => _LencanaPoinState();
}

class _LencanaPoinState extends State<LencanaPoin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Poin saat ini",
            style: ThemeFont.bodyNormalSemiBold
                .copyWith(color: Pallete.textSecondary),
          ),
          Text(
            "${widget.item.point} Poin",
            style: ThemeFont.heading5Bold,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LinearProgressIndicator(
              color: widget.color,
              borderRadius: BorderRadius.circular(40),
              value: widget.nilai,
              minHeight: 10,
            ),
          ),
          Text(
            widget.nilai >= 1.0
                ? "Poin Anda sudah melewati batas level lencana ini"
                : widget.nilai == 0
                    ? "Poin Anda belum mencukupi untuk lencana ini."
                    : "${widget.lencana.targetPoint - widget.item.point} Poin lagi untuk menjadi Platinum",
            style: ThemeFont.bodySmallRegular
                .copyWith(color: Pallete.textSecondary),
          ),
        ],
      ),
    );
  }
}
