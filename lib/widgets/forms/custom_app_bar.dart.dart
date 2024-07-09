import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CustomAppBar({
    super.key,
    this.onTap,
    required this.title,
  });

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
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Pallete.textMainButton)),
            child: const Icon(
              Icons.arrow_back,
              color: Pallete.textMainButton,
            ),
          ),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: ThemeFont.interText.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Pallete.textMainButton),
          ),
        ),
        const SizedBox(
          width: 50,
        )
      ]),
    );
  }
}
