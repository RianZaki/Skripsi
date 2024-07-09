import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_lencana/get_lencana_cubit.dart';
import 'package:recything_mobile/bloc/get_user_profile/get_user_profile_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/dashboard.dart';
import 'package:recything_mobile/screens/home/widgets/profile_informasi_akun.dart';
import 'package:recything_mobile/screens/home/widgets/profile_informasi_lainnya.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserProfileCubit>().fetchMe(context);
    context.read<GetLencanaCubit>().fetchLencana(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dasboard()));
          },
        ),
        backgroundColor: Pallete.textMainButton,
        centerTitle: true,
        title: Text(
          "Profil",
          style: ThemeFont.interText
              .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile Pengguna",
                style: ThemeFont.interText
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
            BlocBuilder<GetUserProfileCubit, GetUserProfileState>(
              builder: (context, state) {
                if (state is GetUserProfileLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GetUserProfilefailure) {
                  return Text(state.message);
                } else if (state is GetUserProfileSuccess) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 69, 196, 169)),
                            child: Text(
                              state.data.fullname.characters.first,
                              style: ThemeFont.interText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Pallete.textMainButton),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data.fullname,
                                style: ThemeFont.interText.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                state.data.email,
                                style: ThemeFont.interText
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                      ProfileInformasiAkun(
                        user: state.data,
                      )
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            const ProfileInformasiLainnya()
          ],
        ),
      ),
    );
  }
}
