import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static Future<int> getCacheSize() async {
    var total = 0;

    final tempDir = await getTemporaryDirectory();
    final cacheDir = await getApplicationCacheDirectory();

    total += await _getDirectorySize(tempDir);
    total += await _getDirectorySize(cacheDir);

    final imageCache = PaintingBinding.instance.imageCache;
    total += imageCache.currentSizeBytes;

    return total;
  }

  static Future<void> clearCache() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    final tempDir = await getTemporaryDirectory();
    final cacheDir = await getApplicationCacheDirectory();

    await _clearDirectory(tempDir);
    await _clearDirectory(cacheDir);
  }

  static Future<int> _getDirectorySize(Directory dir) async {
    if (!await dir.exists()) return 0;

    var size = 0;
    await for (final entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        try {
          size += await entity.length();
        } catch (_) {
          // Skip files that were removed during scan.
        }
      }
    }
    return size;
  }

  static Future<void> _clearDirectory(Directory dir) async {
    if (!await dir.exists()) return;

    await for (final entity in dir.list(followLinks: false)) {
      try {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      } catch (_) {
        // Skip files that are in use or already removed.
      }
    }
  }

  static String formatSize(int bytes) {
    if (bytes <= 0) return '0 B';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
