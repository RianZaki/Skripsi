import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/poinku/pages/tukar_voucher_screen.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class PoinkuVoucher extends StatelessWidget {
  final int userPoint;
  final String imageUrl;
  final String voucherTitle;
  final String point;
  final DateTime expiredDate;
  final String description;
  final String id;

  const PoinkuVoucher(
      {super.key,
      required this.imageUrl,
      required this.voucherTitle,
      required this.point,
      required this.expiredDate,
      required this.description,
      required this.id,
      required this.userPoint});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final formattedPoint =
        NumberFormat.decimalPattern('id_ID').format(int.parse(point));

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detailVoucher', arguments: {
          'imageUrl': imageUrl,
          'voucherTitle': voucherTitle,
          'point': point,
          'expiredDate': expiredDate,
          'description': description,
          'id': id,
          'userPoint': userPoint
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Pallete.light3, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      imageUrl,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            voucherTitle,
                            style: ThemeFont.interText.copyWith(fontSize: 16),
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            '$formattedPoint Poin',
                            style: ThemeFont.interText.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: DashedLine(
              path: Path()
                ..cubicTo(
                    0, 0, 0, 1, MediaQuery.of(context).size.width * 0.8, 0),
              color: Pallete.dark3,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Pallete.light3, borderRadius: BorderRadius.circular(12)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berlaku sampai :",
                          style: ThemeFont.interText
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        DateFormat("d MMMM y", "id_ID").format(expiredDate),
                        style: ThemeFont.interText
                            .copyWith(color: Pallete.textSecondary),
                      )
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: MainButton(
                          onPressed: userPoint < int.parse(point)
                              ? null
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            elevation: 0,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  "assets/icons/tiket.png",
                                                  width: 24,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Tukarkan Voucher Ini?",
                                                  style: ThemeFont.interText
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Kamu yakin ingin Menukarkan Voucher dana menggunakan point?",
                                                  style: ThemeFont.interText
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: Pallete
                                                              .textSecondary),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Pallete.main,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8), // Ganti dengan radius yang Anda inginkan
                                                            ),
                                                            side: const BorderSide(
                                                                color: Pallete
                                                                    .main),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Batal")),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: MainButton(
                                                            onPressed: userPoint <
                                                                    int.parse(
                                                                        point)
                                                                ? null
                                                                : () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                TukatVoucherScreen(id: id)));
                                                                  },
                                                            child: Text(
                                                              "Tukar",
                                                              style: ThemeFont
                                                                  .heading6Reguler
                                                                  .copyWith(
                                                                      color: Pallete
                                                                          .textMainButton,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            )))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )));
                                },
                          child: Text(
                            "Tukar",
                            style: ThemeFont.heading6Reguler.copyWith(
                                color: Pallete.textMainButton,
                                fontWeight: FontWeight.w700),
                          )))
                ]),
          )
        ],
      ),
    );
  }
}
