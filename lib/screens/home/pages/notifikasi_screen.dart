import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/home/widgets/notifikasi_card.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.textMainButton,
        centerTitle: true,
        title: Text(
          "Notifikasi",
          style: ThemeFont.interText
              .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hari Ini",
                style: ThemeFont.interText
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
            const NotifikasiCard(
              color: Pallete.mainSubtle,
              image: "assets/icons/notifikasi/diproses.png",
              title: "Laporan Tumpukan Sampahmu Diproses",
              subtitle: "5 Jam yang lalu",
            ),
            const NotifikasiCard(
              color: Pallete.mainSubtle,
              image: "assets/icons/notifikasi/success.png",
              title: "Selamat, Missions Tukarkan 1 kg sampah Berhasil!",
              subtitle: "5 Jam yang lalu",
            ),
            const SizedBox(height: 26),
            Text("Kemarin",
                style: ThemeFont.interText
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
            const NotifikasiCard(
              color: Pallete.errorBackground,
              image: "assets/icons/notifikasi/error.png",
              title:
                  "Oops, Bukti yang kamu unggah di Ikuti Event Komunitas ditolak",
              subtitle: "5 Jam yang lalu",
            ),
            const NotifikasiCard(
              color: Pallete.mainSubtle,
              image: "assets/icons/notifikasi/lonceng.png",
              title:
                  "Update Reward Point dari penukaran sampah melalui Drop Point",
              subtitle: "5 Jam yang lalu",
            ),
          ],
        ),
      ),
    );
  }
}
