import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/get_article/get_article_cubit.dart';
import '../../theme/color_style.dart';

class AllMenuKategoriWidget extends StatelessWidget {
  AllMenuKategoriWidget({super.key});

  // Data list map
  final List<Map<String, String>> macamKategori = [
    {
      'imageAsset': 'assets/icons/icon_plastik.png',
      'title': 'Plastik',
      'category': 'plastik'
    },
    {
      'imageAsset': 'assets/icons/icon_kaca.png',
      'title': 'Kaca',
      'category': 'kaca'
    },
    {
      'imageAsset': 'assets/icons/icon_logam.png',
      'title': 'Logam',
      'category': 'logam'
    },
    {
      'imageAsset': 'assets/icons/icon_organik.png',
      'title': 'Organik',
      'category': 'organik'
    },
    {
      'imageAsset': 'assets/icons/icon_kertas.png',
      'title': 'Kertas',
      'category': 'kertas'
    },
    {
      'imageAsset': 'assets/icons/icon_kaleng.png',
      'title': 'Kaleng',
      'category': 'kaleng'
    },
    {
      'imageAsset': 'assets/icons/icon_minyak.png',
      'title': 'Minyak',
      'category': 'minyak'
    },
    {
      'imageAsset': 'assets/icons/icon_elektronik.png',
      'title': 'Elektronik',
      'category': 'elektronik'
    },
    {
      'imageAsset': 'assets/icons/icon_tekstil.png',
      'title': 'Tekstil',
      'category': 'tekstil'
    },
    // {
    //   'imageAsset': 'assets/icons/icon_pakaian.png',
    //   'title': 'Pakaian',
    // },
    {
      'imageAsset': 'assets/icons/icon_baterai.png',
      'title': 'Baterai',
      'category': 'baterai'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: SizedBox(
        height: 494.33,
        // width: 328,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: macamKategori.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.59),
              child: SizedBox(
                width: 98.31,
                height: 99.58,
                child: GestureDetector(
                  onTap: () {
                    context.read<GetArticleCubit>().getArticleByCategory(
                        macamKategori[index]['category'] ?? "");
                    Navigator.pushNamed(
                      context,
                      '/artikelByKategori',
                      arguments: {
                        'category': macamKategori[index]['category'],
                        'title': macamKategori[index]['title'],
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 69.77,
                        height: 69.77,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: ThemeColor().grayScae100),
                        child: Image.asset(macamKategori[index]['imageAsset']!),
                      ),
                      const SizedBox(height: 8),
                      Text(macamKategori[index]['title']!)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
