import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/widget/report_card.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/pages/riwayat_pelaporan_screen.dart';

class ChooseReportScreen extends StatefulWidget {
  const ChooseReportScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChooseReportScreenState createState() => _ChooseReportScreenState();
}

class _ChooseReportScreenState extends State<ChooseReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Pelaporan',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: Text(
                  'Pilih Jenis Pelaporan',
                  style: ThemeFont.heading6Medium,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/report-rubbish');
                },
                child: const ReportCard(
                  title: 'Tumpukan Sampah',
                  description: 'Lapor penumpukan sampah sembarangan',
                  assetImage: 'assets/images/tumpukan_sampah.png',
                  cardColor: Color(0XFFE2FEE1),
                  routeName: '/report-rubbish',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/report-littering');
                },
                child: const ReportCard(
                  title: 'Pelanggaran Sampah',
                  description: 'Lapor aksi pembuangan sampah sembarangan',
                  assetImage: 'assets/images/pelanggaran_sampah.png',
                  cardColor: Color(0XFFFEF7E0),
                  routeName: '/report-littering',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Riwayat Pelaporan',
                style: ThemeFont.heading6Medium,
              ),
              const SizedBox(
                height: 24,
              ),
              RiwayatPelaporanScreen()
              //
              // Center(
              //   child: Column(
              //     children: [
              //       Image.asset(
              //         'assets/images/riwayat.png',
              //         width: 100,
              //         height: 98,
              //       ),
              //       const SizedBox(
              //         height: 11,
              //       ),
              //       Text(
              //         'Kamu belum pernah melaporkan',
              //         style: ThemeFont.bodySmallMedium.copyWith(
              //           color: Pallete.dark3,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
