import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final String assetImage;
  final Color cardColor;
  final String routeName;
  const ReportCard(
      {super.key,
      required this.title,
      required this.description,
      required this.assetImage,
      required this.cardColor,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 13,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 88,
              width: 88,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                assetImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ThemeFont.bodyNormal.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 172,
                  child: Text(
                    description,
                    style: ThemeFont.bodySmallRegular.copyWith(
                      color: Pallete.dark3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 48, right: 16),
            child: CircleAvatar(
              backgroundColor: Pallete.mainDarker,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, routeName);
                },
                icon: const Icon(
                  IconlyLight.arrow_right_2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
