import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/detail_komunitas_screen.dart';
import 'package:stroke_text/stroke_text.dart';

class KomunitasCard extends StatelessWidget {
  final String id;
  final String title;
  final String lokasi;
  final String anggota;
  final String image;
  const KomunitasCard({
    super.key,
    required this.id,
    required this.title,
    required this.lokasi,
    required this.anggota,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailKomunitasScreen(id: id),
        ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: 160,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 240,
                  child: StrokeText(
                    text: title,
                    textStyle: ThemeFont.heading6Reguler
                        .copyWith(color: Pallete.light4),
                  ),
                  // child: Text(
                  //   title,
                  //   style: ThemeFont.heading6.copyWith(color: Pallete.light4),
                  // ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          IconlyLight.location,
                          color: Pallete.light1,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lokasi,
                          style: ThemeFont.bodySmall
                              .copyWith(color: Pallete.dark4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          IconlyLight.user_1,
                          color: Pallete.light4,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$anggota",
                          style: ThemeFont.heading6Reguler.copyWith(
                              color: Pallete.light4,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
