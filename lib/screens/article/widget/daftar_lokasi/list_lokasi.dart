import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/drop_points_model.dart';
import 'package:recything_mobile/screens/article/page/detail_lokasi.dart';
import 'package:recything_mobile/screens/article/theme/color_style.dart';

class ListLokasiWidget extends StatelessWidget {
  final DropPointsModel item;
  final int no;
  const ListLokasiWidget({super.key, required this.item, required this.no});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: ThemeColor().whiteColor,
            // border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: ThemeFont.bodySmallSemiBold
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    item.address,
                    style: ThemeFont.bodySmallRegular.copyWith(
                        color: Pallete.dark3, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Detail Drop Point',
                      style: ThemeFont.bodySmallRegular
                          .copyWith(color: Pallete.main),
                    ),
                    const Icon(
                      IconlyLight.arrow_right_2,
                      color: Pallete.main,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailLokasiScreen(item: item)));
                },
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailLokasiScreen(item: item)));
        },
      ),
    );
  }
}
