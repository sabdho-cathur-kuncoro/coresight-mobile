import 'package:coresight/models/dashboard_model.dart';
import 'package:coresight/services/dashboard_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardFetch) {
        try {
          final dashboard = await DashboardService().loadDashboard();
          emit(DashboardLoaded(dashboard: dashboard));
        } catch (e) {
          emit(DashboardFailed(e.toString()));
        }
      }
    });
  }
}
