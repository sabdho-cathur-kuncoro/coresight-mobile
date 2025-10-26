import 'package:coresight/models/store_visit_model.dart';
import 'package:coresight/models/today_activity_model.dart';

class DashboardModel {
  final String? incomingAttendance;
  final String? repeatAttendance;
  final TodayActivitiesModel? todayActivities;
  final StoreVisitModel? storeVisitMonthly;

  DashboardModel({
    this.incomingAttendance,
    this.repeatAttendance,
    this.todayActivities,
    this.storeVisitMonthly,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      incomingAttendance: json['incoming_attendance'],
      repeatAttendance: json['repeat_attendance'],
      todayActivities: json['today_activities'] != null
          ? TodayActivitiesModel.fromJson(
              json['today_activities'] as Map<String, dynamic>,
            )
          : null,
      storeVisitMonthly: json['store_visit_monthly'] != null
          ? StoreVisitModel.fromJson(
              json['store_visit_monthly'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
