import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/widget/bottom_sheet_widget.dart';

class CardReportLittering extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subTitle;
  final int selectedIndex;
  final int currentIndex;
  final Function(int) onTap;

  const CardReportLittering({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.subTitle,
    required this.selectedIndex,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(selectedIndex == currentIndex ? -1 : currentIndex);
      },
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          border: Border.all(
            color: currentIndex == selectedIndex ? Pallete.main : Pallete.dark3,
          ),
          borderRadius: BorderRadius.circular(12),
          color: currentIndex == selectedIndex ? Pallete.main : Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 30,
                    right: 6,
                  ),
                  child: Image.asset(
                    assetPath,
                    color: currentIndex == selectedIndex
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    if (currentIndex == 0) {
                      BottomSheetWidget(
                        title: 'Apa itu Pelanggaran Individu?',
                        subtitle:
                            'Merupakan jenis pelanggaran yang dilakukan oleh individu atau masyarakat umum terkait dengan kasus pembuangan sampah sembarangan yang kamu lihat.\nContoh Pelanggaran Individu meliputi:\n• Membuang Sampah ke Sungai \n• Membuang Sampah di Jalan Raya\n• Membuang Sampah di Taman\n• Membuang Puntung Rokok di Taman\n• Membuang Sampah di Tepi Pantai\n• Dan Membuang Sampah Sembarangan lainnya',
                      ).customShowModalBottomSheet(context);
                    } else if (currentIndex == 1) {
                      BottomSheetWidget(
                        title: 'Apa itu Pelanggaran Perusahaan?',
                        subtitle:
                            'Jenis pelaporan ini berkaitan dengan pelanggaran yang dilakukan oleh perusahaan, bisnis, atau pabrik dalam hal pembuangan limbah atau sampah yang tidak sesuai dengan standar dan regulasi lingkungan.\nContoh Pelaporan perusahaan meliputi:\n• Pembuangan Limbah Pabrik ke Sungai\n• Penyimpanan Berbahaya Limbah Industri Tanpa Izin\n• Pembuangan Limbah Kimia Beracun ke Sungai\n• Pembuangan Limbah Bahan Kimia ke Saluran Umum',
                      ).customShowModalBottomSheet(context);
                    }
                  },
                  child: Image.asset(
                    "assets/images/faq_icon.png",
                    color: currentIndex == selectedIndex
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            Divider(
              color:
                  currentIndex == selectedIndex ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: ThemeFont.bodyMediumMedium.copyWith(
                color:
                    currentIndex == selectedIndex ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color:
                  currentIndex == selectedIndex ? Colors.white : Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: ThemeFont.bodySmallRegular.copyWith(
                  color: currentIndex == selectedIndex
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
