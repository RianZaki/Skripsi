import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const SuccessScreen({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Lottie.asset('assets/animation/success.json', width: 312),
              Text(
                title,
                style: ThemeFont.heading3Bold,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                textAlign: TextAlign.center,
                subtitle,
                style: ThemeFont.bodyNormalReguler
                    .copyWith(color: Pallete.textSecondary),
              )
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.93,
          child: MainButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text(
                "Kembali ke Beranda",
                style: ThemeFont.heading6Reguler.copyWith(
                    color: Pallete.textMainButton, fontWeight: FontWeight.w700),
              )),
        ));
  }
}
