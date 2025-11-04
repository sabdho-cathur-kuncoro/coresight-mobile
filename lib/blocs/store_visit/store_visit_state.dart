part of 'store_visit_bloc.dart';

sealed class StoreVisitState extends Equatable {
  const StoreVisitState();

  @override
  List<Object> get props => [];
}

final class StoreVisitInitial extends StoreVisitState {}

final class StoreVisitLoading extends StoreVisitState {}

final class StoreVisitFailed extends StoreVisitState {
  final String e;
  const StoreVisitFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class StoreVisitSuccess extends StoreVisitState {
  final String msg;
  const StoreVisitSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

final class StoreLoaded extends StoreVisitState {
  final List<RegionStoreModel> data;
  const StoreLoaded(this.data);

  @override
  List<Object> get props => [data];
}
