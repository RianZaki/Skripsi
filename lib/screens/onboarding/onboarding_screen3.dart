import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/secondary_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          children: [
            // const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (route) => false),
                  child: Text(
                    "",
                    style: ThemeFont.heading5Reguler
                        .copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Lottie.asset(
              "assets/images/onboarding3.json",
              height: 240,
            ),
            // const SizedBox(height: 32),
            Text(
              "Kumpulkan Poin dan Tukarkan Dengan Voucher",
              style: ThemeFont.heading5Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Setiap tindakan positif Anda dalam menjaga lingkungan akan menghasilkan poin yang bisa Anda kumpulkan",
              style: ThemeFont.bodyNormal
                  .copyWith(height: 1.64, color: Pallete.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DotsIndicator(
              dotsCount: 3,
              position: 2,
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
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/login", (route) => false);
                    },
                    child: Text(
                      "Login",
                      style: ThemeFont.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/register", (route) => false);
                    },
                    child: Text(
                      "Register",
                      style: ThemeFont.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold, color: Pallete.main),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
