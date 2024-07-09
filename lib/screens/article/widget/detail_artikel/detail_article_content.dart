import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../bloc/get_article/get_article_cubit.dart';
import '../../../../constants/pallete.dart';

class DetailArticleContentWidget extends StatelessWidget {
  final String image;
  final String title;
  final String updateDate;
  final String like;
  final String category;
  final String content;
  final String id;

  const DetailArticleContentWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.category,
      required this.like,
      required this.updateDate,
      required this.content,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          width: double.infinity,
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.error),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: ThemeFont.bodyLargeBold,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          category,
                          style: ThemeFont.bodySmallRegular
                              .copyWith(color: Pallete.main),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          '|',
                          style: TextStyle(color: Pallete.dark4),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          updateDate,
                          style: ThemeFont.bodySmallRegular
                              .copyWith(color: Pallete.dark3),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            'assets/icons/icon_like_outline.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 5),
                        BlocBuilder<GetArticleCubit, GetArticleState>(
                          builder: (context, state) {
                            // context.read<GetArticleCubit>().getArticleById(id);
                            if (state is GetArticleByIdSuccess) {
                              return Text(
                                like,
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Pallete.dark3),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        // Text(
                        //   like,
                        //   style: ThemeFont.bodySmallRegular
                        //       .copyWith(color: Pallete.dark3),
                        // ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Html(
                data: "<p>$content</p>",
                style: {
                  "p": Style(textAlign: TextAlign.justify),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
