import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final bool isRejected;
  final String? missionId;
  final String? transactionId;
  final String? statusApproval;

  const ProgressCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.backgroundColor,
      this.isRejected = false,
      this.missionId,
      this.transactionId,
      this.statusApproval});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 14, 22, 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: isRejected
            ? Border.all(width: 1, color: Pallete.errorSubtle)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 64,
          ),
          Expanded(
            child: SizedBox(
              height: 73,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ThemeFont.heading6Bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 45,
                    child: SingleChildScrollView(
                      child: Text(
                        subTitle,
                        style: ThemeFont.bodySmallRegular.copyWith(height: 1.7),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          isRejected
              ? SizedBox(
                  width: 34,
                  height: 34,
                  child: CircleAvatar(
                    backgroundColor: Pallete.errorSubtle,
                    child: IconButton(
                        onPressed: () => Navigator.pushNamed(
                                context, '/unggah-bukti',
                                arguments: {
                                  'missionId': missionId ?? '',
                                  'transactionId': transactionId,
                                  'progressState': statusApproval
                                }),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        )),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
