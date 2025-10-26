import 'package:coresight/models/presence_model.dart';
import 'package:coresight/services/presence_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'presence_detail_event.dart';
part 'presence_detail_state.dart';

class PresenceDetailBloc
    extends Bloc<PresenceDetailEvent, PresenceDetailState> {
  PresenceDetailBloc() : super(PresenceDetailInitial()) {
    on<PresenceDetailEvent>((event, emit) async {
      if (event is PresenceDetailFetch) {
        try {
          emit(PresenceDetailLoading());
          final detailPresence = await PresenceService().getReportDetail(
            event.date ?? '',
          );
          emit(PresenceDetailLoaded(detailPresence));
        } catch (e) {
          emit(PresenceDetailFailed(e.toString()));
        }
      }
    });
  }
}
