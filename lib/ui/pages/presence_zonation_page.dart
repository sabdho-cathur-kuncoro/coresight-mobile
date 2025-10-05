import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PresenceZonationPage extends StatefulWidget {
  const PresenceZonationPage({super.key});

  @override
  State<PresenceZonationPage> createState() => _PresenceZonationPageState();
}

class _PresenceZonationPageState extends State<PresenceZonationPage> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  bool _isLoading = true;
  late int type;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    type = args['type'];
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final latLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLatLng = latLng;
      _isLoading = false;
    });

    if (_mapController != null) {
      _moveCamera(latLng);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentLatLng != null) {
      _moveCamera(_currentLatLng!);
    }
  }

  void _moveCamera(LatLng target) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 17.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: type == 1 ? 'Clock In' : 'Clock Out',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng ?? const LatLng(0, 0),
              zoom: _currentLatLng == null ? 2.0 : 17.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/presence-photo',
                    arguments: {'location': _currentLatLng, 'type': type},
                  );
                },
                text: 'Next',
                bgColor: primaryColor,
                styleText: whiteTextStyle.copyWith(
                  fontSize: h4,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: blackColor.withValues(alpha: 0.3), // dim background a bit
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
