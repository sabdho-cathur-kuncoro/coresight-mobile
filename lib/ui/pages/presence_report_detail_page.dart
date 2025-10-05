import 'dart:io';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PresenceReportDetailPage extends StatefulWidget {
  const PresenceReportDetailPage({super.key});

  @override
  State<PresenceReportDetailPage> createState() =>
      _PresenceReportDetailPageState();
}

class _PresenceReportDetailPageState extends State<PresenceReportDetailPage> {
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    // 👇 Get arguments from Navigator
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String employeeName = args['employeeName'] ?? '';
    final String date = args['date'] ?? '';
    final String clockInTime = args['clockInTime'] ?? '';
    final String clockOutTime = args['clockOutTime'] ?? '';
    final String clockInPhoto = args['clockInPhoto'] ?? '';
    final String clockOutPhoto = args['clockOutPhoto'] ?? '';
    final LatLng? clockInLocation = args['clockInLocation'];
    final LatLng? clockOutLocation = args['clockOutLocation'];

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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    // Default center for map → use clockIn first, else clockOut, else 0,0
    final LatLng initialPosition =
        clockInLocation ?? clockOutLocation ?? const LatLng(0, 0);

    return Scaffold(
      appBar: Header(
        title: 'Presence Report Detail',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employee info
            Text(
              employeeName,
              style: blackTextStyle.copyWith(
                fontSize: h4,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 4),
            Text(date, style: greyTextStyle.copyWith(fontSize: h6)),
            const SizedBox(height: 20),

            // Clock In
            Text("Clock In", style: blackTextStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildPhoto(clockInPhoto),
                const SizedBox(width: 16),
                Text(clockInTime, style: blackTextStyle.copyWith(fontSize: h4)),
              ],
            ),
            const SizedBox(height: 20),

            // Clock Out
            Text("Clock Out", style: blackTextStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildPhoto(clockOutPhoto),
                const SizedBox(width: 16),
                Text(
                  clockOutTime,
                  style: blackTextStyle.copyWith(fontSize: h4),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Map
            Text("Location", style: blackTextStyle),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
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

  Widget _buildPhoto(String path) {
    if (path.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.white),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(File(path), width: 80, height: 80, fit: BoxFit.cover),
    );
  }
}
