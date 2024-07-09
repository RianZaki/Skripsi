import 'package:flutter/material.dart';
import 'package:recything_mobile/models/drop_points_model.dart';
import 'package:recything_mobile/screens/article/widget/detail_lokasi/bottom_detail_lokasi.dart';
import 'package:recything_mobile/screens/article/widget/detail_lokasi/data_detail_lokasi.dart';
import 'package:recything_mobile/screens/article/widget/header_page.dart';

class DetailLokasiScreen extends StatefulWidget {
  final DropPointsModel item;
  const DetailLokasiScreen({super.key, required this.item});

  @override
  State<DetailLokasiScreen> createState() => _DetailLokasiScreenState();
}

class _DetailLokasiScreenState extends State<DetailLokasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: HeaderPageWidget(title: 'Detail Lokasi'),
        ),
        body: ListView(
          children: [
            SizedBox(height: 24),
            // BoxMapWidget(),
            // SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: DataDetailLokasiWidget(item: widget.item),
            ),
          ],
        ),
        bottomNavigationBar: BottomDetailLokasiWidget(
          item: widget.item,
        ));
  }
}
