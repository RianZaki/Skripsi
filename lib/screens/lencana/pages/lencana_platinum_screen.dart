import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_card.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_keuntungan.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_poin.dart';

class LencanaPlatinumScreen extends StatelessWidget {
  final UserModel user;
  final LencanaModel data;
  const LencanaPlatinumScreen(
      {super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LencanaCard(
              image: "lencana_platinum",
              title: "Platinum",
              subtitle:
                  "Anda Seorang Pahlawan, Tidak ada yang bisa menghentikan Anda sekarang.",
              angka: data.targetPoint.toString()),
          LencanaPoin(
            lencana: data,
            color: Pallete.platinum,
            nilai: user.point / data.targetPoint,
            item: user,
          ),
          LencanaKeuntungan(persen: "20", color: Pallete.platinum)
        ],
      ),
    );
  }
}
