import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/screens/article/widget/searchbar.dart';
import 'package:recything_mobile/widgets/list_artikel_global.dart';
import '../../../bloc/get_article/get_article_cubit.dart';
import '../../../constants/pallete.dart';
import '../widget/cari_artikel/artikel_tidak_ditemukan.dart';

class SearchArticleScreen extends StatefulWidget {
  const SearchArticleScreen({super.key});

  @override
  State<SearchArticleScreen> createState() => _SearchArticleScreenState();
}

class _SearchArticleScreenState extends State<SearchArticleScreen> {
  late FocusNode _focusNode;
  String searchArticle = "";

  @override
  void initState() {
    super.initState();
    context.read<GetArticleCubit>().getAllArticle();
    _focusNode = FocusNode();

    // Fokus pada TextField setelah widget diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500));
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 66, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/icons/icon_back_button.png'),
                      ),
                      onTap: () async {
                        _focusNode.unfocus();
                        await Future.delayed(Duration(milliseconds: 500));
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 21,
                      child: Text(
                        "Cari Artikel",
                        style: ThemeFont.heading6Medium
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ),
              SizedBox(height: 24),
              SearchBarWidget(
                onChanged: (value) {
                  searchArticle = value;
                  setState(() {});
                  // context.read<GetArticleCubit>().searchArticle(value);
                },
                onTap: () {},
                readOnly: false,
                focusNode: _focusNode,
                searchTap: () {
                  context.read<GetArticleCubit>().searchArticle(searchArticle);
                },
              ),
              SizedBox(height: 10),
              BlocBuilder<GetArticleCubit, GetArticleState>(
                  builder: (context, state) {
                if (state is GetArticleSuccess) {
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
                            bool isByCategory = false;
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
                      });
                } else if (state is GetArticleFailure) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ArtikelTidakDitemukanWidget(),
                  );
                } else if (state is GetArticleLoading) {
                  return SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator());
                }
                return SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }
}
