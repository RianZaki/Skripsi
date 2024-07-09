import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CustomLeadingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4.0);

  final String title;

  const CustomLeadingAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Pallete.light3)),
            child: IconButton(
              icon: const Icon(
                IconlyLight.arrow_left,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            title,
            style: ThemeFont.heading6Medium,
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
