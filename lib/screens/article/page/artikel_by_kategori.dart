import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_article/get_article_cubit.dart';
import 'package:recything_mobile/screens/article/widget/cari_artikel/artikel_tidak_ditemukan.dart';
import 'package:recything_mobile/screens/article/widget/header_page.dart';
import 'package:recything_mobile/screens/article/widget/searchbar.dart';

import '../../../widgets/list_artikel_global.dart';

class ArtikelByKategoriScreen extends StatefulWidget {
  const ArtikelByKategoriScreen({super.key});

  @override
  State<ArtikelByKategoriScreen> createState() =>
      _ArtikelByKategoriScreenState();
}

class _ArtikelByKategoriScreenState extends State<ArtikelByKategoriScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final String category = arguments['category']!;
    final String title = arguments['title']!;
    String keyWord = "";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 66, left: 16, right: 16),
          child: Column(
            children: [
              HeaderPageWidget(title: title),
              SizedBox(height: 24),
              BlocBuilder<GetArticleCubit, GetArticleState>(
                builder: (context, state) {
                  return SearchBarWidget(
                    onChanged: (value) {
                      keyWord = value;
                      setState(() {});
                      // context
                      //     .read<GetArticleCubit>()
                      //     .searchArticleByCategory(category, value);
                    },
                    onTap: () {},
                    readOnly: false,
                    focusNode: null,
                    searchTap: () {
                      context
                          .read<GetArticleCubit>()
                          .searchArticleByCategory(category, keyWord);
                    },
                  );
                },
              ),
              SizedBox(height: 8),
              BlocBuilder<GetArticleCubit, GetArticleState>(
                builder: (context, state) {
                  if (state is GetArticleLoading) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 150),
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        ]);
                  } else if (state is GetArticleFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 150),
                        ArtikelTidakDitemukanWidget(),
                      ],
                    );
                  } else if (state is GetArticleSuccess) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: state.data.length,
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
                            bool isByCategory = true;
                            String id = state.data[index].id ?? "";
                            String category =
                                state.data[index].getCategoryString();
                            Navigator.pushNamed(context, '/detailArtikel',
                                arguments: {
                                  "isByCategory": isByCategory,
                                  "index": index,
                                  "id": id,
                                  "category": category
                                });
                            context.read<GetArticleCubit>().getArticleById(id);
                          },
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
