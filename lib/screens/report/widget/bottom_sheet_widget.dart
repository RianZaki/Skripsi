import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class BottomSheetWidget {
  final String title;
  final String subtitle;

  BottomSheetWidget({
    required this.title,
    required this.subtitle,
  });

  void customShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 32),
                child: Image.asset(
                  'assets/icons/slider.png',
                ),
              ),
              ListTile(
                title: Text(
                  title,
                  style: ThemeFont.bodySmallSemiBold,
                ),
              ),
              ListTile(
                title: Text(
                  subtitle,
                  style: ThemeFont.bodySmallRegular,
                ),
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        );
      },
    );
  }
}
