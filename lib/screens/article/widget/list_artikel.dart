import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_article/get_article_cubit.dart';
import '../theme/text_style.dart';

class ListArtikelWidget extends StatelessWidget {
  const ListArtikelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetArticleCubit, GetArticleState>(
      builder: (context, state) {
        if (state is GetArticleSuccess) {
          return ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: state.data.length,
              itemBuilder: (context, index) {
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
                                    state.data[index].image ?? "",
                                    fit: BoxFit.cover,
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
                                        state.data[index].getCategoryString(),
                                        style: ThemeText().bodySmallRegular2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: SizedBox(
                                        height: 24,
                                        child: Text(
                                          state.data[index].title ?? "",
                                          style: ThemeText().bodyNormalMedium,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                      child: Row(
                                        children: [
                                          Text(state.data[index].createdDate ?? "",
                                              style: ThemeText()
                                                  .bodySmallRegular3),
                                          const SizedBox(width: 7),
                                          Image.asset(
                                              'assets/icons/icon_vertical_divider.png'),
                                          const SizedBox(width: 7),
                                          Image.asset(
                                              'assets/icons/icon_like.png'),
                                          const SizedBox(width: 4),
                                          Text(state.data[index].like
                                              .toString()),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/detailArtikel',
                        arguments: index);
                  },
                );
              });
        }
        return SizedBox();
      },
    );
  }
}
