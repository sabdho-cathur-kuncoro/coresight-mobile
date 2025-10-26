part of 'presence_detail_bloc.dart';

sealed class PresenceDetailEvent extends Equatable {
  const PresenceDetailEvent();

  @override
  List<Object> get props => [];
}

class PresenceDetailFetch extends PresenceDetailEvent {
  final String? date;

  const PresenceDetailFetch({required this.date});

  @override
  List<Object> get props => [?date];
}
