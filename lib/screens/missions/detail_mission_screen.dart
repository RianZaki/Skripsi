import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/bloc/claim_mission/claim_mission_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/custom_leading_app_bar.dart';
import 'package:recything_mobile/widgets/forms/progress_state_box.dart';
import 'package:recything_mobile/screens/missions/widgets/progress_step.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class DetailMissionScreen extends StatefulWidget {
  const DetailMissionScreen({super.key});

  @override
  State<DetailMissionScreen> createState() => _DetailMissionScreenState();
}

class _DetailMissionScreenState extends State<DetailMissionScreen> {
  bool isProofRejected(String progressState) {
    if (progressState == 'Bukti tidak jelas' ||
        progressState == 'Bukti kurang lengkap' ||
        progressState == 'Tidak ada detail kejadian') {
      return true;
    }

    return false;
  }

  Map<String, dynamic> determineProgressStateBoxContent(String progressState) {
    Map<String, dynamic> content = {};

    if (progressState == 'menunggu verifikasi') {
      content['state'] = 'Sedang Verifikasi';
      content['bgColor'] = Pallete.infoSubtle;
    } else if (progressState == 'Bukti tidak jelas' ||
        progressState == 'Bukti kurang lengkap' ||
        progressState == 'Tidak ada detail kejadian') {
      content['state'] = 'Ditolak';
      content['bgColor'] = Pallete.errorSubtle;
    } else if (progressState == 'disetujui') {
      content['state'] = 'Terverifikasi';
      content['bgColor'] = Pallete.successLigther;
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final formattedDate =
        DateFormat("d MMMM y", "id_ID").format(args['expiredDate']);
    String progressState = args['progressState'];

    return Scaffold(
      appBar: const CustomLeadingAppBar(title: 'Detail Misi'),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: double.infinity,
            height: 240,
            child: Image.network(
              args['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        args['title'],
                        style: ThemeFont.bodyLargeMedium,
                      ),
                    ),
                    SizedBox(width: 20),
                    progressState == 'menunggu verifikasi' ||
                            isProofRejected(progressState) ||
                            progressState == 'disetujui'
                        ? ProgressStateBox(
                            boxColor: determineProgressStateBoxContent(
                                progressState)['bgColor'],
                            child: Text(
                              determineProgressStateBoxContent(
                                  progressState)['state'],
                              style: ThemeFont.bodySmallRegular
                                  .copyWith(color: Colors.white),
                            ))
                        : const SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Berlaku Sampai',
                          style: ThemeFont.bodySmallRegular,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          formattedDate,
                          style: ThemeFont.bodySmallSemiBold
                              .copyWith(color: Pallete.main),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hadiah', style: ThemeFont.bodySmallRegular),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${args['point']} Poin',
                          style: ThemeFont.bodySmallSemiBold
                              .copyWith(color: Pallete.secondary),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Deskripsi',
                  style: ThemeFont.bodySmallSemiBold,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  args['desc'],
                  style: ThemeFont.bodySmallRegular,
                ),
                const SizedBox(
                  height: 24,
                ),
                ProgressStep(
                  progressState: progressState,
                  titleStage: args['title_stage'],
                  descriptionStage: args['description_stage'],
                  missionId: args['missionId'],
                  transactionId: args['transactionId'],
                  statusApproval: args['progressState'],
                ),
                const SizedBox(
                  height: 24,
                ),
                progressState == 'menunggu verifikasi' ||
                        isProofRejected(progressState) ||
                        progressState == 'disetujui'
                    ? const SizedBox()
                    : SizedBox(
                        width: double.infinity,
                        child: progressState == 'Aktif'
                            ? BlocBuilder<ClaimMissionCubit, ClaimMissionState>(
                                builder: (context, state) {
                                  return MainButton(
                                      onPressed: () => context
                                          .read<ClaimMissionCubit>()
                                          .claimMission(
                                              missionId: args['missionId']),
                                      child: state is ClaimMissionLoading
                                          ? SizedBox(
                                              width: 23,
                                              height: 23,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Terima Tantangan',
                                              style: ThemeFont.heading6Bold
                                                  .copyWith(
                                                      color: Colors.white),
                                            ));
                                },
                              )
                            : MainButton(
                                onPressed: () => Navigator.pushNamed(
                                        context, '/unggah-bukti', arguments: {
                                      'missionId': args['missionId']
                                    }),
                                child: Text(
                                  'Unggah Bukti',
                                  style: ThemeFont.heading6Bold
                                      .copyWith(color: Colors.white),
                                )),
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
