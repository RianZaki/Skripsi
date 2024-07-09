import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:recything_mobile/models/drop_points_model.dart';
import '../../../../constants/pallete.dart';

class BottomDetailLokasiWidget extends StatelessWidget {
  final DropPointsModel item;
  const BottomDetailLokasiWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: const Row(
              children: [
                Icon(IconlyLight.info_square),
                SizedBox(width: 8),
                Text('Biaya Penukaran Sampah')
              ],
            ),
            onTap: () {
              showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 48, left: 16, right: 16, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apa itu Biaya Penukaran Sampah?',
                                style: ThemeFont.bodySmallSemiBold,
                              ),
                              const SizedBox(height: 24),
                              RichText(
                                text: TextSpan(
                                  text:
                                      'Kami memberlakukan biaya administrasi sebesar ',
                                  style: ThemeFont.bodySmallRegular
                                      .copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                            '10% dari total poin yang Anda peroleh melalui proses penukaran sampah di drop point ',
                                        style: ThemeFont.bodySmallSemiBold
                                            .copyWith(color: Colors.black)),
                                    TextSpan(
                                      text: 'kami.',
                                      style: ThemeFont.bodySmallRegular
                                          .copyWith(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Contoh: Jika Anda menukarkan 1kg sampah plastik yang memiliki nilai 2500 poin/kg. Dengan biaya admin sebesar 10%, maka akan ada pengurangan sebesar 250 poin dari total poin yang Anda peroleh. Total poin akhir yang Anda peroleh dari penukaran ini adalah 2250 poin.',
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Colors.black),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Biaya ini digunakan untuk mendukung operasional dan pengembangan Aplikasi Recything agar tetap menjadi platform yang efisien dan berkelanjutan.',
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          const SizedBox(height: 8),
          GestureDetector(
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Pallete.main, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                'Arahkan',
                style: ThemeFont.heading6Bold.copyWith(color: Colors.white),
              )),
            ),
            onTap: () {
              MapsLauncher.launchCoordinates(item.latitude?.toDouble() ?? 0,
                  item.longitude?.toDouble() ?? 0);
            },
          ),
        ],
      ),
    );
  }
}
