part of 'get_history_report_by_id_cubit.dart';

sealed class GetHistoryReportByIdState extends Equatable {
  const GetHistoryReportByIdState();

  @override
  List<Object> get props => [];
}

final class GetHistoryReportByIdInitial extends GetHistoryReportByIdState {}

final class GetHistoryReportByIdLoading extends GetHistoryReportByIdState {}

final class GetHistoryReportByIdSuccess extends GetHistoryReportByIdState {
  final ReportModel data;

  const GetHistoryReportByIdSuccess({required this.data});
}

final class GetHistoryReportByIdFailure extends GetHistoryReportByIdState {
  final String message;

  const GetHistoryReportByIdFailure({required this.message});
}
