import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/report_littering/pelanggaran_besar_screen.dart';
import 'package:recything_mobile/screens/report/report_littering/pelanggaran_kecil_screen.dart';
import 'package:recything_mobile/screens/report/report_littering/widgets/card_report_littering.dart.dart';
import 'package:recything_mobile/screens/report/widget/main_button_widget.dart';

class ReportLitteringScreen extends StatefulWidget {
  const ReportLitteringScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportLitteringScreenState createState() => _ReportLitteringScreenState();
}

class _ReportLitteringScreenState extends State<ReportLitteringScreen> {
  int selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pelanggaran Sampah',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 32, bottom: 8),
        width: double.infinity,
        child: MainButtonWidget(
          onPressed: selectedCardIndex != -1
              ? () {
                  if (selectedCardIndex == 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LitteringKecilScreen(),
                      ),
                    );
                  } else if (selectedCardIndex == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LitteringBesarScreen(),
                      ),
                    );
                  }
                }
              : null,
          child: Text(
            "Selanjutnya",
            style: ThemeFont.heading6Bold.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pilih Jenis Pelanggaran Sampah",
                  style: ThemeFont.bodySmallMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardReportLittering(
                  assetPath: 'assets/images/littering_individu.png',
                  title: 'Individu',
                  subTitle: 'Pelanggaran Oleh Perorangan',
                  selectedIndex: selectedCardIndex,
                  currentIndex: 0,
                  onTap: (index) {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                CardReportLittering(
                  assetPath: 'assets/images/littering_perusahaan.png',
                  title: 'Perusahaan',
                  subTitle: 'Pelanggaran Oleh Perusahaan',
                  selectedIndex: selectedCardIndex,
                  currentIndex: 1,
                  onTap: (index) {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
