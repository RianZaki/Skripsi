import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/register/register_cubit.dart';
import 'package:recything_mobile/bloc/register/register_state.dart';
import 'package:recything_mobile/widgets/error_snackbar.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';
import 'package:recything_mobile/widgets/typography/body_link.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/pallete.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPwd = false;
  bool showPwd2 = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? password2Error;

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse(
        'https://www.privacypolicyonline.com/live.php?token=da9bTUJMHIcsJ92ml8FwaD3uZrRqlMEp'));

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Daftar",
                    style: ThemeFont.heading3Reguler,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 242,
                    child: Text(
                      "Buat akun Anda sekarang dan mulailah menjelajah",
                      style: ThemeFont.bodyNormal
                          .copyWith(color: Pallete.textSecondary),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MainTextField(
                    controller: nameController,
                    label: "Masukan Nama Lengkap",
                    prefixIcon: IconlyLight.profile,
                    errorText: nameError,
                  ),
                  const SizedBox(height: 12),
                  MainTextField(
                    controller: emailController,
                    label: "Masukan Email",
                    prefixIcon: IconlyLight.message,
                    errorText: emailError,
                  ),
                  const SizedBox(height: 12),
                  MainTextField(
                    controller: passwordController,
                    label: "Masukan Kata Sandi",
                    prefixIcon: IconlyLight.lock,
                    obscureText: !showPwd,
                    errorText: passwordError,
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
                    errorText: password2Error,
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
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "Dengan mendaftar, Anda menyetujui ",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: ThemeFont.bodySmall
                              .copyWith(color: Pallete.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () {
                            showPrivacyPolicy();
                          },
                          child: Text(
                            "Ketentuan Layanan ",
                            style: ThemeFont.bodySmall.copyWith(
                              color: Pallete.main,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "dan ",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: ThemeFont.bodySmall
                              .copyWith(color: Pallete.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () {
                            showPrivacyPolicy();
                          },
                          child: Text(
                            " Kebijakan Privasi",
                            style: ThemeFont.bodySmall.copyWith(
                              color: Pallete.main,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: BlocListener<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterFailed) {
                              ErrorSnackbar.showSnackbar(
                                context,
                                title: "Oops, Akun Tidak Valid",
                                message: state.message,
                              );
                            }
                            if (state is RegisterSuccess) {
                              SuccessSnackbar.showSnackbar(
                                context,
                                title: "Registrasi berhasil!",
                                message:
                                    "Silahkan cek email anda untuk verifikasi akun.",
                              );
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login", (route) => false);
                            }
                          },
                          child: MainButton(
                            child: BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                if (state is RegisterLoading) {
                                  return const SizedBox(
                                    height: 23,
                                    width: 23,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Register",
                                    style: ThemeFont.heading6Reguler.copyWith(
                                      color: Pallete.textMainButton,
                                    ),
                                  );
                                }
                              },
                            ),
                            onPressed: () {
                              if (validate()) {
                                return;
                              }
                              context.read<RegisterCubit>().register(
                                    fullname: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword: password2Controller.text,
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
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: GoogleButton(
                  //       text: "Daftar Dengan Google",
                  //       onPressed: () {},
                  //     )),
                  //   ],
                  // ),
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah Punya Akun? ",
                        style: ThemeFont.bodyNormal
                            .copyWith(color: Pallete.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/login",
                          (route) => false,
                        ),
                        child: const BodyLink("Login"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    bool isError = false;
    setState(() {
      nameError = null;
      emailError = null;
      passwordError = null;
      password2Error = null;
      if (nameController.text == "") {
        nameError = "Nama Tidak Boleh Kosong";
        isError = true;
      }
      if (emailController.text == "") {
        emailError = "Email Tidak Boleh Kosong";
        isError = true;
      }
      if (passwordController.text == "") {
        passwordError = "Password Tidak Boleh Kosong";
        isError = true;
      }
      if (password2Controller.text == "") {
        password2Error = "Password Tidak Boleh Kosong";
        isError = true;
      }
    });
    return isError;
  }

  void showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Pallete.dark4,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 14),
                child: Row(
                  children: [
                    CustomBackButton(),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                height: MediaQuery.of(context).size.height * 50 / 100,
                child: WebViewWidget(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}
