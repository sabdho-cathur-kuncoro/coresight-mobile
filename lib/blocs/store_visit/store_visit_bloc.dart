import 'package:coresight/models/region_store_model.dart';
import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/services/store_visit_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'store_visit_event.dart';
part 'store_visit_state.dart';

class StoreVisitBloc extends Bloc<StoreVisitEvent, StoreVisitState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  StoreVisitBloc() : super(StoreVisitInitial()) {
    on<StoreVisitEvent>((event, emit) async {
      if (event is RegionStoreFetch) {
        try {
          emit(StoreVisitLoading());
          final String? salesId = await storage.read(key: 'sales_id');
          final dataStore = await StoreVisitService().getStores(salesId!);
          emit(StoreLoaded(dataStore));
        } catch (e) {
          emit(StoreVisitFailed(e.toString()));
        }
      }
      if (event is StoreVisitRequested) {
        try {
          emit(StoreVisitLoading());
          final data = StoreVisitModel(
            salesId: event.salesId,
            storeId: event.storeId,
            filePhotoFile: event.filePhotoFile,
            createdBy: event.username,
          );
          final msg = await StoreVisitService().storeVisit(data);
          emit(StoreVisitSuccess(msg));
        } catch (e) {
          emit(StoreVisitFailed(e.toString()));
        }
      }
    });
  }
}
