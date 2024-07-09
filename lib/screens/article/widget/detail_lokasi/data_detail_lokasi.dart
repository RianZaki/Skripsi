import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/drop_points_model.dart';

class DataDetailLokasiWidget extends StatelessWidget {
  final DropPointsModel item;
  const DataDetailLokasiWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(
            item.latitude?.toDouble() ?? 0, item.longitude?.toDouble() ?? 0),
        zoom: 14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: GoogleMap(
              mapType: MapType.terrain, initialCameraPosition: _kGooglePlex),
        ),
        const SizedBox(height: 12),
        Text(
          item.name,
          style: ThemeFont.bodyNormalSemiBold,
        ),
        const SizedBox(height: 4),
        Text(
          item.address,
          style: ThemeFont.bodySmallRegular,
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 12),
        Text(
          'Jam Operasional',
          style: ThemeFont.bodySmallSemiBold,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: item.scheduleModel?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.scheduleModel?[index].day[0].toUpperCase()}${item.scheduleModel?[index].day.substring(1)}",
                      style: ThemeFont.bodySmallRegular,
                    ),
                    Text(
                      item.scheduleModel?[index].closed == true
                          ? "Tutup"
                          : '${item.scheduleModel?[index].openTime}-${item.scheduleModel?[0].closeTime} (WIB)',
                      style: ThemeFont.bodySmallRegular,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
