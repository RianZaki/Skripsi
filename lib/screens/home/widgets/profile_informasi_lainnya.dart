import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/auth/auth_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInformasiLainnya extends StatelessWidget {
  const ProfileInformasiLainnya({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Informasi Lainnya", style: ThemeFont.bodyNormalSemiBold),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: const Icon(IconlyLight.calling),
            title: Text(
              "Hubungi Kami",
              style: ThemeFont.bodyNormalReguler,
            ),
            trailing: IconButton(
                onPressed: () async {
                  var waUrl = Uri.parse("https://wa.me/6289522933558");
                  launchUrl(waUrl);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Image.asset(
              "assets/icons/profile/mbarecy.png",
              width: 24,
            ),
            title: Text("Tanya Recy", style: ThemeFont.bodyNormalReguler),
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recy');
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Image.asset(
              "assets/icons/profile/pertanyaan.png",
              width: 24,
            ),
            title: Text(
              "Pertanyaan Umum",
              style: ThemeFont.bodyNormalReguler,
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pertanyaanUmum');
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: const Icon(
              IconlyLight.logout,
              color: Pallete.error,
            ),
            title: Text(
              "Keluar",
              style: ThemeFont.bodyNormalReguler.copyWith(color: Pallete.error),
            ),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            elevation: 0,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Apakah Kamu Yakin untuk Keluar?",
                                  style: ThemeFont.interText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: MainButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Batal",
                                              style: ThemeFont.heading6Reguler
                                                  .copyWith(
                                                      color: Pallete
                                                          .textMainButton,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ))),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Pallete.error,
                                            padding: const EdgeInsets.all(16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  8), // Ganti dengan radius yang Anda inginkan
                                            ),
                                            side: const BorderSide(
                                                color: Pallete.error),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .loggedOut();

                                            Navigator.pushNamed(
                                                context, '/index');
                                          },
                                          child: const Text("Keluar")),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Pallete.error,
                )),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
