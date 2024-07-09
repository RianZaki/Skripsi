import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:recything_mobile/dynamic_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
    // DynamicLink().initDynamicLinks();
  }

  Future<void> redirect() async {
    final pref = await SharedPreferences.getInstance();
    bool onboarding = pref.getBool('onboarding') ?? false;
    String route = "/onboarding";
    if (onboarding) {
      route = "/login";
    }
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: SvgPicture.asset("assets/images/logo1.svg")),
    );
  }
}
