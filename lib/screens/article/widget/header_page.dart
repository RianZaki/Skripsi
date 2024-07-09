import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class HeaderPageWidget extends StatelessWidget {
  final String title;

  const HeaderPageWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 21,
            child: Text(
              title,
              style: ThemeFont.heading6Medium.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 40,
          )
        ],
      ),
    );
  }
}
