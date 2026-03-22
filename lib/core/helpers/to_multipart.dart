import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../config/exception/file_exception.dart';
import '../constants/app_text_string.dart';

Future<MultipartFile> toMultipartFile(File file) async {
  final compressedFile = await _compressImage(file);
  final targetFile = compressedFile ?? file;

  final bytes = await targetFile.length();
  const maxBytes = 4 * 1024 * 1024;

  if (bytes > maxBytes) {
    throw FileException(message: AppTextString.fileIsTooLarge);
  }

  // Fix: 'jpg' → 'jpeg' for proper MIME type
  final extension = targetFile.path.split('.').last.toLowerCase();
  final mimeSubtype = extension == 'jpg' ? 'jpeg' : extension;

  return await MultipartFile.fromFile(
    targetFile.path,
    filename: targetFile.path.split('/').last,
    contentType: MediaType('image', mimeSubtype),
  );
}

Future<File?> _compressImage(File file) async {
  try {
    final dir = await getTemporaryDirectory();
    final extension = path.extension(file.path).toLowerCase();
    final targetPath = path.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}$extension',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75, // Adjust quality (0–100)
      minWidth: 1024, // Max width in pixels
      minHeight: 1024, // Max height in pixels
    );

    return result != null ? File(result.path) : null;
  } catch (e) {
    // If compression fails, return null and use original
    return null;
  }
}
