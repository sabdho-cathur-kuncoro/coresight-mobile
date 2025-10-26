part of 'presence_bloc.dart';

sealed class PresenceEvent extends Equatable {
  const PresenceEvent();

  @override
  List<Object> get props => [];
}

class PresenceFetch extends PresenceEvent {
  final int month;
  final int year;

  const PresenceFetch({required this.month, required this.year});

  @override
  List<Object> get props => [month, year];
}

class PresenceRequested extends PresenceEvent {
  final String photoPath;
  final LatLng location;
  final int type;

  const PresenceRequested({
    required this.photoPath,
    required this.location,
    required this.type,
  });
}
