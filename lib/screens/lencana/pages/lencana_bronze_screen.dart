import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_card.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_keuntungan.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_poin.dart';

class LencanaBronzeScreen extends StatelessWidget {
  final UserModel user;
  final LencanaModel data;
  const LencanaBronzeScreen(
      {super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LencanaCard(
              image: "lencana_bronze",
              title: "Bronze",
              subtitle:
                  "Selangkah lebih dekat menuju lingkungan yang lebih bersih dan sehat",
              angka: data.targetPoint.toString()),
          LencanaPoin(
            lencana: data,
            color: Pallete.bronze,
            nilai: 1,
            item: user,
          ),
          LencanaKeuntungan(persen: "10", color: Pallete.bronze)
        ],
      ),
    );
  }
}
