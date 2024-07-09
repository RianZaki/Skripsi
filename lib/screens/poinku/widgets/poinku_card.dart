import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_poin_daily/get_poin_daily_cubit.dart';
import 'package:recything_mobile/bloc/get_user_profile/get_user_profile_cubit.dart';
import 'package:recything_mobile/bloc/post_poin_daily/post_poin_daily_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/poinku/pages/poinku_screen.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';

class PoinkuCard extends StatefulWidget {
  const PoinkuCard({
    super.key,
  });

  @override
  State<PoinkuCard> createState() => _PoinkuCardState();
}

class _PoinkuCardState extends State<PoinkuCard> {
  double dividerWidth = 0;
  int clickCount = 0;
  void initState() {
    super.initState();
    context.read<GetUserProfileCubit>().fetchMe(context);
    context.read<GetPoinDailyCubit>().fetchDailyPoin(context);
  }

  void _onTukarPoinClicked(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 0,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Selamat",
                    style: ThemeFont.heading3Bold
                        .copyWith(color: Pallete.secondary),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        message,
                        style: ThemeFont.bodyMediumBold
                            .copyWith(color: Pallete.dark1),
                      )),
                  // RichText(
                  //     text: TextSpan(
                  //         text: "Kamu dapat ",
                  //         style: ThemeFont.bodyMediumBold
                  //             .copyWith(color: Pallete.dark1),
                  //         children: [
                  //       TextSpan(
                  //           text: "150 ",
                  //           style: ThemeFont.bodyMediumBold
                  //               .copyWith(color: Pallete.secondary)),
                  //       TextSpan(
                  //           text: "Koin! ",
                  //           style: ThemeFont.bodyMediumBold
                  //               .copyWith(color: Pallete.dark1)),
                  //     ])),

                  // RichText(
                  //     text: TextSpan(
                  //         text: "Kumpulkan ",
                  //         style: ThemeFont.bodySmallRegular
                  //             .copyWith(color: Pallete.dark1),
                  //         children: [
                  //       TextSpan(
                  //           text: "5 ",
                  //           style: ThemeFont.bodySmallRegular
                  //               .copyWith(color: Pallete.secondary)),
                  //       TextSpan(
                  //           text: "Hari lagi dapatkan ",
                  //           style: ThemeFont.bodySmallRegular
                  //               .copyWith(color: Pallete.dark1)),
                  //       TextSpan(
                  //           text: "1750 ",
                  //           style: ThemeFont.bodySmallRegular
                  //               .copyWith(color: Pallete.secondary)),
                  //       TextSpan(
                  //           text: "Koin ",
                  //           style: ThemeFont.bodySmallRegular
                  //               .copyWith(color: Pallete.dark1)),
                  //     ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      "assets/images/koin.png",
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MainButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Oke",
                          style: ThemeFont.bodySmallSemiBold
                              .copyWith(color: Pallete.textMainButton),
                        )),
                  )
                ],
              ),
            ));
  }

  void _onTukarPoinFailure(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 0,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Maaf",
                    style:
                        ThemeFont.heading3Bold.copyWith(color: Pallete.error),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        textAlign: TextAlign.center,
                        message,
                        style: ThemeFont.bodyMediumBold
                            .copyWith(color: Pallete.dark1),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MainButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PoinkuScreen()));
                        },
                        child: Text(
                          "Oke",
                          style: ThemeFont.bodySmallSemiBold
                              .copyWith(color: Pallete.textMainButton),
                        )),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostPoinDailyCubit, PostPoinDailyState>(
      listener: (context, state) {
        if (state is PostPoinDailyFailure) {
          _onTukarPoinFailure(
              "Kamu sudah claim point' hari ini, Tunggu besok untuk claim selanjutnya");
        } else if (state is PostPoinDailySuccess) {
          _onTukarPoinClicked(state.message);
        }
      },
      child: BlocBuilder<GetUserProfileCubit, GetUserProfileState>(
        builder: (context, state) {
          if (state is GetUserProfileLoading) {
            return CircularProgressIndicator();
          } else if (state is GetUserProfilefailure) {
            return Text(state.message);
          } else if (state is GetUserProfileSuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.92,
              decoration: BoxDecoration(
                  color: Pallete.textMainButton,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 10,
                        color: Pallete.dark1.withOpacity(0.15))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Point",
                    style: ThemeFont.interText.copyWith(
                        fontWeight: FontWeight.w600, color: Pallete.dark1),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.data.point.toString(),
                    style: ThemeFont.interText
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<GetPoinDailyCubit, GetPoinDailyState>(
                    builder: (context, state) {
                      if (state is GetPoinDailyLoading) {
                        return CircularProgressIndicator();
                      } else if (state is GetPoinDailyFailure) {
                        return Text(state.msg);
                      } else if (state is GetPoinDailySuccess) {
                        return Stack(
                          children: [
                            Positioned(
                              top: 13,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Divider(
                                  thickness: 4,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 13,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    (state.data.length > 0
                                        ? state.data.length * 0.115
                                        : 0),
                                child: const Divider(
                                  thickness: 4,
                                  color: Pallete.warning,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 22,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: state.data.length > index
                                              ? Pallete.warning
                                              : Pallete.dark3),
                                      child: state.data.length > index
                                          ? const Icon(
                                              Icons.check,
                                              color: Pallete.textMainButton,
                                              size: 22,
                                            )
                                          : Text(
                                              "${10 * (index + 1)}",
                                              style: ThemeFont.interText
                                                  .copyWith(
                                                      color: Pallete
                                                          .textMainButton),
                                            ),
                                    ),
                                    Text(
                                      "Hari ${index + 1}",
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MainButton(
                          onPressed: () {
                            context
                                .read<PostPoinDailyCubit>()
                                .claimPoin(context: context);
                          },
                          child: Text(
                            "Kumpulkan",
                            style: ThemeFont.heading6Reguler.copyWith(
                                color: Pallete.textMainButton,
                                fontWeight: FontWeight.w700),
                          )))
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
