import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class RiwayatKosongCard extends StatelessWidget {
  const RiwayatKosongCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/riwayat.png',
            width: 100,
            height: 98,
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            'Kamu belum pernah melaporkan',
            style: ThemeFont.bodySmallMedium.copyWith(
              color: Pallete.dark3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
