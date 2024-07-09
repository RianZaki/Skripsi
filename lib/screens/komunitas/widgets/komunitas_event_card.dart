import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/events_model.dart';
import 'package:recything_mobile/screens/komunitas/detail_event_komunitas_screen.dart';

class KomunitasEventCard extends StatelessWidget {
  final EventsModel item;
  const KomunitasEventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    DateTime inputDate =
        DateFormat("yyyy/MM/dd").parse(item.date ?? "2023/12/14");

    String formattedDate = DateFormat("d MMMM", "id_ID").format(inputDate);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailEventKomunitasScreen(
            idEvent: item.id!,
            idKominutas: item.communityId!,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        item.image ?? "",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 88,
                  width: 88,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  height: 88,
                  width: 88,
                  child: Center(
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        formattedDate,
                        textAlign: TextAlign.center,
                        style: ThemeFont.bodySmall
                            .copyWith(color: Colors.white, height: 1.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? "",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: ThemeFont.bodyMediumBold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item.quota} Peserta",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeFont.bodySmallRegular
                        .copyWith(color: Pallete.dark4),
                  ),
                  const SizedBox(height: 4),
                  // Text(
                  //   "Pantai Pandawa, JLn Tenku Umar, Jakarta",
                  //   softWrap: true,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: ThemeFont.bodySmallRegular
                  //       .copyWith(color: Pallete.dark3),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
