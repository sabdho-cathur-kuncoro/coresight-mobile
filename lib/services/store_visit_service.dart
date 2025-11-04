import 'package:coresight/config/api_config.dart';
import 'package:coresight/models/region_store_model.dart';
import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/services/auth_service.dart';
import 'package:dio/dio.dart';

class StoreVisitService {
  Future<String> storeVisit(StoreVisitModel data) async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.post(
        'store-visit/visit',
        data: data.toJson(),
      );

      if (res.statusCode == 200) {
        return res.data['message'];
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Store Visit failed');
    }
  }
  Future<List<RegionStoreModel>> getStores(String salesId) async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.get(
        'store/region-store/$salesId',
      );
      if (res.statusCode == 200) {
        final data = res.data;

        if (data != null && data['result'] != null) {
          final List result = data['result'];
          return result
              .map((store) => RegionStoreModel.fromJson(store))
              .toList();
        } else {
          throw Exception('No result found in response');
        }
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Region store failed');
    }
  }
}
