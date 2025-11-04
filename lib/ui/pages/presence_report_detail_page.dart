import 'dart:convert';
import 'dart:typed_data';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:coresight/blocs/presence_detail/presence_detail_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PresenceReportDetailPage extends StatefulWidget {
  const PresenceReportDetailPage({super.key});

  @override
  State<PresenceReportDetailPage> createState() =>
      _PresenceReportDetailPageState();
}

class _PresenceReportDetailPageState extends State<PresenceReportDetailPage> {
  GoogleMapController? _mapController;
  String? date;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      date = args['date'];

      context.read<PresenceDetailBloc>().add(PresenceDetailFetch(date: date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Presence Report Detail',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<PresenceDetailBloc, PresenceDetailState>(
        listener: (context, state) {
          if (state is PresenceDetailFailed) {
            GlobalToast.showError(state.e);
          }
        },
        builder: (context, state) {
          if (state is PresenceDetailLoaded) {
            final incomingUrlPhoto = state.data.incomingUrlPhoto;
            final repeatUrlPhoto = state.data.repeatUrlPhoto;
            final clockInTime = state.data.incomingAttendance != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(state.data.incomingAttendance!))
                : '--:--';
            final clockOutTime = state.data.repeatAttendance != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(state.data.repeatAttendance!))
                : '--:--';
            final clockInLat = state.data.incomingLatitude;
            final clockInLng = state.data.incomingLongitude;
            final clockOutLat = state.data.repeatLatitude;
            final clockOutLng = state.data.repeatLongitude;
            LatLng? clockInLocation;
            if (clockInLat != null && clockInLng != null) {
              clockInLocation = LatLng(clockInLat, clockInLng);
            }

            LatLng? clockOutLocation;
            if (clockOutLat != null && clockOutLng != null) {
              clockOutLocation = LatLng(clockOutLat, clockOutLng);
            }

            // Collect markers
            final Set<Marker> markers = {};
            if (clockInLocation != null) {
              markers.add(
                Marker(
                  markerId: const MarkerId("clockIn"),
                  position: clockInLocation,
                  infoWindow: const InfoWindow(title: "Clock In Location"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
              );
            }
            if (clockOutLocation != null) {
              markers.add(
                Marker(
                  markerId: const MarkerId("clockOut"),
                  position: clockOutLocation,
                  infoWindow: const InfoWindow(title: "Clock Out Location"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              );
            }

            // Default map center
            final LatLng initialPosition =
                clockInLocation ?? clockOutLocation ?? const LatLng(0, 0);
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 50,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: strokeColor),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            state.data.salesName ?? '',
                            style: blackTextStyle.copyWith(
                              fontSize: h4,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.data.createdDate ?? '',
                          style: blackTextStyle.copyWith(fontSize: h6),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    Divider(color: strokeColor),
                    SizedBox(height: 16),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: subtleGreyColor,
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Clock In
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Clock In", style: blackTextStyle),
                              const SizedBox(height: 8),
                              Text(
                                clockInTime,
                                style: blackTextStyle.copyWith(
                                  fontSize: h4,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),

                          // Clock Out
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Clock Out", style: blackTextStyle),
                              const SizedBox(height: 8),
                              Text(
                                clockOutTime,
                                style: blackTextStyle.copyWith(
                                  fontSize: h4,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Photo
                    Text(
                      "Photo",
                      style: blackTextStyle.copyWith(
                        fontSize: h4,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 250,
                          decoration: BoxDecoration(),
                          child: _buildPhoto(incomingUrlPhoto),
                        ),
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(),
                          child: _buildPhoto(repeatUrlPhoto),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Map
                    Text(
                      "Location",
                      style: blackTextStyle.copyWith(
                        fontSize: h4,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: initialPosition,
                            zoom: 15,
                          ),
                          markers: markers,
                          onMapCreated: (controller) {
                            _mapController = controller;
                            if (markers.isNotEmpty) {
                              _fitMarkers(markers);
                            }
                          },
                          zoomControlsEnabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  void _fitMarkers(Set<Marker> markers) async {
    if (_mapController == null || markers.isEmpty) return;

    LatLngBounds bounds;
    if (markers.length == 1) {
      final pos = markers.first.position;
      bounds = LatLngBounds(southwest: pos, northeast: pos);
    } else {
      final latitudes = markers.map((m) => m.position.latitude).toList();
      final longitudes = markers.map((m) => m.position.longitude).toList();

      final southwest = LatLng(
        latitudes.reduce((a, b) => a < b ? a : b),
        longitudes.reduce((a, b) => a < b ? a : b),
      );
      final northeast = LatLng(
        latitudes.reduce((a, b) => a > b ? a : b),
        longitudes.reduce((a, b) => a > b ? a : b),
      );
      bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    }

    await Future.delayed(const Duration(milliseconds: 300)); // wait for render
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50), // padding
    );
  }

  Widget _buildPhoto(String? path) {
    // If the path is null or empty → show placeholder
    if (path == null || path.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.white,
          size: 40,
        ),
      );
    }

    try {
      // Clean base64 string if it contains a prefix
      final String cleanedBase64 = path.contains(',')
          ? path.split(',')[1]
          : path;

      // Decode the base64 safely
      final Uint8List bytes = base64Decode(cleanedBase64);

      // Display image
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.broken_image,
                color: whiteColor,
                size: 40,
              ),
            );
          },
        ),
      );
    } catch (e) {
      return Container(
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.broken_image, color: whiteColor, size: 40),
      );
    }
  }
}
