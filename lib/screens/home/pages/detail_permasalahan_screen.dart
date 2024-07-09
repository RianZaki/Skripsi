import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/faq_model.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPermasalahanScreen extends StatelessWidget {
  final FaqModel item;
  const DetailPermasalahanScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.textMainButton,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          "Detail Permasalahan",
          style: ThemeFont.heading6Medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: ThemeFont.bodyNormalSemiBold,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              item.desc,
              textAlign: TextAlign.justify,
              style: ThemeFont.bodySmallRegular,
            ),
            const Expanded(child: SizedBox()),
            Text(
              "Masih butuh bantuan?",
              style: ThemeFont.bodySmallSemiBold,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MainButton(
                  onPressed: () async {
                    var waUrl = Uri.parse("https://wa.me/6289522933558");
                    launchUrl(waUrl);
                  },
                  child: Text(
                    "Hubungi Kami",
                    style: ThemeFont.heading6Reguler.copyWith(
                        color: Pallete.textMainButton,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
