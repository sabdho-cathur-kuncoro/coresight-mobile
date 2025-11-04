import 'package:coresight/config/api_config.dart';
import 'package:coresight/models/presence_model.dart';
import 'package:coresight/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PresenceService {
  Future<String> clockIn(PresenceModel data) async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.post(
        'attendance/clock-in',
        data: data.toJson(isClockOut: false),
      );

      if (res.statusCode == 200) {
        return res.data['message'];
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Clock in failed');
    }
  }

  Future<String> clockOut(PresenceModel data) async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.post(
        'attendance/clock-out',
        data: data.toJson(isClockOut: true),
      );

      if (res.statusCode == 200) {
        return res.data['message'];
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Clock out failed');
    }
  }

  Future<List<PresenceModel>> getReport(PresenceModel data) async {
    try {
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.get(
        'attendance/attendance-mobile-sales/${data.salesId}/${data.month}/${data.year}',
      );
      if (res.statusCode == 200) {
        final data = res.data;

        if (data != null && data['result'] != null) {
          final List result = data['result'];
          return result
              .map((presence) => PresenceModel.fromJson(presence))
              .toList();
        } else {
          throw Exception('No result found in response');
        }
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Report failed');
    }
  }

  Future<PresenceModel> getReportDetail(String date) async {
    try {
      final storage = FlutterSecureStorage();
      final salesId = await storage.read(key: 'sales_id');
      final token = await AuthService().getToken();
      final Dio dio = ApiService.withToken(token);

      final res = await dio.get(
        'attendance/attendance-sales-date/$salesId/$date',
      );
      if (res.statusCode == 200) {
        final data = res.data;

        if (data != null && data['result'] != null) {
          final List result = data['result'];
          return PresenceModel.fromDetailJson(result[0]);
        } else {
          throw Exception('No result found in response');
        }
      } else {
        throw res.data['message'];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Report Detail failed');
    }
  }
}
