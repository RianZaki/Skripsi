import 'package:flutter/material.dart';
import 'package:recything_mobile/screens/article/theme/color_style.dart';
import 'package:recything_mobile/screens/article/theme/text_style.dart';

class MenuTukarSampahWidget extends StatelessWidget {
  const MenuTukarSampahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: SizedBox(
        height: 152,
        // width: 328,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 21,
              child: Text(
                'Tukar Sampah di Drop Point',
                style: ThemeText().heading6Medium,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 115,
              // width: 328,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: ThemeColor().whiteColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 73,
                    width: 81,
                    child: Image.asset(
                        'assets/icons/icon_undraw_location_search.png'),
                  ),
                  SizedBox(
                    height: 83,
                    // width: 196,
                    width: 172,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tukar Sampahmu',
                                style: ThemeText().bodyNormalSemiBold,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tukarkan sampah daur ulang di drop point',
                                style: ThemeText().bodySmallRegular,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ThemeColor().mainColor),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 3, bottom: 3, left: 2),
                        width: 15.5,
                        height: 8.5,
                        child: Image.asset(
                          'assets/icons/icon_arrow_right.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/daftarLokasi');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
