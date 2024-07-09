import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_missions/get_missions_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/mission_card.dart';
import 'package:recything_mobile/screens/missions/widgets/sf_track_shape_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TabSelesai extends StatefulWidget {
  TabSelesai({super.key});

  @override
  State<TabSelesai> createState() => _TabSelesaiState();
}

class _TabSelesaiState extends State<TabSelesai> {
  @override
  void initState() {
    context.read<GetMissionsCubit>().getMissions(filter: 'selesai');
    super.initState();
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
                                                disabledThumbColor:
                                                    Pallete.mainDarker,
                                                activeTrackHeight: 8,
                                                disabledActiveTrackColor:
                                                    Pallete.mainLigther,
                                                inactiveTrackHeight: 8,
                                                disabledInactiveTrackColor:
                                                    Pallete.dark4),
                                            child: SfSlider(
                                              trackShape: SfTrackShapeWidget(),
                                              min: 0.0,
                                              max: 100.0,
                                              value: 100,
                                              onChanged: null,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          ('100%'),
                                          style: ThemeFont.bodySmallRegular,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Hadiah diklaim Otomatis!',
                                      style: ThemeFont.bodySmallRegular
                                          .copyWith(color: Pallete.dark3),
                                    )
                                  ],
                                ),
                                imageUrl: data?.missionImage ?? '',
                                args: {
                                  'imageUrl': data?.missionImage,
                                  'title': data?.title,
                                  'expiredDate': data?.endDate,
                                  'point': data?.point,
                                  'desc': data?.description,
                                  'progressState': data?.statusApproval,
                                  'title_stage':
                                      data?.titleStage ?? 'Tantangan Selesai',
                                  'description_stage': data?.descriptionStage ??
                                      'Selamat! Kamu sudah menyelesaikan tantangan ini dengan baik',
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
