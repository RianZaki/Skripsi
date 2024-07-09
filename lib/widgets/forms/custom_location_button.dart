import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomLocationButton extends StatelessWidget {
  // final void Function()? onPressed;
  const CustomLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Pallete.light3,
        ), // You can change the border color and width
      ),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).pop();
        },
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            IconlyLight.location,
            size: 24.0,
            color: Pallete.dark1,
          ),
        ),
      ),
    );
  }
}
