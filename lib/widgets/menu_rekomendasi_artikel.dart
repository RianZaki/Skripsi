import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_article/get_article_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/list_artikel_global.dart';
import '../bloc/get_popular_article/get_popular_article_cubit.dart';

class MenuRekomendasiArtikel extends StatelessWidget {
  final String judulMenu;
  const MenuRekomendasiArtikel({super.key, required this.judulMenu});

  @override
  Widget build(BuildContext context) {
    int length = 3;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              judulMenu,
              style: ThemeFont.interText
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/cariArtikel");
                },
                child: Text(
                  "Lihat Semua",
                  style: ThemeFont.interText.copyWith(
                      color: Pallete.main, fontWeight: FontWeight.w400),
                ))
          ],
        ),
        BlocListener<GetPopularArticleCubit, GetPopularArticleState>(
          listener: (context, state) {},
          child: BlocBuilder<GetPopularArticleCubit, GetPopularArticleState>(
            builder: (context, state) {
              if (state is GetPopularArticleLoading) {
                return SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator());
              } else if (state is GetPopularArticleFailure) {
                return Text(state.message);
              } else if (state is GetPopularArticleSuccess) {
                if (state.data.length < length) {
                  length = state.data.length;
                }
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ListArticleGlobalWidget(
                            image: state.data[index].image ?? "",
                            title: state.data[index].title ?? "",
                            category: state.data[index].getCategoryString(),
                            like: state.data[index].like.toString(),
                            updateDate: state.data[index].createdDate ?? "",
                            id: state.data[index].id ?? ""),
                        onTap: () {
                          bool isByCategory = false;
                          String id = state.data[index].id ?? "";
                          Navigator.pushNamed(
                            context,
                            '/detailArtikel',
                            arguments: {
                              "isByCategory": isByCategory,
                              "index": index,
                              "id": state.data[index].id,
                              "like": state.data[index].like.toString()
                            },
                          );
                          context.read<GetArticleCubit>().getArticleById(id);
                        },
                      );
                    });
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
