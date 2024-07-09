import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/dashboard.dart';
import 'package:recything_mobile/screens/poinku/pages/poinku_screen.dart';

class HomeBanner extends StatefulWidget {
  final UserModel user;
  const HomeBanner({super.key, required this.user});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    List goTo = [
      Dasboard(
        index: 3,
      ),
      Dasboard(
        index: 1,
      ),
      PoinkuScreen(user: widget.user)
    ];
    return Column(
      children: [
        CarouselSlider(
            items: slider
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => goTo[carouselIndex]));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: Pallete.textMainButton,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(e), fit: BoxFit.cover)),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 144,
              autoPlay: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  carouselIndex = index;
                });
              },
            )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            slider.length,
            (index) => Container(
              height: 6,
              width: carouselIndex == index ? 30 : 6,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: carouselIndex == index
                      ? Pallete.main
                      : Pallete.mainLigther),
            ),
          ),
        ),
      ],
    );
  }
}

List<String> slider = [
  "assets/images/banner1.png",
  "assets/images/banner2.png",
  "assets/images/banner3.png"
];
