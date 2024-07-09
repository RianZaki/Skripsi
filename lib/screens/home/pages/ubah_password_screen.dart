import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/update_password/update_password_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/password_text_field.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({super.key});

  @override
  State<UbahPasswordScreen> createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? errorText;

  @override
  void initState() {
    context.read<UpdatePasswordCubit>().resetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.textMainButton,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          "Ubah Password",
          style: ThemeFont.heading6Medium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
                listener: (context, state) {
                  if (state is UpdatePasswordSuccess) {
                    SuccessSnackbar.showSnackbar(context,
                        title: "Kata Sandi Diperbarui",
                        message: "Kata Sandi berhasil diubah",
                        isTopSnackbar: false);
                    Navigator.pop(context);
                  } else if (state is UpdatePasswordFailed) {
                    ErrorSnackbar.showSnackbar(context,
                        title: "Gagal Memperbarui",
                        message: state.errorMsg,
                        isTopSnackbar: false);
                  }
                },
                child: SizedBox(),
              ),
            ),
            Text(
              "Kata Sandi Baru",
              style: ThemeFont.heading3Bold,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 28),
              child: Text(
                "Ubah kata sandimu secara berkala untuk menjaga keamanan akun RecyThingmu",
                style: ThemeFont.bodyNormalReguler,
              ),
            ),
            PasswordTextField(
              label: "Masukkan Kata Sandi Sekarang",
              controller: passwordController,
            ),
            BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
              builder: (context, state) {
                if (state is UpdatePasswordIdentical) {
                  return PasswordTextField(
                    label: "Masukkan Kata Sandi Baru",
                    controller: newPasswordController,
                    errorText: state.errorMsg,
                  );
                }

                return PasswordTextField(
                  label: "Masukkan Kata Sandi Baru",
                  controller: newPasswordController,
                );
              },
            ),
            PasswordTextField(
              label: "Konfirmasi Kata Sandi Baru",
              controller: confirmPasswordController,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
                builder: (context, state) {
                  return MainButton(
                      onPressed: () => context
                          .read<UpdatePasswordCubit>()
                          .updatePassword(
                              password: passwordController.text,
                              newPassword: newPasswordController.text,
                              confirmPassword: confirmPasswordController.text),
                      child: state is UpdatePasswordLoading
                          ? SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Simpan",
                              style: ThemeFont.heading6Reguler.copyWith(
                                  color: Pallete.textMainButton,
                                  fontWeight: FontWeight.w700),
                            ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
