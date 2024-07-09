import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_history_poin/get_history_poin_cubit.dart';
import 'package:recything_mobile/bloc/get_vouchers/get_vouchers_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/get_vouchers_model.dart';
import 'package:recything_mobile/screens/poinku/widgets/poinku_drop_sampah.dart';
import 'package:recything_mobile/screens/poinku/widgets/poinku_hadiah_mission.dart';
import 'package:recything_mobile/screens/poinku/widgets/poinku_tukar_poin.dart';
import 'package:recything_mobile/screens/poinku/widgets/poinku_voucher.dart';

class PoinkuTabar extends StatefulWidget {
  final int userPoint;
  final int? index;
  const PoinkuTabar({super.key, this.index, required this.userPoint});

  @override
  State<PoinkuTabar> createState() => _PoinkuTabarState();
}

class _PoinkuTabarState extends State<PoinkuTabar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollController = ScrollController();
  int currentIndex = 0;

  // List<GetVouchersModel> vouchers = [];
  // bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      currentIndex = widget.index!;
    }
    _tabController =
        TabController(length: 2, initialIndex: currentIndex, vsync: this);
    context.read<GetVouchersCubit>().getVouchers();
    _scrollPagination();
    context.read<GetHistoryPoinCubit>().fetchHistoryPoin(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _scrollPagination() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<GetVouchersCubit>().getVouchers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          TabBar.secondary(
              labelPadding: const EdgeInsets.only(bottom: 8),
              indicatorColor: Pallete.main,
              labelColor: Pallete.main,
              unselectedLabelColor: Pallete.dark3,
              controller: _tabController,
              tabs: [
                Text(
                  "Voucher",
                  style: ThemeFont.interText,
                ),
                Text(
                  "Riwayat",
                  style: ThemeFont.interText,
                )
              ]),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              BlocBuilder<GetVouchersCubit, GetVouchersState>(
                  builder: ((context, state) {
                if (state is GetVouchersLoading && state.isFirstFetch) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Pallete.main,
                  ));
                }

                List<GetVouchersModel> vouchers = [];
                bool isLoadMore = false;

                if (state is GetVouchersLoading) {
                  vouchers = state.oldVouchersData ?? [];
                  isLoadMore = true;
                } else if (state is GetVouchersLoaded) {
                  vouchers = state.vouchers;
                }

                return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(0),
                    itemCount: vouchers.length + (isLoadMore ? 1 : 0),
                    itemBuilder: ((context, index) {
                      if (index < vouchers.length) {
                        final dataIndexed = vouchers[index];
                        return PoinkuVoucher(
                          userPoint: widget.userPoint,
                          imageUrl: dataIndexed.image,
                          voucherTitle: dataIndexed.rewardName,
                          point: dataIndexed.point.toString(),
                          expiredDate: dataIndexed.endDate,
                          description: dataIndexed.description,
                          id: dataIndexed.id,
                        );
                      } else {
                        Timer(Duration(milliseconds: 30), () {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        });

                        return Center(
                          child: CircularProgressIndicator(
                            color: Pallete.main,
                          ),
                        );
                      }
                    }));
              })),
              BlocBuilder<GetHistoryPoinCubit, GetHistoryPoinState>(
                builder: (context, state) {
                  if (state is GetHistoryPoinLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetHistoryPoinFailure) {
                    return Text(state.msg);
                  } else if (state is GetHistoryPoinSuccess) {
                    return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.data.length,
                        itemBuilder: ((context, index) {
                          if (state.data.isEmpty) {
                            return Column(
                              children: [
                                Image.asset(
                                  "assets/images/NoLocationFound.png",
                                  width: 100,
                                ),
                                Text(
                                  "Riwayat masih kosong",
                                  style: ThemeFont.bodyNormal
                                      .copyWith(color: Pallete.dark3),
                                )
                              ],
                            );
                          }
                          if (state.data[index].typeTransaction == "tukar poin")
                            return PoinkuTukarPoin(item: state.data[index]);
                          else if (state.data[index].typeTransaction ==
                              "drop sampah")
                            return PoinkuDropSampah(item: state.data[index]);
                          else if (state.data[index].typeTransaction ==
                              "hadiah mission")
                            return PoinkuHadiahSampah(item: state.data[index]);
                          else
                            return SizedBox();
                        }));
                  }
                  return SizedBox();
                },
              ),
            ],
          ))
        ],
      ),
    );
  }

  // Future<void> _getVouchers() async {
  //   final response = await GetVouchersRepo().getVouchers(page: page.toString());
  //   setState(() {
  //     vouchers = vouchers + response;
  //   });
  // }
}
