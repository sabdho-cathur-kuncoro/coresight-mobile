// import 'package:coresight/ui/widgets/button.dart';
import 'package:flutter/material.dart';
// import 'package:coresight/ui/widgets/custom_button.dart'; // adjust path to your button

class ConfirmationDialog {
  static Future<bool> show({
    required BuildContext context,
    String title = "Confirm",
    String message = "Are you sure?",
    String cancelText = "Cancel",
    String confirmText = "OK",
    Color confirmColor = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
