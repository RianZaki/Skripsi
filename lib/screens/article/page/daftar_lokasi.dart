import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_all_drop_point/get_all_drop_point_cubit.dart';
import 'package:recything_mobile/screens/article/widget/daftar_lokasi/list_lokasi.dart';
import 'package:recything_mobile/screens/article/widget/header_page.dart';
import 'package:recything_mobile/screens/article/widget/searchbar.dart';

class DaftarLokasiScreen extends StatefulWidget {
  const DaftarLokasiScreen({super.key});

  @override
  State<DaftarLokasiScreen> createState() => _DaftarLokasiScreenState();
}

class _DaftarLokasiScreenState extends State<DaftarLokasiScreen> {
  final ScrollController _scrollController = ScrollController();
  String searchLokasi = "";

  void initState() {
    super.initState();
    context.read<GetAllDropPointCubit>().fetchData(context: context, page: 1);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom()) {
      // Fetch more data when the user reaches the end of the list
      context.read<GetAllDropPointCubit>().fetchData(
            context: context,
            page: context.read<GetAllDropPointCubit>().currentPage + 1,
          );
    }
  }

  bool _isBottom() {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GetAllDropPointCubit>()
              .fetchData(context: context, page: 1);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 66),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      HeaderPageWidget(title: 'Daftar Lokasi'),
                      SizedBox(height: 24),
                      SearchBarWidget(
                        onChanged: (value) {
                          searchLokasi = value;
                          setState(() {});
                          // context.read<GetAllDropPointCubit>().fetchData(
                          //       context: context,
                          //       page: null,
                          //       search: value,
                          //     );
                        },
                        onTap: () {},
                        readOnly: false,
                        focusNode: null,
                        searchTap: () {
                          context.read<GetAllDropPointCubit>().fetchData(
                                context: context,
                                page: null,
                                search: searchLokasi,
                              );
                        },
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:
                      BlocBuilder<GetAllDropPointCubit, GetAllDropPointState>(
                    builder: (context, state) {
                      if (state is GetAllDropPointLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is GetAllDropPointFailure) {
                        return Center(child: Text('Error: ${state.msg}'));
                      } else if (state is GetAllDropPointSuccess) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.zero,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  if (state.data.isEmpty) {
                                    return Center(
                                      child: Text('Belum ada drop points'),
                                    );
                                  }
                                  if (index < state.data.length) {
                                    return ListLokasiWidget(
                                      no: index,
                                      item: state.data[index],
                                    );
                                  } else {
                                    Timer(Duration(milliseconds: 30), () {
                                      _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent);
                                    });
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                }));
                      }
                      return SizedBox();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
