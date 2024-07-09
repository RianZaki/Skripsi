import 'package:flutter/material.dart';
import '../screens/article/theme/text_style.dart';

class ListArticleGlobalWidget extends StatelessWidget {
  final String image;
  final String title;
  final String updateDate;
  final String like;
  final String category;
  final String id;

  const ListArticleGlobalWidget({
    super.key,
    required this.image,
    required this.title,
    required this.category,
    required this.like,
    required this.updateDate,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                    height: 86,
                    width: 86,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    )),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: double.infinity,
                          child: Text(
                            category,
                            style: ThemeText().bodySmallRegular2,
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          child: SizedBox(
                            height: 24,
                            child: Text(
                              title,
                              style: ThemeText().bodyNormalMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              Text(updateDate,
                                  style: ThemeText().bodySmallRegular3),
                              const SizedBox(width: 7),
                              Image.asset(
                                  'assets/icons/icon_vertical_divider.png'),
                              const SizedBox(width: 7),
                              Image.asset('assets/icons/icon_like.png'),
                              const SizedBox(width: 4),
                              Text(like),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
      // onTap: () {
      //   Navigator.pushNamed(context, '/detailArtikel', arguments: id);
      // },
    );
  }
}
