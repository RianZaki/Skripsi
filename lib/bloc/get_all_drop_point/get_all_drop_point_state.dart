part of 'get_all_drop_point_cubit.dart';

sealed class GetAllDropPointState extends Equatable {
  const GetAllDropPointState();

  @override
  List<Object> get props => [];
}

final class GetAllDropPointInitial extends GetAllDropPointState {}

final class GetAllDropPointLoading extends GetAllDropPointState {}

final class GetAllDropPointSuccess extends GetAllDropPointState {
  final List<DropPointsModel> data;
  final bool isInitial;

  GetAllDropPointSuccess({
    required this.data,
    this.isInitial = false,
  });
}

final class GetAllDropPointFailure extends GetAllDropPointState {
  final String msg;

  GetAllDropPointFailure({required this.msg});
}