import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/get_report_hisstory/get_report_history_cubit.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/widgets/riwayat_kosong_card.dart';
import 'package:recything_mobile/screens/riwayat_pelaporan/widgets/riwayat_pelaporan_card.dart';

class RiwayatPelaporanScreen extends StatefulWidget {
  const RiwayatPelaporanScreen({super.key});

  @override
  State<RiwayatPelaporanScreen> createState() => _RiwayatPelaporanScreenState();
}

class _RiwayatPelaporanScreenState extends State<RiwayatPelaporanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetReportHistoryCubit>().fetchReportHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReportHistoryCubit, GetReportHistoryState>(
      builder: (context, state) {
        if (state is GetReportHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetReportHistoryFailure) {
          return Text(state.message);
        } else if (state is GetReportHistorySuccess) {
          if (state.data.isEmpty) {
            return const RiwayatKosongCard();
          }
          return ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: state.data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RiwayatPelaporanCard(item: state.data[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
