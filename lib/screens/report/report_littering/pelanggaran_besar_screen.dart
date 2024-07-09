import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/bloc/post_report_littering/post_report_littering_cubit.dart';
import 'package:recything_mobile/bloc/post_report_littering/post_report_littering_state.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/widget/date_picker_widget.dart';
import 'package:recything_mobile/screens/report/widget/file_picker_button.dart';
import 'package:recything_mobile/screens/report/widget/main_button_widget.dart';
import 'package:recything_mobile/screens/report/widget/maps_report_screen.dart';
import 'package:recything_mobile/screens/report/widget/text_field_report.dart';
import 'package:recything_mobile/screens/report/widget/time_picker_widget.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/success_screen.dart';

class LitteringBesarScreen extends StatefulWidget {
  final String? locationAddress;
  final String? latitude;
  final String? longitude;
  const LitteringBesarScreen({
    super.key,
    this.locationAddress,
    this.latitude,
    this.longitude,
  });

  @override
  State<LitteringBesarScreen> createState() => _LitteringBesarScreenState();
}

class _LitteringBesarScreenState extends State<LitteringBesarScreen> {
  bool isHazardousTrash = false;

  List<File> selectedImages = [];
  late FilePickerButton imagePickerButton;

  bool isFieldFilled = false;
  final locationController = TextEditingController();
  final addressPointController = TextEditingController(text: "");
  final descriptionController = TextEditingController(text: "");
  final companyNameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  bool isDataComplete() {
    return locationController.text.isNotEmpty &&
        addressPointController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        companyNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        selectedImages.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    imagePickerButton = FilePickerButton(
      onImagesSelected: (List<File>? images) {
        setState(() {
          selectedImages = images ?? [];
        });
        return null;
      },
    );

    locationController.text = widget.locationAddress ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //nggak teganti warna putih
      appBar: AppBar(
        title: Text(
          'Pelanggaran Skala Besar',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldReport(
                            hintText: "Lokasi Pelanggaran",
                            prefixIcon: IconlyLight.location,
                            controller: locationController,
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MapsReportScreen(
                                      reportType: 'littering-besar'),
                                ),
                              );
                            },
                            child: Image.asset("assets/images/map_icon.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Tambah Lokasi Patokan",
                    style: ThemeFont.bodySmallMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFieldReport(
                    hintText: 'Cth: Sungai Bengawan sebelah Hotel Teratai',
                    hintStyle: ThemeFont.bodySmallMedium.copyWith(
                      color: Pallete.dark3,
                    ),
                    controller: addressPointController,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Waktu Kejadian",
                    style: ThemeFont.bodySmallMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset("assets/images/littering_time_form.png"),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(IconlyLight.calendar),
                                      const SizedBox(width: 12),
                                      Text("Tanggal",
                                          style: ThemeFont.bodyNormalReguler),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: DatePickerWidget(
                                    controller: dateController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: Row(
                                    children: [
                                      const Icon(IconlyLight.time_circle),
                                      const SizedBox(width: 12),
                                      Text("Jam",
                                          style: ThemeFont.bodyNormalReguler),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: TimePickerWWidget(
                                    controller: timeController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Informasi Perusahaan",
                    style: ThemeFont.bodySmallMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFieldReport(
                    hintText: 'Cth: PT Mencari Cinta Sejati',
                    hintStyle: ThemeFont.bodySmallMedium.copyWith(
                      color: Pallete.dark3,
                    ),
                    controller: companyNameController,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0XFFFBD0DA),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 13,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    IconlyLight.danger,
                                    color: Color(0XFF5F071C),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Sampah Berbahaya?',
                                    style:
                                        ThemeFont.bodyNormalSemiBold.copyWith(
                                      color: const Color(0XFF5F071C),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Mengandung radioaktif, beracun, Mempengaruhi ekosistem sekitar.',
                                style: ThemeFont.bodySmallMedium.copyWith(
                                  color: const Color(0XFF5F071C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Switch(
                              value: isHazardousTrash,
                              onChanged: (bool value) {
                                setState(() {
                                  isHazardousTrash = value;
                                });
                              },
                              trackOutlineColor:
                                  MaterialStateProperty.resolveWith(
                                (final Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return null;
                                  }

                                  return const Color(0XFF5F071C);
                                },
                              ),
                              inactiveThumbColor: const Color(0XFF5F071C),
                              inactiveTrackColor: Colors.white,
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0XFF5F071C)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Ceritakan Detail Kejadian",
                    style: ThemeFont.bodySmallMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFieldReport(
                    hintText:
                        "Cth: Saya melihat Seseorang membuang sampah sembarangan ke sungai",
                    maxLines: 5,
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 16),
                  Text('Bukti Foto / Video',
                      style: ThemeFont.bodyNormalReguler),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 80,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        imagePickerButton,
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Format file: JPG, PNG, MP4',
                    style: ThemeFont.bodySmallRegular.copyWith(
                        color: Pallete.dark3, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Maksimum file: 20 MB',
                    style: ThemeFont.bodySmallRegular.copyWith(
                        color: Pallete.dark3, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: BlocListener<PostReportLitteringCubit,
                            PostReportLitteringState>(
                          listener: (context, state) {
                            if (state is PostReportLitteringSuccess) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SuccessScreen(
                                      title: 'Laporan Terkirim',
                                      subtitle:
                                          'Terimakasih telah berkontribusi untuk melaporkan pelanggaran dan kondisi sampah yang kamu temui, kami sangat mengapresiasi usaha anda.'),
                                ),
                              );
                            }
                            if (state is PostReportLitteringFailed) {
                              ErrorSnackbar.showSnackbar(
                                context,
                                message: state.message,
                                title: "Laporan gagal",
                              );
                            }
                          },
                          child: BlocBuilder<PostReportLitteringCubit,
                              PostReportLitteringState>(
                            builder: (context, state) {
                              if (locationController.text.isNotEmpty &&
                                  addressPointController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty &&
                                  companyNameController.text.isNotEmpty &&
                                  dateController.text.isNotEmpty &&
                                  timeController.text.isNotEmpty) {
                                return MainButtonWidget(
                                  onPressed: () {
                                    DateTime dateTime = DateFormat("MM/dd/yyyy")
                                        .parse(dateController.text);
                                    context
                                        .read<PostReportLitteringCubit>()
                                        .addReport(
                                          context: context,
                                          reportType: "pelanggaran sampah",
                                          scaleType: "skala besar",
                                          location: locationController.text,
                                          latitude: widget.latitude ?? "0",
                                          longitude: widget.longitude ?? "0",
                                          companyName:
                                              companyNameController.text,
                                          addressPoint:
                                              addressPointController.text,
                                          insidentDate: DateFormat("yyyy-MM-dd")
                                              .format(dateTime),
                                          insidentTime: timeController.text,
                                          desc: descriptionController.text,
                                          dangerousWaste: isHazardousTrash,
                                          images: selectedImages,
                                        );
                                  },
                                  child: BlocBuilder<PostReportLitteringCubit,
                                      PostReportLitteringState>(
                                    builder: (context, state) {
                                      if (state is PostReportLitteringLoading) {
                                        return const SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          'Kirim',
                                          style:
                                              ThemeFont.heading6Bold.copyWith(
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              } else {
                                return MainButtonWidget(
                                  child: Text(
                                    'Kirim',
                                    style: ThemeFont.heading6Bold.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
