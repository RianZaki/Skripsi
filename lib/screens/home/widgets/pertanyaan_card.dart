import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/faq_model.dart';
import 'package:recything_mobile/screens/home/pages/detail_permasalahan_screen.dart';

class PertanyaanCard extends StatefulWidget {
  final FaqModel item;
  const PertanyaanCard({super.key, required this.item});

  @override
  State<PertanyaanCard> createState() => _PertanyaanCardState();
}

class _PertanyaanCardState extends State<PertanyaanCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.item.title,
        style: ThemeFont.bodyNormalSemiBold,
      ),
      tilePadding: EdgeInsets.zero,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.item.desc,
                style: ThemeFont.bodySmallRegular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPermasalahanScreen(
                      item: widget.item,
                    );
                  }));
                },
                child: Text(
                  "Selengkapnya",
                  style:
                      ThemeFont.bodySmallSemiBold.copyWith(color: Pallete.main),
                ))
          ],
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {});
      },
    );
  }
}
