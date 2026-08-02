import 'package:dio/dio.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  DioService._internal();                                      //orderhistory serivice

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://shopease.sudamhub.com/api',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );
}
