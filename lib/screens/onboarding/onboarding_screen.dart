import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/onboarding/onboarding_screen2.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (route) => false),
                  child: Text(
                    "Lewati",
                    style: ThemeFont.heading6Reguler
                        .copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Lottie.asset(
              "assets/images/onboarding1.json",
              alignment: Alignment.center,
              height: 240,
              // width: 300,
            ),
            // const SizedBox(height: 32),
            Text(
              "Jelajahi Informasi dan Daur Ulang Sampahmu",
              style: ThemeFont.heading5Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Akses informasi yang dapat membantu Anda berperan dalam perubahan positif melalui daur ulang",
              style: ThemeFont.bodyNormalReguler
                  .copyWith(height: 1.64, color: Pallete.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DotsIndicator(
              dotsCount: 3,
              position: 0,
              decorator: const DotsDecorator(
                color: Pallete.mainLigther, // Inactive color
                activeColor: Pallete.main,
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen2(),
                        ),
                      );
                    },
                    child: Text(
                      "Selanjutnya",
                      style: ThemeFont.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
