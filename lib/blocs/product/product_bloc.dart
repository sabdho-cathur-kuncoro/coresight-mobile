import 'package:coresight/models/product_model.dart';
import 'package:coresight/services/global_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // final FlutterSecureStorage storage = const FlutterSecureStorage();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductFetch) {
        try {
          emit(ProductLoading());
          final dataProduct = await GlobalService().getProduct();
          emit(ProductLoaded(dataProduct));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      }
    });
  }
}
