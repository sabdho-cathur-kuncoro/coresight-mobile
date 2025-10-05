import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:flutter/material.dart';
// import 'package:coresight/ui/widgets/custom_button.dart'; // adjust to your path

class ConfirmationBottomSheet {
  static Future<bool> show({
    required BuildContext context,
    String title = "Confirm",
    String message = "Are you sure?",
    String cancelText = "Cancel",
    String confirmText = "OK",
    Color confirmColor = Colors.red,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                message,
                style: Theme.of(ctx).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ButtonText(
                      text: cancelText,
                      styleText: blackTextStyle,
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ButtonText(
                      text: confirmText,
                      styleText: redTextStyle,
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );

    // ✅ Always return a non-nullable bool
    return result ?? false;
  }
}
