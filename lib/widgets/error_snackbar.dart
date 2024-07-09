import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recything_mobile/constants/pallete.dart';

class ErrorSnackbar {
  static void showSnackbar(context,
      {required String message,
      required String title,
      bool isTopSnackbar = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        clipBehavior: Clip.none,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        // width: MediaQuery.of(context).size.width,
        elevation: 0,
        margin: isTopSnackbar
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 250,
                left: 10,
                right: 10)
            : EdgeInsets.zero,
        content: Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: Pallete.errorLigther,
            boxShadow: [
              BoxShadow(
                color: Pallete.error.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -8,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                20,
                              ),
                            ),
                          ),
                          child: SvgPicture.asset("assets/images/snack_e1.svg"),
                        ),
                      ),
                      Positioned(
                        bottom: 56,
                        left: 20,
                        child: SvgPicture.asset("assets/images/snack_e2.svg"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: ThemeFont.heading5Bold,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeFont.bodySmallRegular
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
