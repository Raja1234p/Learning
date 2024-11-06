import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  final Dio _dio;

  factory DioClient() {
    return _instance;
  }

  Dio get dio => _dio;

  DioClient._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: "http://brownonions-002-site1.ftempurl.com",
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            "Content-Type": "application/json",
          },
        )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
