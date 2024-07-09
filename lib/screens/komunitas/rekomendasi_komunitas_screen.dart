import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_community/community_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/komunitas/widgets/komunitas_card.dart';

class RekomendasiKomunitasScreen extends StatefulWidget {
  const RekomendasiKomunitasScreen({super.key});

  @override
  State<RekomendasiKomunitasScreen> createState() =>
      _RekomendasiKomunitasScreenState();
}

class _RekomendasiKomunitasScreenState
    extends State<RekomendasiKomunitasScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().getCommunity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rekomendasi',
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
