import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_state.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

import '../../constants/pallete.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 66),
              const CustomBackButton(),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Atur Ulang Kata Sandi",
                style: ThemeFont.heading3Reguler,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 310,
                child: Text(
                  "Untuk melakukan pemulihan, Masukan Alamat Email yang terhubung",
                  style: ThemeFont.bodyNormal
                      .copyWith(color: Pallete.textSecondary),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MainTextField(
                controller: emailController,
                label: "Masukan Email Anda",
                prefixIcon: IconlyLight.message,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                    listener: (context, state) {
                      if (state is SendOTPSuccess) {
                        SuccessSnackbar.showSnackbar(
                          context,
                          title: "OTP terkirim!",
                          message:
                              "Silahkan cek email anda untuk verifikasi OTP.",
                        );
                        Navigator.pushNamed(context, '/verifikasi_otp');
                      }
                      if (state is SendOTPFailed) {
                        ErrorSnackbar.showSnackbar(
                          context,
                          title: "OTP gagal terkirim",
                          message: state.message,
                        );
                      }
                    },
                    child:
                        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        return Expanded(
                          child: MainButton(
                            child: Text(
                              "Selanjutnya",
                              style: ThemeFont.heading6Reguler.copyWith(
                                color: Pallete.textMainButton,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () async {
                              await context
                                  .read<ForgotPasswordCubit>()
                                  .sendOTP(email: emailController.text);
                            },
                          ),
                        );
                      },
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
    );
  }
}
