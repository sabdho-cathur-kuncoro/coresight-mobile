import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';

class GlobalLoading {
  static GlobalKey<NavigatorState>? navigatorKey;
  static OverlayEntry? _loader;

  static void show({String? message}) {
    if (_loader != null) return;

    final overlayState = navigatorKey?.currentState?.overlay;

    if (overlayState == null) {
      debugPrint('⚠️ GlobalLoading: Overlay not ready yet');
      return;
    }

    _loader = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Container(color: Colors.black38),
          Center(child: CircularProgressIndicator(color: whiteColor)),
        ],
      ),
    );

    overlayState.insert(_loader!);
  }

  static void hide() {
    try {
      _loader?.remove();
    } catch (_) {}
    _loader = null;
  }
}
