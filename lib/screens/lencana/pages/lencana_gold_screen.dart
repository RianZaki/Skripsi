import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_card.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_keuntungan.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_poin.dart';

class LencanaGoldScreen extends StatelessWidget {
  final UserModel user;
  final LencanaModel data;
  const LencanaGoldScreen({super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LencanaCard(
              image: "lencana_gold",
              title: "Gold",
              subtitle: "Emas untuk lingkungan, emas untuk \nAnda.",
              angka: data.targetPoint.toString()),
          LencanaPoin(
            lencana: data,
            color: Pallete.gold,
            nilai: user.point / data.targetPoint,
            item: user,
          ),
          LencanaKeuntungan(persen: "15", color: Pallete.gold)
        ],
      ),
    );
  }
}
