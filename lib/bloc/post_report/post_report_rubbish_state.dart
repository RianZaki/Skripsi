import 'package:equatable/equatable.dart';

class PostReportRubbishState extends Equatable {
  const PostReportRubbishState();
  @override
  List<Object> get props => [];
}

class PostReportRubbishInitial extends PostReportRubbishState {}

class PostReportRubbishLoading extends PostReportRubbishState {}

class PostReportRubbishSuccess extends PostReportRubbishState {}

class PostReportRubbishFailed extends PostReportRubbishState {
  final String message;

  PostReportRubbishFailed({required this.message});
}

class PostReportRubbishCheckboxUpdated extends PostReportRubbishState {}
