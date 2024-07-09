import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_state.dart';
import 'package:recything_mobile/screens/password_baru/back_alert.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

import '../../constants/pallete.dart';

class VerifikasiOtpScreen extends StatefulWidget {
  const VerifikasiOtpScreen({super.key});

  @override
  State<VerifikasiOtpScreen> createState() => _VerifikasiOtpScreenState();
}

class _VerifikasiOtpScreenState extends State<VerifikasiOtpScreen> {
  final OtpFieldController otpController = OtpFieldController();
  String otp = "";

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
                  "Verifikasi OTP",
                  style: ThemeFont.heading3Reguler,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 310,
                  child: Text(
                    "Masukan OTP untuk verifikasi pemulihan",
                    style: ThemeFont.bodyNormal
                        .copyWith(color: Pallete.textSecondary),
                  ),
                ),
                const SizedBox(height: 24),
                OTPTextField(
                  controller: otpController,
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 70,
                  fieldStyle: FieldStyle.box,
                  keyboardType: TextInputType.text,
                  outlineBorderRadius: 15,
                  otpFieldStyle:
                      OtpFieldStyle(enabledBorderColor: Pallete.dark3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  style: const TextStyle(fontSize: 22),
                  onChanged: (pin) {
                    otp = pin.toUpperCase();
                    // otpController.set(otp.padRight(4).substring(0, 4).split(""));
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Tidak menerima kode? ",
                      style: ThemeFont.bodySmall
                          .copyWith(color: Pallete.textSecondary),
                    ),
                    BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is SendOTPSuccess) {
                          SuccessSnackbar.showSnackbar(
                            context,
                            title: "OTP terkirim!",
                            message:
                                "Silahkan cek email anda untuk verifikasi OTP.",
                          );
                          // Navigator.pushNamed(context, '/verifikasi_otp');
                        }
                        if (state is SendOTPFailed) {
                          ErrorSnackbar.showSnackbar(
                            context,
                            title: "OTP gagal terkirim",
                            message: state.message,
                          );
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          String email =
                              context.read<ForgotPasswordCubit>().getEmail();
                          context
                              .read<ForgotPasswordCubit>()
                              .sendOTP(email: email);
                        },
                        child: Text(
                          "Kirim Ulang",
                          style: ThemeFont.bodySmall.copyWith(
                            color: Pallete.main,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: BlocListener<ForgotPasswordCubit,
                          ForgotPasswordState>(
                        listener: (context, state) {
                          if (state is VerifyOTPFailed) {
                            ErrorSnackbar.showSnackbar(
                              context,
                              title: "Verifikasi gagal",
                              message: state.message,
                            );
                          }
                          if (state is VerifyOTPSuccess) {
                            Navigator.pushNamed(context, '/password_baru');
                          }
                        },
                        child: BlocBuilder<ForgotPasswordCubit,
                            ForgotPasswordState>(
                          builder: (context, state) {
                            return MainButton(
                              child: Text(
                                "Konfirmasi",
                                style: ThemeFont.heading6Reguler.copyWith(
                                  color: Pallete.textMainButton,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ForgotPasswordCubit>()
                                    .verifyOTP(otp: otp);
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
