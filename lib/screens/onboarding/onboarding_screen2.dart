import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/onboarding/onboarding_screen3.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
            SizedBox(
              width: double.infinity,
              height: 240,
              child: Lottie.asset(
                "assets/images/onboarding2.json",
                height: 240,
              ),
            ),
            // const SizedBox(height: 32),
            Text(
              "Laporkan Tumpukan dan Pelanggaran Sampah ",
              style: ThemeFont.heading5Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Recything menyediakan platform untuk melaporkan masalah sampah untuk berkontribusi dalam menjaga lingkungan",
              style: ThemeFont.bodyNormal
                  .copyWith(height: 1.64, color: Pallete.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DotsIndicator(
              dotsCount: 3,
              position: 1,
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
                          builder: (context) => const OnboardingScreen3(),
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
