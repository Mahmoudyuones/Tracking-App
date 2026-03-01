import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

Future<MultipartFile> toMultipartFile(File file) async {
  return await MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
    contentType: MediaType('image', file.path.split('.').last),
  );
}
