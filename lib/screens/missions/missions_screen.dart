import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/missions/widgets/custom_app_bar.dart';
import 'package:recything_mobile/screens/missions/widgets/tab_berjalan.dart';
import 'package:recything_mobile/screens/missions/widgets/tab_selesai.dart';
import 'package:recything_mobile/screens/missions/widgets/tab_tersedia.dart';

class MissionsScreen extends StatefulWidget {
  final bool? isMissionImageUploaded;

  const MissionsScreen({super.key, this.isMissionImageUploaded});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: widget.isMissionImageUploaded ?? false ? 1 : 0,
        length: 3,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.light4,
      appBar: const CustomAppBar(),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          child: TabBar(
              controller: _tabController,
              labelColor: Pallete.main,
              labelStyle: ThemeFont.bodySmallMedium,
              unselectedLabelColor: Pallete.dark3,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
              dividerColor: Pallete.light4,
              indicatorWeight: 1.2,
              indicatorColor: Pallete.main,
              tabs: const [
                Tab(
                  text: 'Tersedia',
                ),
                Tab(
                  text: 'Berjalan',
                ),
                Tab(
                  text: 'Selesai',
                ),
              ]),
        ),
        Expanded(
            child: TabBarView(controller: _tabController, children: [
          TabTersedia(),
          TabBerjalan(),
          TabSelesai(),
        ]))
      ]),
    );
  }
}
