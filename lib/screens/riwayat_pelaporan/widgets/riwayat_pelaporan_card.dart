import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/report_model.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/pages/detail_pelanggaran_screen.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/pages/detail_pelaporan_tumpukan_screen.dart';

class RiwayatPelaporanCard extends StatelessWidget {
  final ReportModel item;
  const RiwayatPelaporanCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.reportType == "tumpukan sampah") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailPelaporanTumpukanScreen(id: item.id)));
        } else if (item.reportType == "pelanggaran sampah") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPelanggaranScreen(id: item.id)));
        }
      },
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: item.reportType == "pelanggaran sampah"
                  ? const Color(0XFFFEF7E0)
                  : item.status == "ditolak"
                      ? Pallete.errorBackground
                      : const Color(0xffE2FEE1),
              shape: BoxShape.circle),
          child: Image.asset(
            item.reportType == "tumpukan sampah"
                ? "assets/images/tumpukan_sampah.png"
                : "assets/images/pelanggaran_sampah.png",
            width: 50,
          ),
        ),
        title: Text(
          item.reportType == "tumpukan sampah"
              ? "Tumpukan Sampah"
              : "Pelanggaran",
          style: ThemeFont.bodyNormalSemiBold,
        ),
        subtitle: Text(
          DateFormat('dd MMMM yyyy | HH.mm')
              .format(item.createAt ?? DateTime.now()),
          style:
              ThemeFont.bodySmallRegular.copyWith(color: Pallete.textSecondary),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: item.status == "ditolak"
                ? Pallete.errorBackground
                : const Color(0xffE2FEE1),
          ),
          child: Text(
            item.status == "perlu ditinjau"
                ? "Proses"
                : item.status![0].toUpperCase() + item.status!.substring(1),
            style: ThemeFont.bodySmallSemiBold.copyWith(
                color: item.status == "ditolak" ? Pallete.error : Pallete.main),
          ),
        ),
      ),
    );
  }
}
