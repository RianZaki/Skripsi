import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/poinku/pages/poinku_screen.dart';
import 'package:recything_mobile/widgets/forms/custom_teks.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class HomePoinCard extends StatelessWidget {
  final UserModel user;
  const HomePoinCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PoinkuScreen(user: user)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
            color: Pallete.textMainButton,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 10,
                  color: Pallete.dark1.withOpacity(0.15))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Poinku",
                  style:
                      ThemeFont.interText.copyWith(fontWeight: FontWeight.w400),
                ),
                CustomTeks(
                    name: user.badge ?? "bronze",
                    color: _getBadgeColor(user.badge ?? "bronze"))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              user.point.toString(),
              style: ThemeFont.interText
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Pallete.main,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Ganti dengan radius yang Anda inginkan
                        ),
                        side: const BorderSide(color: Pallete.main),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoinkuScreen(
                                      user: user,
                                      index: 1,
                                    )));
                      },
                      child: const Text("Riwayat")),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: MainButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PoinkuScreen(
                                        user: user,
                                      )));
                        },
                        child: Text(
                          "Tukar Poin",
                          style: ThemeFont.heading6Reguler.copyWith(
                              color: Pallete.textMainButton,
                              fontWeight: FontWeight.w700),
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color _getBadgeColor(String badge) {
  switch (badge) {
    case 'platinum':
      return Pallete.platinum;
    case 'gold':
      return Pallete.gold;
    case 'silver':
      return Pallete.silver;
    case 'bronze':
      return Pallete.bronze;
    default:
      return Pallete.secondaryDarker;
  }
}
