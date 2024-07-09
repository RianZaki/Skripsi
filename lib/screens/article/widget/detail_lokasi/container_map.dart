import 'package:flutter/material.dart';

class BoxMapWidget extends StatelessWidget {
  const BoxMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 175,
      child: Image.asset(
        'assets/images/lokasi.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
