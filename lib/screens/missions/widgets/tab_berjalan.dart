import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_missions/get_missions_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/mission_card.dart';
import 'package:recything_mobile/screens/missions/widgets/sf_track_shape_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TabBerjalan extends StatefulWidget {
  TabBerjalan({super.key});

  @override
  State<TabBerjalan> createState() => _TabBerjalanState();
}

class _TabBerjalanState extends State<TabBerjalan> {
  @override
  void initState() {
    context.read<GetMissionsCubit>().getMissions(filter: 'berjalan');
    super.initState();
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  Color determineStatusColor(String statusApproval) {
    Color statusColor = Pallete.dark3;

    if (statusApproval == 'Bukti tidak jelas' ||
        statusApproval == 'Bukti kurang lengkap' ||
        statusApproval == 'Tidak ada detail kejadian') {
      statusColor = Pallete.error;
    } else if (statusApproval == 'menunggu verifikasi') {
      statusColor = Pallete.infoLigther;
    }

    return statusColor;
  }

  String determineStatus(String statusApproval) {
    String status = '';

    if (statusApproval == 'Bukti tidak jelas' ||
        statusApproval == 'Bukti kurang lengkap' ||
        statusApproval == 'Tidak ada detail kejadian') {
      status = 'Tolong perbaiki bukti';
      return capitalizeFirstLetter(status);
    }

    return capitalizeFirstLetter(statusApproval);
  }

  int determineProgressPercentage(String statusApproval) {
    int percentage = 33;

    if (statusApproval == 'Bukti tidak jelas' ||
        statusApproval == 'Bukti kurang lengkap' ||
        statusApproval == 'Tidak ada detail kejadian' ||
        statusApproval == 'menunggu verifikasi') {
      percentage = 50;
    }

    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: BlocBuilder<GetMissionsCubit, GetMissionsState>(
            builder: (context, state) {
              if (state is GetMissionsLoaded) {
                return state.missions.data?.length == 0
                    ? Center(child: Text('Belum ada misi'))
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: state.missions.data?.length,
                        itemBuilder: (context, index) {
                          var data = state.missions.data?[index];
                          return Column(
                            children: [
                              MissionCard(
                                title: data?.title ?? 'No Title',
                                subTitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: SfSliderTheme(
                                            data: SfSliderThemeData(
                                                overlayRadius: 0,
                                                thumbRadius: 4,
                                                thumbStrokeWidth: 0.5,
                                                thumbStrokeColor: Colors.white,
                                                thumbColor: Pallete.mainDarker,
                                                activeTrackHeight: 8,
                                                activeTrackColor:
                                                    Pallete.mainLigther,
                                                inactiveTrackHeight: 8,
                                                inactiveTrackColor:
                                                    Pallete.dark4),
                                            child: SfSlider(
                                              trackShape: SfTrackShapeWidget(),
                                              min: 0.0,
                                              max: 100.0,
                                              value:
                                                  determineProgressPercentage(
                                                      data?.statusApproval ??
                                                          'No Status'),
                                              onChanged: (dynamic value) {},
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          '${determineProgressPercentage(data?.statusApproval ?? 'No Status').toString()}%',
                                          style: ThemeFont.bodySmallRegular,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      determineStatus(
                                          data?.statusApproval ?? 'No Status'),
                                      style: ThemeFont.bodySmallRegular
                                          .copyWith(
                                              color: determineStatusColor(
                                                  data?.statusApproval ??
                                                      'No Status')),
                                    )
                                  ],
                                ),
                                imageUrl: data?.missionImage ?? '',
                                args: {
                                  'missionId': data?.missionId,
                                  'transactionId':
                                      data?.transactionId ?? "None",
                                  'imageUrl': data?.missionImage,
                                  'title': data?.title,
                                  'expiredDate': data?.endDate,
                                  'point': data?.point,
                                  'desc': data?.description,
                                  'progressState': data?.statusApproval,
                                  'title_stage': data?.titleStage ?? 'No stage',
                                  'description_stage': data?.descriptionStage ??
                                      'No description stage',
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          );
                        });
              } else if (state is GetMissionsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Pallete.main,
                  ),
                );
              }

              return Center(
                child: Text('Terjadi Kesalahan'),
              );
            },
          ),
        )
      ],
    );
  }
}
