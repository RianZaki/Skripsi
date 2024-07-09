import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/widgets/forms/error_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class BackAlert {
  static Future<bool> showAlert(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          contentPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Yakin untuk Kembali?",
                style: ThemeFont.heading5Bold,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Tinggal Selangkah lagi untuk memulihkan Kata Sandi anda. Kembali akan mengulangi proses recovery.",
                textAlign: TextAlign.center,
                style: ThemeFont.bodyNormalReguler
                    .copyWith(fontSize: 16, color: Pallete.textSecondary),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Batal",
                        style: ThemeFont.bodySmallSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ErrorButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/login",
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Kembali",
                        style: ThemeFont.bodySmallSemiBold
                            .copyWith(color: Pallete.error),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return false;
  }
}
