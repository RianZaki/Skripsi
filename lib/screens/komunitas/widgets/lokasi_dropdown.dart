import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/widgets/forms/custom_location_button.dart';

class LokasiDropdown extends StatelessWidget {
  const LokasiDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomLocationButton(),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Lokasi"),
            DropdownButton(
              value: "Bandung",
              elevation: 0,
              isDense: true,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: "Bekasi", child: Text("Bekasi")),
                DropdownMenuItem(value: "Bandung", child: Text("Bandung")),
                DropdownMenuItem(value: "Jakarta", child: Text("Jakarta")),
              ],
              onChanged: (value) {},
              icon: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  IconlyLight.arrow_down_2,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
