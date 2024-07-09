import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class GoogleButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const GoogleButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8),
            side: const BorderSide(
              width: 1,
              color: Pallete.light2,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/google.png",
            width: 24,
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Pallete.dark1,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
