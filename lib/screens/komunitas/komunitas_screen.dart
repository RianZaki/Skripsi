import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/get_community/community_cubit.dart';
import 'package:recything_mobile/bloc/get_user_profile/get_user_profile_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/komunitas_search_screen.dart';
import 'package:recything_mobile/screens/komunitas/widgets/komunitas_card.dart';
import 'package:recything_mobile/screens/komunitas/widgets/lokasi_dropdown.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';
import 'package:recything_mobile/widgets/typography/body_link.dart';

class KomunitasScreen extends StatefulWidget {
  const KomunitasScreen({super.key});

  @override
  State<KomunitasScreen> createState() => _KomunitasScreenState();
}

class _KomunitasScreenState extends State<KomunitasScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().getCommunity();
    context.read<GetUserProfileCubit>().fetchMe(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const LokasiDropdown(),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const KomunitasSearchScreen(),
                  ));
                },
                child: const MainTextField(
                  enable: false,
                  label: "Cari Komunitas disini...",
                  prefixIcon: IconlyLight.search,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "Komunitas Saya",
                    style: ThemeFont.heading6Reguler
                        .copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 24),
              BlocBuilder<GetUserProfileCubit, GetUserProfileState>(
                  builder: (context, state) {
                if (state is GetUserProfileLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetUserProfilefailure) {
                  return Text(state.message);
                } else if (state is GetUserProfileSuccess) {
                  if (state.data.communities!.isEmpty)
                    return Center(
                        child:
                            Image.asset("assets/images/empty_komunitas.png"));
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.data.communities!.length,
                      itemBuilder: (context, index) {
                        return KomunitasCard(
                          id: state.data.communities?[index].id ?? "-",
                          title:
                              state.data.communities?[index].name ?? "Untitled",
                          lokasi:
                              state.data.communities?[index].location ?? "?",
                          anggota: "0",
                          image: state.data.communities?[index].image ??
                              "https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg",
                        );
                      });
                }
                return SizedBox();
              }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rekomendasi Komunitas",
                    style: ThemeFont.heading6Reguler
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed("/semua-komunitas"),
                    child: const BodyLink("Lihat Semua"),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              BlocBuilder<CommunityCubit, CommunityState>(
                builder: (context, state) {
                  if (state is CommunitySuccess) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: state.communities.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return KomunitasCard(
                          id: state.communities[index].id ?? "-",
                          title: state.communities[index].name ?? "Untitled",
                          lokasi: state.communities[index].location ?? "?",
                          anggota: "0",
                          image: state.communities[index].image ??
                              "https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg",
                        );
                      },
                    );
                  }
                  if (state is CommunityLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox();
                },
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}
