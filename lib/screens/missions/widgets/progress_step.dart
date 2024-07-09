import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/progress_card.dart';

class ProgressStep extends StatelessWidget {
  final String progressState;
  final String titleStage;
  final String descriptionStage;
  final String? missionId;
  final String? transactionId;
  final String? statusApproval;

  const ProgressStep(
      {super.key,
      required this.progressState,
      required this.titleStage,
      required this.descriptionStage,
      this.missionId,
      this.transactionId,
      this.statusApproval});

  Map<String, dynamic> determineSecondStepContent(String progressState) {
    Map<String, dynamic> content = {
      'title': 'Unggah bukti',
      'subTitle': 'Unggah foto bukti pengerjaan tantangan',
      'iconBgColor': progressState == 'upload bukti pengerjaan'
          ? Pallete.main
          : Pallete.dark4
    };

    if (progressState == 'menunggu verifikasi') {
      content['title'] = 'Bukti telah diunggah';
      content['subTitle'] = 'Bukti sedang diproses oleh\nadmin.';
      content['iconBgColor'] = Pallete.main;
    } else if (progressState == 'Bukti tidak jelas' ||
        progressState == 'Bukti kurang lengkap' ||
        progressState == 'Tidak ada detail kejadian') {
      content['title'] = 'Bukti ditolak';
      content['subTitle'] = 'Tolong unggah ulang bukti\nanda.';
      content['iconBgColor'] = Pallete.errorSubtle;
    } else if (progressState == 'disetujui') {
      content['title'] = 'Bukti terverifikasi';
      content['subTitle'] = 'Bukti kamu sudah cukup\nkuat.';
      content['iconBgColor'] = Pallete.main;
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            ProgressCard(
              title: titleStage,
              subTitle: descriptionStage,
              backgroundColor:
                  progressState == 'Aktif' ? Colors.white : Pallete.mainSubtle,
            ),
            const SizedBox(
              height: 24,
            ),
            ProgressCard(
              title: determineSecondStepContent(progressState)['title'] ?? '',
              subTitle:
                  determineSecondStepContent(progressState)['subTitle'] ?? '',
              backgroundColor: progressState == 'disetujui' ||
                      progressState == 'menunggu verifikasi'
                  ? Pallete.mainSubtle
                  : Colors.white,
              isRejected: determineSecondStepContent(progressState)['title'] ==
                  'Bukti ditolak',
              missionId: missionId,
              transactionId: transactionId,
              statusApproval: statusApproval,
            ),
            const SizedBox(
              height: 24,
            ),
            ProgressCard(
              title: 'Yay! Tantangan selesai.',
              subTitle:
                  'Hadiah kamu sudah dikirim nih,\nCek notifikasi kamu sekarang!',
              backgroundColor: progressState == 'disetujui'
                  ? Pallete.mainSubtle
                  : Colors.white,
            ),
          ],
        ),
        Positioned(
          left: 24,
          top: 36,
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: progressState == 'Aktif'
                          ? Pallete.dark4
                          : Pallete.main,
                      width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: progressState == 'Aktif'
                    ? const SizedBox()
                    : const Icon(
                        Icons.check,
                        color: Pallete.main,
                        size: 20,
                      ),
              ),
              DottedLine(
                dashColor: progressState == 'upload bukti pengerjaan' ||
                        progressState == 'menunggu verifikasi' ||
                        progressState == 'disetujui' ||
                        determineSecondStepContent(progressState)['title'] ==
                            'Bukti ditolak'
                    ? Pallete.main
                    : Pallete.dark4,
                lineThickness: 3,
                lineLength: 94,
                dashLength: 6,
                dashGapLength: 8,
                direction: Axis.vertical,
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color:
                      determineSecondStepContent(progressState)['iconBgColor'],
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(
                  IconlyLight.camera,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              DottedLine(
                dashColor:
                    progressState == 'disetujui' ? Pallete.main : Pallete.dark4,
                lineThickness: 3,
                lineLength: 94,
                dashLength: 6,
                dashGapLength: 8,
                direction: Axis.vertical,
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: progressState == 'disetujui'
                          ? Pallete.main
                          : Pallete.dark4,
                      width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  IconlyBold.ticket_star,
                  size: 20,
                  color: progressState == 'disetujui'
                      ? Pallete.errorSubtle
                      : Pallete.dark4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
