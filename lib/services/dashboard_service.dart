import 'package:coresight/models/dashboard_model.dart';
import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/models/today_activity_model.dart';
import 'package:coresight/repositories/dashboard_repositories.dart';
import 'package:dio/dio.dart';

class DashboardService {
  Future<DashboardModel> loadDashboard() async {
    try {
      final results = await Future.wait([
        DashboardRepositories().fetchAttendanceSummary(),
        DashboardRepositories().fetchTodayActivities(),
        DashboardRepositories().fetchStoreVisitMonthly(),
      ]);

      final attendanceData = results[0] as Map<String, dynamic>;
      final todayActivities = results[1] as TodayActivitiesModel;
      final storeVisitMonthly = results[2] as StoreVisitModel;

      final dashboard = DashboardModel(
        incomingAttendance: attendanceData['incoming_attendance'],
        repeatAttendance: attendanceData['repeat_attendance'],
        todayActivities: todayActivities,
        storeVisitMonthly: storeVisitMonthly,
      );

      return dashboard;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed fetch data');
    }
  }
}
