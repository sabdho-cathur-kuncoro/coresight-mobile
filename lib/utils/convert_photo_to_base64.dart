import 'dart:convert';
import 'dart:io';

String convertToBase64(String photoPath) {
  final bytes = File(photoPath).readAsBytesSync();
  return base64Encode(bytes);
}
