import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/poinku/pages/tukar_voucher_screen.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class DetailVoucherScreen extends StatelessWidget {
  const DetailVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final formattedPoint =
        NumberFormat.decimalPattern('id_ID').format(int.parse(args['point']));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Voucher",
          style: ThemeFont.interText
              .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                args['imageUrl'],
                width: 220,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 43, 16, 0),
              child: Text(
                args['voucherTitle'],
                style: ThemeFont.interText
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '$formattedPoint Poin',
                style: ThemeFont.interText.copyWith(
                    color: Pallete.main,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Text("Berlaku sampai : ",
                      style: ThemeFont.interText.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    DateFormat('d MMMM y', 'id_ID').format(args['expiredDate']),
                    style: ThemeFont.interText.copyWith(color: Pallete.dark4),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text("Deskripsi : ",
                  style: ThemeFont.interText.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                args['description'],
                style: ThemeFont.interText.copyWith(color: Pallete.dark3),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: MainButton(
                    onPressed: (args['userPoint'] < int.parse(args["point"]))
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TukatVoucherScreen(id: args["id"])));
                          },
                    child: Text(
                      "Tukar",
                      style: ThemeFont.heading6Reguler.copyWith(
                          color: Pallete.textMainButton,
                          fontWeight: FontWeight.w700),
                    )))
          ],
        ),
      ),
    );
  }
}
