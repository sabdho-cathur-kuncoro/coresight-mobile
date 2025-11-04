import 'package:coresight/config/api_config.dart';
import 'package:coresight/models/product_model.dart';
import 'package:coresight/services/auth_service.dart';
import 'package:dio/dio.dart';

class GlobalService {
  Future<List<ProductModel>> getProduct() async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.get('product/get-product');
      if (res.statusCode == 200) {
        final data = res.data;

        if (data != null && data['result'] != null) {
          final List result = data['result'];
          return result
              .map((store) => ProductModel.fromJson(store))
              .toList();
        } else {
          throw Exception('No result found in response');
        }
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Get product failed');
    }
  }
}