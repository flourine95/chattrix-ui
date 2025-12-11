import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// Utility class to generate avatar images from initials
class AvatarGenerator {
  /// Color palette for avatar backgrounds
  static final List<Color> _colorPalette = [
    const Color(0xFFEF5350), // Red
    const Color(0xFFEC407A), // Pink
    const Color(0xFFAB47BC), // Purple
    const Color(0xFF7E57C2), // Deep Purple
    const Color(0xFF5C6BC0), // Indigo
    const Color(0xFF42A5F5), // Blue
    const Color(0xFF29B6F6), // Light Blue
    const Color(0xFF26C6DA), // Cyan
    const Color(0xFF26A69A), // Teal
    const Color(0xFF66BB6A), // Green
    const Color(0xFF9CCC65), // Light Green
    const Color(0xFFD4E157), // Lime
    const Color(0xFFFFEE58), // Yellow
    const Color(0xFFFFCA28), // Amber
    const Color(0xFFFFA726), // Orange
    const Color(0xFFFF7043), // Deep Orange
    const Color(0xFF8D6E63), // Brown
    const Color(0xFFBDBDBD), // Grey
    const Color(0xFF78909C), // Blue Grey
  ];

  /// Generate a color based on a seed string (username or name)
  static Color generateColor(String seed) {
    if (seed.isEmpty) return _colorPalette[0];
    final hash = seed.hashCode.abs();
    return _colorPalette[hash % _colorPalette.length];
  }

  /// Get initials from a name (max 2 characters)
  static String getInitials(String name) {
    if (name.isEmpty) return '?';

    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    } else {
      return (words[0].substring(0, 1) + words[1].substring(0, 1)).toUpperCase();
    }
  }

  /// Generate avatar image file from name
  /// Returns the generated file path
  static Future<File> generateAvatarImage({
    required String name,
    int size = 400,
    String? seed,
  }) async {
    final initials = getInitials(name);
    final backgroundColor = generateColor(seed ?? name);

    // Create a picture recorder
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw background circle
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint,
    );

    // Draw text (initials)
    final textPainter = TextPainter(
      text: TextSpan(
        text: initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout();

    final textOffset = Offset(
      (size - textPainter.width) / 2,
      (size - textPainter.height) / 2,
    );

    textPainter.paint(canvas, textOffset);

    // Convert to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${tempDir.path}/avatar_$timestamp.png');
    await file.writeAsBytes(buffer);

    return file;
  }

  /// Generate avatar image as bytes (without saving to file)
  static Future<List<int>> generateAvatarBytes({
    required String name,
    int size = 400,
    String? seed,
  }) async {
    final file = await generateAvatarImage(name: name, size: size, seed: seed);
    final bytes = await file.readAsBytes();
    await file.delete(); // Clean up temp file
    return bytes;
  }
}

