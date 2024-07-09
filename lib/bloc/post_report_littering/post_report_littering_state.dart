import 'package:equatable/equatable.dart';

class PostReportLitteringState extends Equatable {
  const PostReportLitteringState();
  @override
  List<Object> get props => [];
}

class PostReportLitteringInitial extends PostReportLitteringState {}

class PostReportLitteringLoading extends PostReportLitteringState {}

class PostReportLitteringSuccess extends PostReportLitteringState {}

class PostReportLitteringFailed extends PostReportLitteringState {
  final String message;

  PostReportLitteringFailed({required this.message});
}

class PostReportLitteringCheckboxUpdated extends PostReportLitteringState {}
