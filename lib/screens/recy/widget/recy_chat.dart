import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class RecyChat extends StatelessWidget {
  final String text;
  final String time;

  const RecyChat({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.fromLTRB(16, 16, 24, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Pallete.main,
                child: Image.asset(
                  "assets/icons/profile/mbarecy.png",
                  width: 24,
                  color: Pallete.textMainButton,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: const BoxDecoration(
                          color: Pallete.light1,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      child: Text(
                        text,
                        style: ThemeFont.bodySmallRegular,
                      ),
                    ),
                    Text(time, style: ThemeFont.bodySmallRegular)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
