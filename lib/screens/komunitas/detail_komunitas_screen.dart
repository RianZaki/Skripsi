import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_all_event/get_all_event_cubit.dart';
import 'package:recything_mobile/bloc/get_community_by_id/community_by_id_cubit.dart';
import 'package:recything_mobile/bloc/get_community_by_id/community_by_id_state.dart';
import 'package:recything_mobile/bloc/join_community/join_community_cubit.dart';
import 'package:recything_mobile/bloc/join_community/join_community_state.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/berhasil_bergabung_screen.dart';
import 'package:recything_mobile/screens/komunitas/widgets/komunitas_event_card.dart';
import 'package:recything_mobile/widgets/badges.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class DetailKomunitasScreen extends StatefulWidget {
  final String id;
  const DetailKomunitasScreen({
    required this.id,
    super.key,
  });

  @override
  State<DetailKomunitasScreen> createState() => _DetailKomunitasScreenState();
}

class _DetailKomunitasScreenState extends State<DetailKomunitasScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<CommunityByIdCubit>().getCommunityById(id: widget.id);
    context.read<GetAllEventCubit>().fetchData(id: widget.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 32, bottom: 8),
        width: MediaQuery.of(context).size.width,
        height: 64,
        child: Row(
          children: [
            Expanded(
              child: BlocListener<JoinCommunityCubit, JoinCommunityState>(
                listener: (context, state) {
                  if (state is JoinCommunitySuccess) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BerhasilBergabungScreen(),
                      ),
                    );
                  }
                },
                child: MainButton(
                  onPressed: () {
                    context
                        .read<JoinCommunityCubit>()
                        .joinCommunity(id: widget.id);
                  },
                  child: BlocBuilder<JoinCommunityCubit, JoinCommunityState>(
                    builder: (context, state) {
                      if (state is JoinCommunityLoading) {
                        return SizedBox(
                          height: 23,
                          width: 23,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return Text(
                          "Ikuti Komunitas",
                          style: ThemeFont.heading6Reguler
                              .copyWith(color: Colors.white),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    Text(
                      "Detail Komunitas",
                      style: ThemeFont.heading6Reguler,
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<CommunityByIdCubit, CommunityByIdState>(
                builder: (context, state) {
                  if (state is CommunityByIdLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CommunityByIdSuccess) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                state.community.image ??
                                    "https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 240,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.community.name ?? "Untitled",
                                style: ThemeFont.heading5Reguler,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBadge(
                                      text: state.community.location ?? "?"),
                                  MainSubtleBadge(text: "Telah Bergabung"),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 112,
                                    child: AvatarStack(
                                      height: 40,
                                      avatars: [
                                        for (var n = 0; n < 4; n++)
                                          NetworkImage(
                                              'https://i.pravatar.cc/150?img=$n'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${state.community.maxMembers ?? "?"} Peserta",
                                    style: ThemeFont.bodySmall
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(
                                color: Pallete.dark4,
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 40,
                                child: TabBar(
                                  controller: _tabController,
                                  labelColor: Pallete.main,
                                  labelStyle: ThemeFont.bodySmallMedium,
                                  unselectedLabelColor: Pallete.dark3,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  dividerColor: Pallete.light4,
                                  indicatorWeight: 1.2,
                                  indicatorColor: Pallete.main,
                                  onTap: (value) =>
                                      _pageController.animateToPage(
                                    value,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  ),
                                  tabs: const [
                                    Tab(
                                      text: 'Detail',
                                    ),
                                    Tab(
                                      text: 'Event',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  state.community.description ??
                                      "No description",
                                  style: ThemeFont.bodySmall.copyWith(
                                    height: 1.6,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: BlocBuilder<GetAllEventCubit,
                                    GetAllEventState>(
                                  builder: (context, state) {
                                    if (state is GetAllEventFailure) {
                                      return Text(state.msg);
                                    } else if (state is GetAllEventLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is GetAllEventSuccess) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.data.length,
                                        itemBuilder: (context, index) {
                                          return KomunitasEventCard(
                                              item: state.data[index]);
                                        },
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
