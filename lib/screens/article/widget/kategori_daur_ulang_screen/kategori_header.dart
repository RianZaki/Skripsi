import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class HeaderKategoriWidget extends StatelessWidget {
  const HeaderKategoriWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 328,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/icons/icon_back_button.png'),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 21,
                width: 160,
                child: Text(
                  'Kategori Daur Ulang',
                  style: ThemeText().heading6Medium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
