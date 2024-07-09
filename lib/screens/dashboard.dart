import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/article/page/dashboard_screen.dart';
import 'package:recything_mobile/screens/home/pages/home_screen.dart';
import 'package:recything_mobile/screens/missions/missions_screen.dart';
import 'package:recything_mobile/screens/komunitas/komunitas_screen.dart';
import 'package:recything_mobile/screens/report/choose_report_screen.dart';

class Dasboard extends StatefulWidget {
  final int? index;
  const Dasboard({super.key, this.index});

  @override
  State<Dasboard> createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  int currenIndex = 0;
  List bodyScreen = [
    const HomeScreen(),
    const ArticleDashboardScreen(),
    const ChooseReportScreen(),
    const MissionsScreen(
      isMissionImageUploaded: false,
    ),
    const KomunitasScreen(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      currenIndex = widget.index!;
      bodyScreen[3] = const MissionsScreen(
        isMissionImageUploaded: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bodyScreen[currenIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
            color: Pallete.textMainButton, shape: BoxShape.circle),
        padding: const EdgeInsets.all(6),
        child: FloatingActionButton(
          heroTag: "reportFab",
          backgroundColor: Pallete.main,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          onPressed: () {
            setState(() {
              currenIndex = 2;
            });
          },
          child: Image.asset(
            "assets/icons/report.png",
            width: 24,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Pallete.textMainButton,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            color: Pallete.dark3, // Warna teks label saat terpilih
          ),
          unselectedLabelStyle: const TextStyle(
            color: Pallete.dark3, // Warna teks label saat tidak terpilih
          ),
          onTap: (value) {
            setState(() {
              currenIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                currenIndex == 0
                    ? "assets/icons/bold_beranda.png"
                    : "assets/icons/home.png",
                width: 24,
                // color: currenIndex == 0 ? Pallete.main : Pallete.dark3,
              ),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currenIndex == 1
                    ? "assets/icons/bold_daur_ulang.png"
                    : "assets/icons/daur_ulang.png",
                width: 24,
                //  color: currenIndex == 1 ? Pallete.main : Pallete.dark3,
              ),
              label: "Daur Ulang",
            ),
            const BottomNavigationBarItem(
              icon: SizedBox(),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currenIndex == 3
                    ? "assets/icons/bold_mission.png"
                    : "assets/icons/mission.png",
                width: 24,
                //   color: currenIndex == 2 ? Pallete.main : Pallete.dark3,
              ),
              label: "Mission",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currenIndex == 4
                    ? "assets/icons/bold_komunitas.png"
                    : "assets/icons/komunitas.png",
                width: 24,
              ),
              label: "komunitas",
            ),
          ]),
    );
  }
}
