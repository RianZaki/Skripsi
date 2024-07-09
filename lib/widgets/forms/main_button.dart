import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class MainButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const MainButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Pallete.dark3;
            } else {
              return Pallete.main;
            }
          },
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8),
          ),
        ),
      ),
      child: child,
    );
  }
}
