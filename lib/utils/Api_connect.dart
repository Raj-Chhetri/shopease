import 'package:dio/dio.dart';

class Apiconnect{
  static var dio=Dio(BaseOptions(
    baseUrl: "https://shopease.sudamhub.com/api/"
    )
    );
}