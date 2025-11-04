import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

/// Adds a multiline watermark (bottom-left) and returns the new image path.
Future<String> addWatermark({
  required String photoPath,
  required String watermarkText,
}) async {
  final bytes = await File(photoPath).readAsBytes();
  final image = img.decodeImage(bytes);
  if (image == null) throw Exception('Could not decode image');

  // Built-in bitmap font
  final font = img.arial24;

  // Split into lines so we can render multiline watermarks
  final lines = watermarkText.split('\n');

  // Padding from left and bottom
  const int paddingX = 48;
  const int paddingBottom = 48;

  // Approx line height for arial24 (safe value). You can tweak if needed.
  const int lineHeight = 28;

  // Start drawing from bottom-left upwards
  int startY = image.height - paddingBottom - (lines.length - 1) * lineHeight;

  // Draw each line (note: drawString signature uses positional args)
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    img.drawString(
      image,
      font: font,
      x: paddingX,
      y: startY + i * lineHeight,
      line,
      color: img.ColorFloat32.rgb(255, 255, 255),
    );
  }

  // Save to temp dir
  final tempDir = await getTemporaryDirectory();
  final outPath =
      '${tempDir.path}/watermarked_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final outBytes = img.encodeJpg(image, quality: 90);
  await File(outPath).writeAsBytes(outBytes);

  return outPath;
}
