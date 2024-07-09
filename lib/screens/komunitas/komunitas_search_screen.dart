import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/get_community/community_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/widgets/komunitas_card.dart';
import 'package:recything_mobile/widgets/badges.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';

class KomunitasSearchScreen extends StatefulWidget {
  const KomunitasSearchScreen({super.key});

  @override
  State<KomunitasSearchScreen> createState() => _KomunitasSearchScreenState();
}

class _KomunitasSearchScreenState extends State<KomunitasSearchScreen> {
  final searchController = TextEditingController();

  final List<String> kota = ["Jakarta", "Bandung", "Surabaya", "Tangerang"];

  @override
  void initState() {
    super.initState();
    // context.read<CommunityCubit>().getCommunity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    Text(
                      "Cari Komunitas",
                      style: ThemeFont.heading6Reguler,
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),
              const SizedBox(height: 24),
              MainTextField(
                label: "Cari Komunitas disini...",
                prefixIcon: IconlyLight.search,
                controller: searchController,
                onSubmitted: (p0) {
                  context
                      .read<CommunityCubit>()
                      .getCommunity(search: searchController.text);
                },
              ),
              const SizedBox(height: 16),
              // DropdownButton(
              //   isDense: true,
              //   value: "Berdasarkan Lokasi",
              //   icon: const Padding(
              //     padding: EdgeInsets.only(left: 8),
              //     child: Icon(IconlyLight.arrow_down_2),
              //   ),
              //   underline: const SizedBox(),
              //   items: [
              //     DropdownMenuItem(
              //       value: "Berdasarkan Lokasi",
              //       child: Text(
              //         "Berdasarkan Lokasi",
              //         style: ThemeFont.bodySmallMedium,
              //       ),
              //     ),
              //     DropdownMenuItem(
              //       value: "Anggota Terbanyak",
              //       child: Text(
              //         "Anggota Terbanyak",
              //         style: ThemeFont.bodySmallMedium,
              //       ),
              //     ),
              //   ],
              //   onChanged: (value) {},
              // ),
              // const SizedBox(height: 16),
              Text("Rekomendasi Kota", style: ThemeFont.bodySmallMedium),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: List<Widget>.generate(
                  kota.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                        onTap: () {
                          searchController.text = kota[index];
                          context
                              .read<CommunityCubit>()
                              .getCommunity(search: searchController.text);
                        },
                        child: CustomBadge(text: kota[index])),
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              // const Divider(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Row(
              //     children: [
              //       const SizedBox(width: 10),
              //       const Icon(IconlyLight.location),
              //       const SizedBox(width: 10),
              //       Text(
              //         "Jakarta Barat, DKI Jakarta",
              //         style: ThemeFont.bodySmallMedium,
              //       ),
              //     ],
              //   ),
              // ),
              // const Divider(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Row(
              //     children: [
              //       const SizedBox(width: 10),
              //       const Icon(IconlyLight.location),
              //       const SizedBox(width: 10),
              //       Text(
              //         "Jakarta Barat, DKI Jakarta",
              //         style: ThemeFont.bodySmallMedium,
              //       ),
              //     ],
              //   ),
              // ),
              // const Divider(),
              SizedBox(height: 24),
              Column(
                children: [
                  BlocBuilder<CommunityCubit, CommunityState>(
                    builder: (context, state) {
                      if (state is CommunitySuccess) {
                        if (state.communities.length <= 0 &&
                            searchController.text.isNotEmpty) {
                          return Center(
                              child: Image.asset(
                                  "assets/images/empty_komunitas_search.png"));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.communities.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return KomunitasCard(
                              id: state.communities[index].id ?? "-",
                              title:
                                  state.communities[index].name ?? "Untitled",
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
            ],
          ),
        ),
      ),
    );
  }
}
