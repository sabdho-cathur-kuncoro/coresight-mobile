import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

class GlobalToast {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void show({
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    final colors = _getGradient(type);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastMessage(
        message: message,
        colors: colors,
        icon: _getIcon(type),
        duration: duration,
        onClose: () {
          if (overlayEntry.mounted) {
            overlayEntry.remove();
          }
        },
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  // Wrappers
  static void showSuccess(String message, {Duration? duration}) => show(
    message: message,
    type: ToastType.success,
    duration: duration ?? const Duration(seconds: 3),
  );

  static void showError(String message, {Duration? duration}) => show(
    message: message,
    type: ToastType.error,
    duration: duration ?? const Duration(seconds: 3),
  );

  static void showWarning(String message, {Duration? duration}) => show(
    message: message,
    type: ToastType.warning,
    duration: duration ?? const Duration(seconds: 3),
  );

  static void showInfo(String message, {Duration? duration}) => show(
    message: message,
    type: ToastType.info,
    duration: duration ?? const Duration(seconds: 3),
  );

  // Helpers
  static List<Color> _getGradient(ToastType type) {
    switch (type) {
      case ToastType.success:
        return [greenColor, const Color(0xFF81C784)];
      case ToastType.error:
        return [redColor, const Color(0xFFE57373)];
      case ToastType.warning:
        return [yellowColor, const Color(0xFFFFD54F)];
      case ToastType.info:
        return [blueColor, const Color(0xFF64B5F6)];
    }
  }

  static IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

class _ToastMessage extends StatefulWidget {
  final String message;
  final List<Color> colors;
  final IconData icon;
  final Duration duration;
  final VoidCallback onClose;

  const _ToastMessage({
    required this.message,
    required this.colors,
    required this.icon,
    required this.duration,
    required this.onClose,
  });

  @override
  State<_ToastMessage> createState() => _ToastMessageState();
}

class _ToastMessageState extends State<_ToastMessage>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Trigger fade/slide in
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });

    // Auto close after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() => _visible = false);
        Future.delayed(const Duration(milliseconds: 300), widget.onClose);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _visible ? Offset.zero : const Offset(0, -0.5),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 1 : 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: widget.colors),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(widget.message, style: whiteTextStyle)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
