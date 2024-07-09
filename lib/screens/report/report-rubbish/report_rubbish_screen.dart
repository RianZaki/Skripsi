import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/post_report/post_report_rubbish_cubit.dart';
import 'package:recything_mobile/bloc/post_report/post_report_rubbish_state.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/report/widget/file_picker_button.dart';
import 'package:recything_mobile/screens/report/widget/checkbox_report.dart';
import 'package:recything_mobile/screens/report/widget/main_button_widget.dart';
import 'package:recything_mobile/screens/report/widget/maps_report_screen.dart';
import 'package:recything_mobile/screens/report/widget/text_field_report.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/success_screen.dart';

class ReportRubbishScreen extends StatefulWidget {
  final String? locationAddress;
  final String? latitude;
  final String? longitude;

  const ReportRubbishScreen({
    Key? key,
    this.locationAddress,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  State<ReportRubbishScreen> createState() => _ReportRubbishScreenState();
}

class _ReportRubbishScreenState extends State<ReportRubbishScreen> {
  List<File> selectedImages = [];
  late FilePickerButton imagePickerButton;

  final locationController = TextEditingController();
  TextEditingController lokasiPatokanController = TextEditingController();
  TextEditingController kondisiSampahController = TextEditingController();

  bool isDataComplete() {
    return locationController.text.isNotEmpty &&
        lokasiPatokanController.text.isNotEmpty &&
        (context.read<PostReportRubbishCubit>().isCheckedKering ||
            context.read<PostReportRubbishCubit>().isCheckedBasah) &&
        kondisiSampahController.text.isNotEmpty &&
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tumpukan Sampah',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
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
                            hintText: 'Lokasi Tumpukan',
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
                                      reportType: 'rubbish'),
                                ),
                              );
                            },
                            child: Image.asset("assets/images/map_icon.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Tambah Lokasi Patokan',
                    style: ThemeFont.bodySmallMedium,
                  ),
                  const SizedBox(height: 4),
                  TextFieldReport(
                    controller: lokasiPatokanController,
                    hintText: 'Cth: Sebelah Masjid Nawawi',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Jenis Sampah',
                    style: ThemeFont.bodyNormalReguler,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      CheckboxReportWidget(
                          options: ['Sampah Kering', 'Sampah Basah'],
                          onChanged: (selectOption) {
                            if (selectOption == 'Sampah Kering') {
                              context
                                  .read<PostReportRubbishCubit>()
                                  .toggleCheckboxKering(true);
                              context
                                  .read<PostReportRubbishCubit>()
                                  .toggleCheckboxBasah(false);
                              print('Kering = ' +
                                  context
                                      .read<PostReportRubbishCubit>()
                                      .isCheckedKering
                                      .toString());
                            } else if (selectOption == 'Sampah Basah') {
                              context
                                  .read<PostReportRubbishCubit>()
                                  .toggleCheckboxBasah(true);
                              context
                                  .read<PostReportRubbishCubit>()
                                  .toggleCheckboxKering(false);
                              print('Basah = ' +
                                  context
                                      .read<PostReportRubbishCubit>()
                                      .isCheckedBasah
                                      .toString());
                            }
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Ceritakan Kondisi Sampah',
                      style: ThemeFont.bodySmallMedium),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFieldReport(
                    controller: kondisiSampahController,
                    maxLines: 5,
                    hintText:
                        'Cth: Saya melihat tumpukan sampah yang sangat banyak, sampah sangat bercampur basah dan kering',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                      color: Pallete.dark3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Maksimum file: 20 MB',
                    style: ThemeFont.bodySmallRegular.copyWith(
                      color: Pallete.dark3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 47,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocListener<PostReportRubbishCubit,
                            PostReportRubbishState>(
                          listener: (context, state) {
                            if (state is PostReportRubbishSuccess) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SuccessScreen(
                                    title: 'Laporan Terkirim',
                                    subtitle:
                                        'Terimakasih telah berkontribusi untuk melaporkan pelanggaran dan kondisi sampah yang kamu temui, kami sangat mengapresiasi usaha anda.',
                                  ),
                                ),
                              );
                            }
                          },
                          child: MainButtonWidget(
                            child: BlocBuilder<PostReportRubbishCubit,
                                PostReportRubbishState>(
                              builder: (context, state) {
                                if (state is PostReportRubbishLoading) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                } else if (state is PostReportRubbishFailed) {
                                  return Text(state.message);
                                } else {
                                  return Text(
                                    "Kirim",
                                    style: ThemeFont.heading6Bold.copyWith(
                                      color: Pallete.textMainButton,
                                    ),
                                  );
                                }
                              },
                            ),
                            onPressed: isDataComplete()
                                ? () {
                                    context
                                        .read<PostReportRubbishCubit>()
                                        .reports(
                                          context: context,
                                          reportType: "tumpukan sampah",
                                          location:
                                              widget.locationAddress ?? "",
                                          latitude: widget.latitude ?? "0",
                                          longitude: widget.longitude ?? "0",
                                          addressPoint:
                                              lokasiPatokanController.text,
                                          trashType: context
                                              .read<PostReportRubbishCubit>()
                                              .getTrashType(),
                                          desc: kondisiSampahController.text,
                                          images: selectedImages,
                                        );
                                  }
                                : null,
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
