part of 'get_report_history_cubit.dart';

sealed class GetReportHistoryState extends Equatable {
  const GetReportHistoryState();

  @override
  List<Object> get props => [];
}

final class GetReportHistoryInitial extends GetReportHistoryState {}

final class GetReportHistoryLoading extends GetReportHistoryState {}

final class GetReportHistorySuccess extends GetReportHistoryState {
  final List<ReportModel> data;

  const GetReportHistorySuccess({required this.data});
}

final class GetReportHistoryFailure extends GetReportHistoryState {
  final String message;

  const GetReportHistoryFailure({required this.message});
}
