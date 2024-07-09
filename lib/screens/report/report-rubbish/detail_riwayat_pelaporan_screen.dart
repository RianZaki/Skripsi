import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
// import 'package:recything_mobile/screens/report/widget/custom_card.dart';
import 'package:recything_mobile/screens/report/widget/detail_report_card.dart';

class DetailRiwayatPelaporanScreen extends StatefulWidget {
  final String? lokasiPatokanText;
  final String? kondisiSampahText;
  final String? lokasiTumpukanText;

  const DetailRiwayatPelaporanScreen({
    super.key,
    this.lokasiPatokanText,
    this.kondisiSampahText,
    this.lokasiTumpukanText,
  });

  @override
  State<DetailRiwayatPelaporanScreen> createState() =>
      _DetailRiwayatPelaporanScreenState();
}

class _DetailRiwayatPelaporanScreenState
    extends State<DetailRiwayatPelaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail pelaporan'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              // color: Colors.blue,
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -2),
                          blurRadius: 13,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Jenis Pelaporan: ',
                            style: TextStyle(
                              fontSize: ThemeFont.bodyNormal.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Tumpukan Sampah',
                                style: TextStyle(
                                  fontSize: ThemeFont.bodyNormal.fontSize,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Status Pelaporan: ',
                            style: TextStyle(
                              fontSize: ThemeFont.bodyNormal.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'DITOLAK',
                                style: TextStyle(
                                  fontSize: ThemeFont.bodyNormal.fontSize,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Alasan: ',
                            style: TextStyle(
                              fontSize: ThemeFont.bodyNormal.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Detail Kejadian Kurang Jelas',
                                style: TextStyle(
                                  fontSize: ThemeFont.bodyNormal.fontSize,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailReportCard(
                      title: 'Lokasi Sampah',
                      subTitle: widget.lokasiTumpukanText),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailReportCard(
                    title: 'Lokasi Patokan',
                    subTitle: widget.lokasiPatokanText,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const DetailReportCard(
                    title: 'Informasi Jenis Sampah',
                    subItems: ['Sampah Kering', 'Sampah Basah'],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailReportCard(
                    title: 'Detail Kondisi Sampah',
                    subTitle: widget.kondisiSampahText,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const DetailReportCard(
                    title: 'Bukti Foto / Video',
                    //image:
                  ),
                ],
              )),
        ));
  }
}
