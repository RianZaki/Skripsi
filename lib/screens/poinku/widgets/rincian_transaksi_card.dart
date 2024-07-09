import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/history_poin_model.dart';

class RincianTransaksiCard extends StatelessWidget {
  final HistoryPoinModel item;
  const RincianTransaksiCard({super.key, required this.item});
  Widget table(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: ThemeFont.bodySmallRegular
                  .copyWith(color: Pallete.textSecondary),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              textAlign: TextAlign.right,
              overflow: TextOverflow.visible,
              value,
              style: ThemeFont.bodySmallMedium.copyWith(color: Pallete.dark1),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(item.createdAt);
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(dateTime);
    String formattedTime = DateFormat('HH.mm').format(dateTime);
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
          Text(
            "Rincian Transaksi",
            style: ThemeFont.interText.copyWith(
              fontWeight: FontWeight.w700,
              color: Pallete.dark1,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          table("ID Transaksi", item.idTransaction),
          table("Tanggal", formattedDate),
          table("Waktu", formattedTime),
          const SizedBox(
            height: 12,
          ),
          DashedLine(
            path: Path()
              ..cubicTo(0, 0, 0, 1, MediaQuery.of(context).size.width * 0.8, 0),
            color: Pallete.dark3,
          ),
          table("Jenis Transaksi", item.typeTransaction ?? ""),
          if (item.typeTransaction == "tukar poin")
            table("Nama Voucher", item.voucher ?? ""),
          if (item.typeTransaction == "tukar poin")
            table("Nomor Hp", item.phone ?? ""),
          if (item.typeTransaction == "reward hadiah mission")
            table("Nama Mission", item.title ?? "")
        ],
      ),
    );
  }
}
