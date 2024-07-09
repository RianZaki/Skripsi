import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;
  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 66, 16, 86),
      decoration: const BoxDecoration(
          color: Pallete.main,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(children: [
        Image.asset(
          "assets/logo/logo2.png",
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/notif');
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Pallete.textMainButton)),
            child: Stack(
              children: [
                Image.asset(
                  "assets/icons/notification.png",
                  width: 18,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Pallete.textMainButton),
                        borderRadius: BorderRadius.circular(100),
                        color: Pallete.error),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/profile'),
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.all(12),
            width: 40,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 69, 196, 169),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Pallete.textMainButton)),
            child: Text(
              textAlign: TextAlign.center,
              user.fullname.characters.first,
              style: ThemeFont.interText.copyWith(
                  fontWeight: FontWeight.bold, color: Pallete.textMainButton),
            ),
          ),
        )
      ]),
    );
  }
}
