import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/token_interceptor.dart';
import 'package:dio/dio.dart';

import '../../../../core/cores.dart';
import 'endpoints.dart';
import 'logging_interceptor.dart';

class ApiService {
  ApiService({required this.path});

  final String path;

  late final Dio _dio = _buildDio();

  Dio _buildDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl + path,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // Always apply the latest access token at request time.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = appGlobals.token;
          if (token == null || token.isEmpty) {
            options.headers.remove('Authorization');
          } else {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    dio.interceptors.addAll([TokenInterceptor(dio: dio), LoggingInterceptor()]);

    return dio;
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParams);
      if (res.data == null) {
        throw ApiFailure('Unexpected data format');
      }
      return res.data;
    } on DioException catch (e) {
      throw ApiFailure(_handleError(e));
    } on Exception catch (e) {
      throw ApiFailure(e.toString());
    }
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.delete(path, queryParameters: queryParams);
      if (res.data == null) {
        throw ApiFailure('Unexpected data format');
      }
      return res.data;
    } on DioException catch (e) {
      throw ApiFailure(_handleError(e));
    } on Exception catch (e) {
      throw ApiFailure(e.toString());
    }
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
      if (res.data == null) {
        throw ApiFailure('Unexpected data format');
      }
      return res.data;
    } on DioException catch (e) {
      throw ApiFailure(_handleError(e));
    } on Exception catch (e) {
      throw ApiFailure(e.toString());
    }
  }

  Future<dynamic> put(String path, {Object? data}) async {
    try {
      final res = await _dio.put(path, data: data);
      if (res.data == null) {
        throw ApiFailure('Unexpected data format');
      }
      return res.data;
    } on DioException catch (e) {
      throw ApiFailure(_handleError(e));
    } on Exception catch (e) {
      throw ApiFailure(e.toString());
    }
  }

  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParams,
      );
      if (res.data == null) {
        throw ApiFailure('Unexpected data format');
      }
      return res.data;
    } on DioException catch (e) {
      throw ApiFailure(_handleError(e));
    } on Exception catch (e) {
      throw ApiFailure(e.toString());
    }
  }

  String _handleError(DioException dioException) {
    String errorDescription = "";
    //if (error is DioException) {
    //DioException DioException = error as DioException;

    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout. Please try again!";
        break;
      case DioExceptionType.unknown:
        errorDescription = "Something went wrong";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with server";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with server";
        break;
      case DioExceptionType.transformTimeout:
        errorDescription = "Processing the server response timed out";
        break;
      case DioExceptionType.connectionError:
        errorDescription = "Connection to server failed due to internet";
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Bad certificate";
        break;
      case DioExceptionType.badResponse:
        errorDescription = "Bad response";
        if (dioException.response?.data["message"] != null) {
          errorDescription = dioException.response?.data['message'];
        }

        if (dioException.response?.data['message'] != null) {
          errorDescription = dioException.response?.data['message'];
        }
        break;
    }

    return errorDescription;
  }
}
