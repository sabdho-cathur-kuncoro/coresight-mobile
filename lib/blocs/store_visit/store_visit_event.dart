part of 'store_visit_bloc.dart';

sealed class StoreVisitEvent extends Equatable {
  const StoreVisitEvent();

  @override
  List<Object> get props => [];
}

class RegionStoreFetch extends StoreVisitEvent {
  const RegionStoreFetch();

  @override
  List<Object> get props => [];
}

class StoreVisitRequested extends StoreVisitEvent {
  final String salesId;
  final String storeId;
  final String username;
  final String filePhotoFile;
  final dynamic type;

  const StoreVisitRequested({
    required this.salesId,
    required this.storeId,
    required this.username,
    required this.filePhotoFile,
    required this.type,
  });
}
