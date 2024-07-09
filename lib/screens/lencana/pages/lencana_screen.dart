import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_lencana/get_lencana_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/lencana/pages/lencana_bronze_screen.dart';
import 'package:recything_mobile/screens/lencana/pages/lencana_gold_screen.dart';
import 'package:recything_mobile/screens/lencana/pages/lencana_platinum_screen.dart';
import 'package:recything_mobile/screens/lencana/pages/lencana_silver_screen.dart';

import 'package:recything_mobile/widgets/forms/custom_back_button.dart';

class LencanaScreen extends StatefulWidget {
  final UserModel user;
  const LencanaScreen({super.key, required this.user});

  @override
  State<LencanaScreen> createState() => _LencanaScreenState();
}

class _LencanaScreenState extends State<LencanaScreen> {
  void initState() {
    super.initState();
    context.read<GetLencanaCubit>().fetchLencana(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLencanaCubit, GetLencanaState>(
      builder: (context, state) {
        if (state is GetLencanaLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetLencanaFailure) {
          return Scaffold(
            body: Text(state.msg),
          );
        } else if (state is GetLencanaSuccess) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Pallete.textMainButton,
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: CustomBackButton(),
                  ),
                  title: Text(
                    "Lencana",
                    style: ThemeFont.heading6Medium,
                  ),
                  bottom: const TabBar(
                      indicatorColor: Pallete.main,
                      labelColor: Pallete.main,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(text: "Bronze"),
                        Tab(text: "Silver"),
                        Tab(text: "Gold"),
                        Tab(text: "Platinum")
                      ]),
                ),
                body: TabBarView(
                  children: [
                    LencanaBronzeScreen(
                      data: state.data
                          .where((element) => element.name == "bronze")
                          .toList()
                          .first,
                      user: widget.user,
                    ),
                    LencanaSilverScreen(
                      data: state.data
                          .where((element) => element.name == "silver")
                          .toList()
                          .first,
                      user: widget.user,
                    ),
                    LencanaGoldScreen(
                      data: state.data
                          .where((element) => element.name == "gold")
                          .toList()
                          .first,
                      user: widget.user,
                    ),
                    LencanaPlatinumScreen(
                      data: state.data
                          .where((element) => element.name == "platinum")
                          .toList()
                          .first,
                      user: widget.user,
                    )
                  ],
                )),
          );
        }
        return SizedBox();
      },
    );
  }
}
