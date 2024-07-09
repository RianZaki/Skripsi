import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/history_poin_model.dart';
import 'package:recything_mobile/screens/poinku/pages/detail_transaksi_screen.dart';

class PoinkuTukarPoin extends StatelessWidget {
  final HistoryPoinModel item;
  const PoinkuTukarPoin({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(item.createdAt);
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(dateTime);
    String formattedTime = DateFormat('HH.mm').format(dateTime);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailTransaksiScreen(id: item.idTransaction))),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Image.asset(
          "assets/poinku/tukar_poin.png",
          width: 40,
        ),
        title: Text(
          item.typeTransaction
                  ?.split(' ')
                  .map((word) => word[0].toUpperCase() + word.substring(1))
                  .join(' ') ??
              "",
          style: ThemeFont.interText.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$formattedDate | $formattedTime"),
        trailing: Text(
          "-${item.point}",
          style: ThemeFont.interText.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold, color: Pallete.error),
        ),
      ),
    );
  }
}
