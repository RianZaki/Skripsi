import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4.0);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Missions',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
