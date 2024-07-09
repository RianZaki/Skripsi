import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class MainButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const MainButtonWidget({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          onPressed != null ? Pallete.main : Pallete.dark3,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: child,
    );
  }
}
