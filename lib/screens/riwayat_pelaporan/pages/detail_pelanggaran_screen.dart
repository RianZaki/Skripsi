import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/bloc/get_history_report_by_id/get_history_report_by_id_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/dashboard.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/widgets/detail_card.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/widgets/pelaporan_image_card.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';

class DetailPelanggaranScreen extends StatefulWidget {
  final String id;
  const DetailPelanggaranScreen({super.key, required this.id});

  @override
  State<DetailPelanggaranScreen> createState() =>
      _DetailPelanggaranScreenState();
}

class _DetailPelanggaranScreenState extends State<DetailPelanggaranScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetHistoryReportByIdCubit>()
        .fetchReportById(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomBackButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Dasboard(index: 2)));
          }),
        ),
        title: Text(
          "Detail Pelaporan",
          style: ThemeFont.heading6Medium,
        ),
      ),
      body: SingleChildScrollView(
        child:
            BlocBuilder<GetHistoryReportByIdCubit, GetHistoryReportByIdState>(
          builder: (context, state) {
            if (state is GetHistoryReportByIdLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetHistoryReportByIdFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is GetHistoryReportByIdSuccess) {
              List<String> kataKata = state.data.reportType.split(' ');
              return Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                        color: Pallete.textMainButton,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Pallete.dark1.withOpacity(0.15))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Jenis Pelanggaran : ",
                                style: ThemeFont.bodySmallSemiBold),
                            Text("Pelanggaran Sampah",
                                style: ThemeFont.bodySmallSemiBold
                                    .copyWith(color: Pallete.dark3)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text("Skala Pelanggaran : ",
                                style: ThemeFont.bodySmallSemiBold),
                            Text(state.data.scaleType ?? "",
                                style: ThemeFont.bodySmallSemiBold
                                    .copyWith(color: Pallete.dark3)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text("Status Pelaporan : ",
                                style: ThemeFont.bodySmallSemiBold),
                            Text(state.data.status!.toUpperCase(),
                                style: ThemeFont.bodySmallSemiBold.copyWith(
                                    color: state.data.status == "ditolak"
                                        ? Pallete.error
                                        : Pallete.main)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (state.data.status == "ditolak")
                          Row(
                            children: [
                              Text("Alasan :",
                                  style: ThemeFont.bodySmallSemiBold),
                              Text(" Detail Kejadian Kurang Jelas",
                                  style: ThemeFont.bodySmallSemiBold
                                      .copyWith(color: Pallete.dark3)),
                            ],
                          ),
                        if (state.data.status == "diterima")
                          Text(
                              "Pelaporan Anda telah kami terima. Terima kasih sudah melaporkan pelanggaran sampah.",
                              style: ThemeFont.bodySmallSemiBold
                                  .copyWith(color: Pallete.dark3)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailCard(
                      title:
                          "Lokasi ${kataKata.first[0].toUpperCase() + kataKata.first.substring(1)}",
                      value: state.data.location ?? ""),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailCard(
                      title: "Lokasi Patokan",
                      value: state.data.addressPoint.toString()),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                        color: Pallete.textMainButton,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Pallete.dark1.withOpacity(0.15))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Waktu Kejadian",
                            style: ThemeFont.bodySmallSemiBold),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tanggal : ",
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Pallete.dark3)),
                            Text(
                              (() {
                                try {
                                  final parsedDate =
                                      DateTime.parse(state.data.insidentDate!);
                                  return DateFormat("dd MMMM yyyy")
                                      .format(parsedDate)
                                      .toString();
                                } catch (e) {
                                  print("Error parsing date: $e");
                                  return "Invalid Date Format";
                                }
                              })(),
                              style: ThemeFont.bodySmallRegular.copyWith(
                                color: Pallete.dark3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jam : ",
                              style: ThemeFont.bodySmallRegular.copyWith(
                                color: Pallete.dark3,
                              ),
                            ),
                            Text(
                              state.data.insidentTime ?? "",
                              style: ThemeFont.bodySmallRegular.copyWith(
                                color: Pallete.dark3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state.data.dangerousWaste == true)
                    Column(
                      children: [
                        DetailCard(
                            title: "Informasi Perusahaan",
                            value: state.data.companyName ?? ""),
                        const SizedBox(
                          height: 16,
                        ),
                        const DetailCard(
                          title: "Jenis Pelanggaran Sampah",
                          value: "Sampah Berbahaya",
                          color: Pallete.error,
                        ),
                      ],
                    ),
                  DetailCard(
                      title: "Detail Kondisi Sampah",
                      value: state.data.desc ?? ""),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                        color: Pallete.textMainButton,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Pallete.dark1.withOpacity(0.15))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bukti Foto/Video : ",
                            style: ThemeFont.bodySmallSemiBold),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            shrinkWrap: true,
                            itemCount: state.data.image?.length,
                            itemBuilder: (context, index) {
                              String imageUrl = state.data.image![index].image!;
                              FileType fileType =
                                  PelaporanImageCard.getFileType(imageUrl);

                              return GestureDetector(
                                onTap: () {
                                  if (fileType == FileType.image) {
                                    PelaporanImageCard.showImage(
                                        context, imageUrl);
                                  } else if (fileType == FileType.video) {
                                    PelaporanImageCard.showVideo(
                                        context, imageUrl);
                                  }
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  margin:
                                      const EdgeInsets.only(right: 8, top: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: fileType == FileType.video
                                          ? Border.all(color: Pallete.dark4)
                                          : Border.all(
                                              color: Colors.transparent)),
                                  child: fileType == FileType.image
                                      ? Image.network(
                                          state.data.image![index].image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.play_arrow,
                                          size: 50,
                                        ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
