import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class BerhasilBergabungScreen extends StatelessWidget {
  const BerhasilBergabungScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Row(
                children: [
                  CustomBackButton(),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Image.asset("assets/images/success.png"),
              Text(
                "Berhasil Bergabung",
                style: ThemeFont.heading3Reguler,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 310,
                child: Text(
                  '"Selamat! Anda telah resmi menjadi bagian dari Zero Waste Indonesia Community."',
                  style: ThemeFont.bodyNormal
                      .copyWith(color: Pallete.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 16,
              ),
              const Expanded(child: SizedBox()),
              const SizedBox(
                height: 24,
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Lihat Komunitas",
                        style: ThemeFont.bodyNormal.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
