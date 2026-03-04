import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../config/exception/file_exception.dart';

Future<MultipartFile> toMultipartFile(File file) async {
  final bytes = await file.length();
  const maxBytes = 4 * 1024 * 1024;
  if (bytes > maxBytes) {
    throw FileException(message: 'File is too large');
  }
  return await MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
    contentType: MediaType('image', file.path.split('.').last),
  );
}
