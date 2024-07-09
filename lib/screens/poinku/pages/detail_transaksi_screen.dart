import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_history_poin_by_id/get_history_poin_by_id_cubit.dart';
import 'package:recything_mobile/screens/poinku/widgets/detail_transaksi_card.dart';
import 'package:recything_mobile/screens/poinku/widgets/rincian_transaksi_card.dart';
import 'package:recything_mobile/widgets/forms/custom_app_bar.dart.dart';

class DetailTransaksiScreen extends StatefulWidget {
  final String id;
  const DetailTransaksiScreen({super.key, required this.id});

  @override
  State<DetailTransaksiScreen> createState() => _DetailTransaksiScreenState();
}

class _DetailTransaksiScreenState extends State<DetailTransaksiScreen> {
  void initState() {
    context.read<GetHistoryPoinByIdCubit>().fetchData(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<GetHistoryPoinByIdCubit, GetHistoryPoinByIdState>(
            builder: (context, state) {
      if (state is GetHistoryPoinByIdFailure) {
        return Text(state.msg);
      } else if (state is GetHistoryPoinByIdLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetHistoryPoinByIdSuccess) {
        return Column(children: [
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                CustomAppBar(
                    title: "Detail Transaksi",
                    onTap: () => Navigator.pop(context)),
                Positioned(
                    top: 150,
                    child: DetailTransaksiCard(
                      item: state.data,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              RincianTransaksiCard(
                item: state.data,
              ),
            ],
          )
        ]);
      }
      return SizedBox();
    }));
  }
}
