import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_state.dart';
import 'package:recything_mobile/screens/password_baru/back_alert.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

import '../../constants/pallete.dart';

class PasswordBaruScreen extends StatefulWidget {
  const PasswordBaruScreen({super.key});

  @override
  State<PasswordBaruScreen> createState() => _PasswordBaruScreenState();
}

class _PasswordBaruScreenState extends State<PasswordBaruScreen> {
  bool showPwd = false;
  bool showPwd2 = false;
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return BackAlert.showAlert(context);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 66),
                CustomBackButton(onPressed: () => BackAlert.showAlert(context)),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Kata Sandi Baru",
                  style: ThemeFont.heading3Reguler,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  // width: 310,
                  child: Wrap(
                    children: [
                      Text(
                        "Langkah terakhir, akun anda ",
                        style: ThemeFont.bodyNormal
                            .copyWith(color: Pallete.textSecondary),
                      ),
                      BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                        builder: (context, state) {
                          return Text(
                            context.read<ForgotPasswordCubit>().getEmail(),
                            style: ThemeFont.bodyNormal
                                .copyWith(color: Pallete.dark1),
                          );
                        },
                      ),
                      Text(
                        " berhasil diverifikasi",
                        style: ThemeFont.bodyNormal
                            .copyWith(color: Pallete.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                MainTextField(
                  controller: passwordController,
                  label: "Masukan Kata Sandi",
                  prefixIcon: IconlyLight.lock,
                  obscureText: !showPwd,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPwd = !showPwd;
                      });
                    },
                    child: Icon(
                      !showPwd ? IconlyLight.show : IconlyLight.hide,
                      color: Pallete.dark3,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                MainTextField(
                  controller: password2Controller,
                  label: "Konfirmasi Kata Sandi",
                  prefixIcon: IconlyLight.lock,
                  obscureText: !showPwd2,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPwd2 = !showPwd2;
                      });
                    },
                    child: Icon(
                      !showPwd2 ? IconlyLight.show : IconlyLight.hide,
                      color: Pallete.dark3,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: BlocListener<ForgotPasswordCubit,
                          ForgotPasswordState>(
                        listener: (context, state) {
                          if (state is NewPasswordSuccess) {
                            SuccessSnackbar.showSnackbar(
                              context,
                              title: "Berhasil!",
                              message: "Password anda sudah diperbarui",
                            );
                            Navigator.pushNamed(context, '/login');
                          }
                          if (state is NewPasswordFailed) {
                            ErrorSnackbar.showSnackbar(
                              context,
                              title: "Format tidak valid",
                              message: state.message,
                            );
                          }
                        },
                        child: BlocBuilder<ForgotPasswordCubit,
                            ForgotPasswordState>(
                          builder: (context, state) {
                            return MainButton(
                              child: Text(
                                "Simpan Password",
                                style: ThemeFont.heading6Reguler.copyWith(
                                  color: Pallete.textMainButton,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                context.read<ForgotPasswordCubit>().newPassword(
                                      password: passwordController.text,
                                      password2: password2Controller.text,
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Expanded(child: SizedBox()),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
