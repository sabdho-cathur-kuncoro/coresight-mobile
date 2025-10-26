import 'package:coresight/models/presence_model.dart';
import 'package:coresight/services/presence_service.dart';
import 'package:coresight/utils/convert_photo_to_base64.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'presence_event.dart';
part 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  PresenceBloc() : super(PresenceInitial()) {
    on<PresenceEvent>((event, emit) async {
      if (event is PresenceRequested) {
        try {
          emit(PresenceLoading());
          // Get sales ID securely
          final String? salesId = await storage.read(key: 'sales_id');

          // Convert photo to base64
          final base64Photo = convertToBase64(event.photoPath);

          if (event.type == 1) {
            // Build model
            final data = PresenceModel(
              salesId: salesId,
              absentCode: 'P',
              incomingLatitude: event.location.latitude,
              incomingLongitude: event.location.longitude,
              incomingFilePhoto: base64Photo,
              createdBy: salesId,
            );
            final msg = await PresenceService().clockIn(data);
            emit(PresenceSuccess(msg));
          }
          if (event.type == 2) {
            // Build model
            final data = PresenceModel(
              salesId: salesId,
              absentCode: 'P',
              repeatLatitude: event.location.latitude,
              repeatLongitude: event.location.longitude,
              repeatFilePhoto: base64Photo,
              updatedBy: salesId,
            );
            final msg = await PresenceService().clockOut(data);
            emit(PresenceSuccess(msg));
          }
        } catch (e) {
          emit(PresenceFailed(e.toString()));
        }
      }
      if (event is PresenceFetch) {
        try {
          emit(PresenceLoading());
          final String? salesId = await storage.read(key: 'sales_id');
          final data = PresenceModel(
            salesId: salesId,
            month: event.month,
            year: event.year,
          );
          final dataPresence = await PresenceService().getReport(data);
          emit(PresenceLoaded(dataPresence));
        } catch (e) {
          emit(PresenceFailed(e.toString()));
        }
      }
    });
  }
}
