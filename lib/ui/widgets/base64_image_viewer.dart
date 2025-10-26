import 'dart:convert';
import 'dart:typed_data';
import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';

class Base64ImageViewer extends StatelessWidget {
  final String base64String;

  const Base64ImageViewer({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    try {
      // Remove header if exists (e.g. "data:image/png;base64,...")
      final cleaned = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;

      // Decode Base64 → Uint8List
      Uint8List bytes = base64Decode(cleaned);

      // Display image
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, color: redColor),
      );
    } catch (e) {
      return Icon(Icons.error, color: redColor);
    }
  }
}
