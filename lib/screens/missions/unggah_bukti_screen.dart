import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/upload_proof/upload_proof_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/custom_leading_app_bar.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

class UnggahBuktiScreen extends StatefulWidget {
  const UnggahBuktiScreen({super.key});

  @override
  State<UnggahBuktiScreen> createState() => _UnggahBuktiScreenState();
}

class _UnggahBuktiScreenState extends State<UnggahBuktiScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<UploadProofCubit>().resetState();
    super.initState();
  }

  Widget determineErrorImage(String statusApproval) {
    if (statusApproval == 'Bukti tidak jelas') {
      return Image.asset(
        'assets/images/mission-ditolak-buktitidakjelas.png',
        fit: BoxFit.cover,
      );
    } else if (statusApproval == 'Bukti kurang lengkap') {
      return Image.asset('assets/images/mission-ditolak-buktikuranglengkap.png',
          fit: BoxFit.cover);
    } else if (statusApproval == 'Tidak ada detail kejadian') {
      return Image.asset(
          'assets/images/mission-ditolak-tidakadadetailkejadian.png',
          fit: BoxFit.cover);
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomLeadingAppBar(title: 'Unggah Bukti'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Column(
              children: [
                BlocListener<UploadProofCubit, UploadProofState>(
                  listener: (context, state) {
                    if (state is UploadProofToServerSuccess) {
                      SuccessSnackbar.showSnackbar(context,
                          title: "Berhasil mengirim bukti",
                          message: "Bukti kamu sudah diunggah",
                          isTopSnackbar: false);
                      Navigator.pushNamedAndRemoveUntil(context,
                          '/dashboard-mission', ModalRoute.withName('/'));
                    } else if (state is UploadProofToServerFailed) {
                      ErrorSnackbar.showSnackbar(context,
                          title: "Gagal mengirim bukti",
                          message: state.errorMsg,
                          isTopSnackbar: false);
                      Navigator.pop(context);
                    } else if (state is UpdateProofToServerSuccess) {
                      SuccessSnackbar.showSnackbar(context,
                          title: "Berhasil perbarui bukti",
                          message: state.successMsg,
                          isTopSnackbar: false);
                      Navigator.pushNamedAndRemoveUntil(context,
                          '/dashboard-mission', ModalRoute.withName('/'));
                    } else if (state is UpdateProofToServerFailed) {
                      ErrorSnackbar.showSnackbar(context,
                          title: "Gagal memperbarui bukti",
                          message: state.errorMsg,
                          isTopSnackbar: false);
                      Navigator.pop(context);
                    }
                  },
                  child: SizedBox(),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Yuk, sertakan bukti\npengerjaan tantangan kamu.',
                  style: ThemeFont.bodyNormalReguler,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<UploadProofCubit, UploadProofState>(
                  builder: (context, state) {
                    if (state is UploadProofSuccess &&
                        state.images.isNotEmpty) {
                      return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 14, crossAxisCount: 3),
                          itemCount: state.images.length + 1,
                          itemBuilder: (context, index) {
                            return index >= state.images.length
                                ? GestureDetector(
                                    onTap: () => context
                                        .read<UploadProofCubit>()
                                        .selectImages(),
                                    child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Pallete.dark4, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Center(
                                          child: const Icon(
                                            Icons.add,
                                            color: Pallete.dark4,
                                          ),
                                        )),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Image.file(
                                          File(state.images[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                            onPressed: () => context
                                                .read<UploadProofCubit>()
                                                .deleteImage(index: index),
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Pallete.dark2
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                          });
                    }

                    return GestureDetector(
                      onTap: () =>
                          context.read<UploadProofCubit>().selectImages(),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Pallete.main, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconlyLight.upload,
                              color: Pallete.mainDarker,
                            ),
                            Text(
                              'Unggah',
                              style: ThemeFont.bodyNormalReguler.copyWith(
                                  fontSize: 10, color: Pallete.mainDarker),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<UploadProofCubit, UploadProofState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        state is UploadProofSuccess && state.images.isNotEmpty
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Format file: JPG, PNG',
                                  style: ThemeFont.bodySmallRegular
                                      .copyWith(color: Pallete.dark3),
                                ),
                              )
                            : Text(
                                'Format file: JPG, PNG',
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Pallete.dark3),
                              ),
                        const SizedBox(
                          height: 4,
                        ),
                        state is UploadProofSuccess && state.images.isNotEmpty
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Maksimum file : 20 Mb',
                                  style: ThemeFont.bodySmallRegular
                                      .copyWith(color: Pallete.dark3),
                                ),
                              )
                            : Text(
                                'Maksimum file : 20 Mb',
                                style: ThemeFont.bodySmallRegular
                                    .copyWith(color: Pallete.dark3),
                              ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keterangan (Opsional)',
                    style: ThemeFont.bodyNormalReguler.copyWith(height: 1.7),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText:
                          'Cth: Saya telah membuang sampah yang ada di rumah saya dan sekitar jalan pada tempatnya',
                      hintStyle:
                          ThemeFont.bodySmallMedium.copyWith(height: 1.7),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
                const SizedBox(
                  height: 24,
                ),
                args['progressState'] != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child:
                                  determineErrorImage(args['progressState'])),
                        ],
                      )
                    : const SizedBox(
                        height: 164,
                      ),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<UploadProofCubit, UploadProofState>(
          builder: (context, state) {
            return MainButton(
                onPressed: state is UploadProofSuccess &&
                            state.images.isNotEmpty ||
                        state is UploadProofToServerLoading
                    ? () async {
                        if (await context
                            .read<UploadProofCubit>()
                            .isImageSizeValidated()) {
                          if (args['transactionId'] != null) {
                            await context.read<UploadProofCubit>().updateProof(
                                description: descriptionController.text,
                                transactionId: args['transactionId']);
                          } else {
                            context.read<UploadProofCubit>().uploadProof(
                                missionId: args['missionId'],
                                description: descriptionController.text);
                          }
                        }
                      }
                    : null,
                child: state is UploadProofToServerLoading
                    ? SizedBox(
                        width: 23,
                        height: 23,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Kirim',
                        style: ThemeFont.heading6Bold
                            .copyWith(color: Colors.white),
                      ));
          },
        ),
      ),
    );
  }
}
