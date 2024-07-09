import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/auth/auth_cubit.dart';
import 'package:recything_mobile/screens/dashboard.dart';
import 'package:recything_mobile/screens/splash/splash_screen.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is AuthUnAuthenticated) {
        return const SplashScreen();
      } else if (state is AuthAuthenticated) {
        return const Dasboard();
      }
      return const SizedBox();
    }));
  }
}
