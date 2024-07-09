import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class ErrorButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const ErrorButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8),
            side: BorderSide(color: Pallete.error),
          ),
        ),
      ),
      child: child,
    );
  }
}
