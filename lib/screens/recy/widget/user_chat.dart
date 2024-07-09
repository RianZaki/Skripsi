import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class UserChat extends StatelessWidget {
  final String text;
  final String time;
  const UserChat({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                    color: Pallete.main,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Text(
                  text,
                  style: ThemeFont.bodySmallRegular
                      .copyWith(color: Pallete.textMainButton),
                ),
              ),
              Text(time, style: ThemeFont.bodySmallRegular)
            ],
          ),
        ),
      ],
    );
  }
}
