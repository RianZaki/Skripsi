import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_user_profile/get_user_profile_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/home/widgets/home_banner.dart';
import 'package:recything_mobile/screens/home/widgets/home_header.dart';
import 'package:recything_mobile/screens/home/widgets/home_poin_card.dart';
import 'package:recything_mobile/widgets/menu_rekomendasi_artikel.dart';
import '../../../bloc/get_popular_article/get_popular_article_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    context.read<GetUserProfileCubit>().fetchMe(context);
    context.read<GetPopularArticleCubit>().getPopularArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetUserProfileCubit, GetUserProfileState>(
              builder: (context, state) {
                if (state is GetUserProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetUserProfilefailure) {
                  return Text(state.message);
                } else if (state is GetUserProfileSuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: Stack(
                          children: [
                            HomeHeader(
                              user: state.data,
                            ),
                            Positioned(
                                bottom: 0,
                                child: HomePoinCard(
                                  user: state.data,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      HomeBanner(
                        user: state.data,
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: MenuRekomendasiArtikel(
                judulMenu: 'Rekomendasi Artikel',
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Stack(
        // crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: IconButton(
          //       color: Pallete.main,
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.cancel,
          //         size: 20,
          //       )),
          // ),
          Padding(
            padding: const EdgeInsets.only(
                //right: 24,
                top: 30),
            child: FloatingActionButton(
              backgroundColor: Pallete.main,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              onPressed: () {
                Navigator.pushNamed(context, '/recy');
              },
              child: Image.asset(
                "assets/icons/profile/mbarecy.png",
                color: Colors.white,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
