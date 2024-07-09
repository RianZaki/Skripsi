import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
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
              color: Pallete.main,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
