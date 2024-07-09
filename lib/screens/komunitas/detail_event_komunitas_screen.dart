import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/bloc/get_detail_event/get_detail_event_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/berhasil_bergabung_screen.dart';
import 'package:recything_mobile/widgets/badges.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/secondary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailEventKomunitasScreen extends StatefulWidget {
  final String idKominutas;
  final String idEvent;
  const DetailEventKomunitasScreen(
      {super.key, required this.idKominutas, required this.idEvent});

  @override
  State<DetailEventKomunitasScreen> createState() =>
      _DetailEventKomunitasScreenState();
}

class _DetailEventKomunitasScreenState extends State<DetailEventKomunitasScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();

  void initState() {
    super.initState();
    context
        .read<GetDetailEventCubit>()
        .fetchData(idKomunitas: widget.idKominutas, idEvent: widget.idEvent);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 32, bottom: 8),
        width: double.infinity,
        child: Expanded(
          child: MainButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BerhasilBergabungScreen(),
              ));
            },
            child: Text(
              "Gabung Event",
              style: ThemeFont.heading6Reguler.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<GetDetailEventCubit, GetDetailEventState>(
            builder: (context, state) {
              if (state is GetDetailEventLoading) {
                return CircularProgressIndicator();
              } else if (state is GetDetailEventFailure) {
                return Text(state.msg);
              } else if (state is GetDetailEventSuccess) {
                initializeDateFormatting();
                DateTime tanggal = DateFormat("yyyy/MM/dd")
                    .parse(state.data.date ?? "2023/12/14");

                String tanggalFormatted =
                    DateFormat("d MMMM y", "id_ID").format(tanggal);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomBackButton(),
                          Text(
                            "Detail Event",
                            style: ThemeFont.heading6Reguler,
                          ),
                          const SizedBox(width: 40)
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            state.data.image ??
                                "https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 240,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.data.title ?? "",
                            style: ThemeFont.heading5Reguler,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MainBadge(text: state.data.location ?? ""),
                              const SizedBox(width: 8),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "kuota tersisa : ${state.data.quota} orang",
                                  style: ThemeFont.bodySmall
                                      .copyWith(color: Pallete.dark3),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const CircleAvatar(
                                maxRadius: 24,
                                backgroundColor: Pallete.mainSubtle,
                                child: Icon(
                                  IconlyLight.calendar,
                                  color: Pallete.mainDarker,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tanggalFormatted,
                                    style: ThemeFont.heading6Bold
                                        .copyWith(color: Pallete.dark1),
                                  ),
                                  // Text(
                                  //   "Rabu, 08.00 WIB - 12.00 WIB",
                                  //   style: ThemeFont.bodySmallSemiBold
                                  //       .copyWith(color: Pallete.dark3),
                                  // ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const CircleAvatar(
                                maxRadius: 24,
                                backgroundColor: Pallete.mainSubtle,
                                child: Icon(
                                  IconlyLight.location,
                                  color: Pallete.mainDarker,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.data.location ?? "",
                                    style: ThemeFont.heading6Bold
                                        .copyWith(color: Pallete.dark1),
                                  ),
                                  // Text(
                                  //   "Desa Kutuh, Badung, Kuta, Bali",
                                  //   style: ThemeFont.bodySmallSemiBold
                                  //       .copyWith(color: Pallete.dark3),
                                  // ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  onPressed: () {
                                    var mapsUrl =
                                        Uri.parse(state.data.maplink ?? "");
                                    launchUrl(mapsUrl);
                                  },
                                  child: Text(
                                    "Lihat Di Maps",
                                    style: ThemeFont.heading6Bold
                                        .copyWith(color: Pallete.main),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Pallete.dark4,
                            thickness: 1,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deskripsi Event",
                            style: ThemeFont.heading5Reguler.copyWith(
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.data.description ?? "",
                            style: ThemeFont.bodySmall
                                .copyWith(height: 1.6, color: Pallete.dark3),
                          ),
                          const SizedBox(height: 120)
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
