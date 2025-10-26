part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final DashboardModel dashboard;
  const DashboardLoaded({required this.dashboard});

  @override
  List<Object> get props => [dashboard];
}

final class DashboardFailed extends DashboardState {
  final String e;
  const DashboardFailed(this.e);

  @override
  List<Object> get props => [e];
}
