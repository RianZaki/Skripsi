import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/screens/article/theme/text_style.dart';
import 'package:recything_mobile/screens/article/widget/dashboard_screen/button_kategori_daur_ulang.dart';
import 'package:recything_mobile/widgets/typography/body_link.dart';

import '../../../../bloc/get_article/get_article_cubit.dart';

class MenuKategoriWidget extends StatelessWidget {
  const MenuKategoriWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: SizedBox(
        height: 132,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kategori Daur Ulang",
                  style: ThemeText().heading6Medium,
                ),
                GestureDetector(
                  child: const BodyLink("Lihat semua"),
                  onTap: () {
                    Navigator.pushNamed(context, '/kategoriDaurUlang');
                  },
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: ButtonKategoriDaurUlang(
                    assetImage: 'assets/icons/icon_plastik.png',
                    title: 'Plastik',
                  ),
                  onTap: () {
                    String category = 'plastik';
                    String title = 'Plastik';
                    context
                        .read<GetArticleCubit>()
                        .getArticleByCategory(category);
                    Navigator.pushNamed(
                      context,
                      '/artikelByKategori',
                      arguments: {
                        'category': category,
                        'title': title,
                      },
                    );
                  },
                ),
                GestureDetector(
                  child: ButtonKategoriDaurUlang(
                    assetImage: 'assets/icons/icon_kaca.png',
                    title: 'Kaca',
                  ),
                  onTap: () {
                    String category = 'kaca';
                    String title = 'Kaca';
                    context
                        .read<GetArticleCubit>()
                        .getArticleByCategory(category);
                    Navigator.pushNamed(
                      context,
                      '/artikelByKategori',
                      arguments: {
                        'category': category,
                        'title': title,
                      },
                    );
                  },
                ),
                GestureDetector(
                  child: ButtonKategoriDaurUlang(
                    assetImage: 'assets/icons/icon_logam.png',
                    title: 'Logam',
                  ),
                  onTap: () {
                    String category = 'logam';
                    String title = 'Logam';
                    context
                        .read<GetArticleCubit>()
                        .getArticleByCategory(category);
                    Navigator.pushNamed(
                      context,
                      '/artikelByKategori',
                      arguments: {
                        'category': category,
                        'title': title,
                      },
                    );
                  },
                ),
                GestureDetector(
                  child: ButtonKategoriDaurUlang(
                    assetImage: 'assets/icons/icon_organik.png',
                    title: 'Organik',
                  ),
                  onTap: () {
                    String category = 'organik';
                    String title = 'Organik';
                    context
                        .read<GetArticleCubit>()
                        .getArticleByCategory(category);
                    Navigator.pushNamed(
                      context,
                      '/artikelByKategori',
                      arguments: {
                        'category': category,
                        'title': title,
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
