part of 'presence_bloc.dart';

sealed class PresenceState {}

final class PresenceInitial extends PresenceState {}

final class PresenceLoading extends PresenceState {}

final class PresenceFailed extends PresenceState {
  final String e;
  PresenceFailed(this.e);

  List<Object> get props => [e];
}

final class PresenceLoaded extends PresenceState {
  final List<PresenceModel> data;
  PresenceLoaded(this.data);

  List<Object> get props => [data];
}

final class PresenceSuccess extends PresenceState {
  final String msg;
  PresenceSuccess(this.msg);

  List<Object> get props => [msg];
}
