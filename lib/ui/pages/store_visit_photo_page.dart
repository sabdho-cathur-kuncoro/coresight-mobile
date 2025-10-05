import 'dart:io';
import 'package:coresight/utils/add_watermark.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/header.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreVisitPhotoPage extends StatefulWidget {
  const StoreVisitPhotoPage({super.key});

  @override
  State<StoreVisitPhotoPage> createState() => _StoreVisitPhotoPageState();
}

class _StoreVisitPhotoPageState extends State<StoreVisitPhotoPage> {
  late dynamic location;
  late int type;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    location = args['location'];
    type = args['type'];
  }

  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: lightBackgroundColor,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<String> _mirrorImage(String path) async {
    final originalBytes = await File(path).readAsBytes();
    final decoded = img.decodeImage(originalBytes)!;

    // Flip horizontally
    final flipped = img.flipHorizontal(decoded);

    final newPath = path.replaceAll('.jpg', '_flipped.jpg');
    await File(newPath).writeAsBytes(img.encodeJpg(flipped));
    return newPath;
  }

  Future<void> _takePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      final mirroredPath = await _mirrorImage(image.path);

      final String formattedDate = DateFormat(
        'dd-MM-yy HH:mm:ss',
      ).format(DateTime.now());
      final watermark =
          '${type == 1 ? 'Check In' : 'Check Out'}\n$formattedDate\nJohn Doe\nLat:${location.latitude}, Lon:${location.longitude}';

      final watermarkedPath = await addWatermark(
        photoPath: mirroredPath,
        watermarkText: watermark,
      );

      if (!mounted) return;

      // TODO: Save image, apply watermark, etc.
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("Photo saved at: $mirroredPath")));

      Navigator.pushNamed(
        context,
        '/store-visit-preview',
        arguments: {
          'photoPath': watermarkedPath,
          'location': location,
          'type': type,
        },
      );
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Store Visit ${type == 1 ? 'Check In' : 'Check Out'}',
        bgColor: lightBackgroundColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: lightBackgroundColor,
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Positioned.fill(child: CameraPreview(_controller!)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: GestureDetector(
                            onTap: _takePhoto,
                            child: Container(
                              width: 64,
                              height: 64,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                              ),
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/icons/ic_camera.png',
                                  width: 32,
                                  height: 32,
                                  color: blackColor,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
