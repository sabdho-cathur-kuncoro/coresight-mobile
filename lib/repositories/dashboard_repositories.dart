import 'package:coresight/config/api_config.dart';
import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/models/today_activity_model.dart';
import 'package:coresight/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DashboardRepositories {
  final AuthService _authService;
  final FlutterSecureStorage _storage;

  DashboardRepositories({
    AuthService? authService,
    FlutterSecureStorage? storage,
  }) : _authService = authService ?? AuthService(),
       _storage = storage ?? const FlutterSecureStorage();

  Future<Dio> _getDioWithToken() async {
    final token = await _authService.getToken();
    return ApiService.withToken(token);
  }

  Future<String?> _getSalesId() async {
    return _storage.read(key: 'sales_id');
  }

  Future<Map<String, dynamic>> fetchAttendanceSummary() async {
    final salesId = await _getSalesId();
    final dio = await _getDioWithToken();
    final res = await dio.get('/dashboard/attendance/$salesId');
    final data = res.data['result'][0];
    // print('API ATTENDANCE $data');
    return data;
  }

  Future<TodayActivitiesModel> fetchTodayActivities() async {
    final salesId = await _getSalesId();
    final dio = await _getDioWithToken();
    final res = await dio.get('/dashboard/today-activities/$salesId');
    final data = res.data['result'][0];
    // print('API ACTIVITIES $data');
    return TodayActivitiesModel.fromJson(data);
  }

  Future<StoreVisitModel> fetchStoreVisitMonthly() async {
    final salesId = await _getSalesId();
    final dio = await _getDioWithToken();
    final res = await dio.get('/dashboard/store-visit-monthly/$salesId');
    final data = res.data['result'][0];
    // print('API STORE VISIT $data');
    return StoreVisitModel.fromJson(data);
  }
}
