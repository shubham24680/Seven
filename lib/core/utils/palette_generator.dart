import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:seven/app/app.dart';

class ImageColorCache {
  ImageColorCache._();
  static final instance = ImageColorCache._();
  final Map<String, Color> _cache = {};

  bool has(String url) => _cache.containsKey(url);
  Color? get(String url) => _cache[url];
  void set(String url, Color c) => _cache[url] = c;
}

class PaletteGenerator {
  static Future<Color> extractColor(
    String? imageUrl, {
    Color fallback = AppColors.vividNightfall4,
  }) async {
    if (imageUrl == null || imageUrl.isEmpty) return fallback;
    final cache = ImageColorCache.instance;
    if (cache.has(imageUrl)) return cache.get(imageUrl)!;

    try {
      // Step 1: Load image into a ui.Image
      final uiImage = await _loadUiImage(imageUrl);

      // Step 2: Get raw RGBA bytes
      final byteData = await uiImage.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (byteData == null) return fallback;

      // Step 3: Run extraction in a compute() isolate (never blocks UI)
      final bytes = byteData.buffer.asUint8List();
      final dominant = await compute(
        _extractDominantColor,
        _PixelData(
          bytes: bytes,
          width: uiImage.width,
          height: uiImage.height,
        ),
      );

      final vivid = _boost(dominant);
      cache.set(imageUrl, vivid);
      return vivid;
    } catch (_) {
      return fallback;
    }
  }

  // Load a network image into a ui.Image (uses Flutter's image cache)
  static Future<ui.Image> _loadUiImage(String url) {
    final completer = Completer<ui.Image>();
    final stream = NetworkImage(url).resolve(ImageConfiguration.empty);
    late ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        stream.removeListener(listener);
        completer.complete(info.image);
      },
      onError: (e, _) {
        stream.removeListener(listener);
        completer.completeError(e);
      },
    );
    stream.addListener(listener);
    return completer.future;
  }

  // Runs in isolate — pure Dart, no imports needed except dart:typed_data
  static Color _extractDominantColor(_PixelData data) {
    final bytes = data.bytes;
    const sampleStep = 4; // sample every 4th pixel (faster)
    const totalChannels = 4; // RGBA

    // Bucket pixels into 12 hue segments
    const buckets = 12;
    final rSums = List.filled(buckets, 0);
    final gSums = List.filled(buckets, 0);
    final bSums = List.filled(buckets, 0);
    final counts = List.filled(buckets, 0);

    final total = bytes.length ~/ totalChannels;
    for (var i = 0; i < total; i += sampleStep) {
      final offset = i * totalChannels;
      final r = bytes[offset];
      final g = bytes[offset + 1];
      final b = bytes[offset + 2];
      final a = bytes[offset + 3];

      // Skip near-transparent, near-black, near-white pixels
      if (a < 128) continue;
      final brightness = (r + g + b) / 3;
      if (brightness < 20 || brightness > 235) continue;

      // Assign to hue bucket using simple RGB → Hue approximation
      final max = math.max(r, math.max(g, b));
      final min = math.min(r, math.min(g, b));
      if (max == min) continue; // achromatic — skip

      double hue;
      final delta = max - min;
      if (max == r) {
        hue = ((g - b) / delta) % 6;
      } else if (max == g) {
        hue = (b - r) / delta + 2;
      } else {
        hue = (r - g) / delta + 4;
      }
      hue = (hue * 60) % 360;
      if (hue < 0) hue += 360;

      final bucket = (hue / 360 * buckets).floor().clamp(0, buckets - 1);
      rSums[bucket] += r;
      gSums[bucket] += g;
      bSums[bucket] += b;
      counts[bucket]++;
    }

    // Find most-populated bucket
    int maxCount = 0;
    int maxBucket = 0;
    for (var i = 0; i < buckets; i++) {
      if (counts[i] > maxCount) {
        maxCount = counts[i];
        maxBucket = i;
      }
    }

    if (maxCount == 0) return const Color(0xFFE8912A);

    return Color.fromARGB(
      255,
      rSums[maxBucket] ~/ maxCount,
      gSums[maxBucket] ~/ maxCount,
      bSums[maxBucket] ~/ maxCount,
    );
  }

  static Color _boost(Color c) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withSaturation((hsl.saturation + 0.2).clamp(0.45, 1.0))
        .withLightness(hsl.lightness.clamp(0.38, 0.62))
        .toColor();
  }
}

// Data class for compute() isolate (must be sendable across isolates)
class _PixelData {
  final Uint8List bytes;
  final int width;
  final int height;
  const _PixelData({
    required this.bytes,
    required this.width,
    required this.height,
  });
}
