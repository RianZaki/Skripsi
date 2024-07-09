import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_card.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_keuntungan.dart';
import 'package:recything_mobile/screens/lencana/widgets/lencana_poin.dart';

class LencanaSilverScreen extends StatelessWidget {
  final LencanaModel data;
  final UserModel user;
  const LencanaSilverScreen(
      {super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LencanaCard(
              image: "lencana_silver",
              title: "Silver",
              subtitle: "Sudah saatnya menjadi Pahlawan \nlingkungan!",
              angka: data.targetPoint.toString()),
          LencanaPoin(
            lencana: data,
            color: Pallete.silver,
            nilai: user.point / data.targetPoint,
            item: user,
          ),
          LencanaKeuntungan(persen: "12", color: Pallete.silver)
        ],
      ),
    );
  }
}
