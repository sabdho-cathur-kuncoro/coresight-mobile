part of 'presence_detail_bloc.dart';

sealed class PresenceDetailState extends Equatable {
  const PresenceDetailState();

  @override
  List<Object> get props => [];
}

final class PresenceDetailLoading extends PresenceDetailState {}

final class PresenceDetailInitial extends PresenceDetailState {}

final class PresenceDetailFailed extends PresenceDetailState {
  final String e;
  const PresenceDetailFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class PresenceDetailLoaded extends PresenceDetailState {
  final PresenceModel data;
  const PresenceDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class PresenceSuccess extends PresenceDetailState {
  final String msg;
  const PresenceSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}
