// ignore_for_file: constant_identifier_names

import 'package:accounts/utils/client/models/cookie_inspector.dart';
import 'package:accounts/utils/client/models/cookie_logger.dart';
import 'package:accounts/utils/client/models/cookie_network_model.dart';
import 'package:accounts/utils/client/models/exceptions.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum HttpMethod { GET, POST, DELETE, PUT, PATCH }

class CookieClient {
  CookieClient({
    required String baseUrl,
    Map<String, dynamic>? headers,
    String contentType = Headers.jsonContentType,
    Duration connectTimeout = const Duration(seconds: 5),
    Duration receiveTimeout = const Duration(seconds: 5),
    Duration sendTimeout = const Duration(seconds: 5),
    ResponseType? responseType = ResponseType.json,
    Map<String, dynamic>? queryParameters,
    CookieLogger logger = const CookieLogger(
      request: false,
      responseBody: false,
    ),
    CookieInspector inspector = const CookieInspector(),
  }) {
    final options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      contentType: contentType,
      baseUrl: baseUrl,
      headers: headers,
      responseType: responseType,
      queryParameters: queryParameters,
    );
    _dio = Dio(options);

    final prettyDioLogger = PrettyDioLogger(
      request: logger.request,
      requestHeader: logger.requestHeader,
      requestBody: logger.requestBody,
      responseBody: logger.responseBody,
      responseHeader: logger.responseHeader,
    );

    final alice = Alice(
      navigatorKey: inspector.navigatorKey,
      darkTheme: inspector.themeMode == ThemeMode.dark,
      showNotification: inspector.showNotification,
      showInspectorOnShake: inspector.showInspectorOnShake,
    );
    _dio.interceptors.add(alice.getDioInterceptor());

    if (logger.showLogger) {
      _dio.interceptors.add(prettyDioLogger);
    }
  }

  ///[Dio] Object for Network Request.
  ///The initialization is done in the constructor method.
  late final Dio _dio;

  ///Handy method to make [HttpMethod.POST] request.
  ///[data] must be of type [Map].
  Future<K> post<R extends BaseNetworkModel<Object>, K>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required R responseModel,
    dynamic data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    ResponseType responseType = ResponseType.json,
    Map<String, dynamic>? headers,
    String contentType = Headers.jsonContentType,
  }) async {
    final dioResponse = await _dio.post<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.POST.name,
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );

    final result = _convertToGenericType<R, K>(dioResponse, responseModel);
    return result;
  }

  ///Handy method to make [HttpMethod.GET] request.
  ///data must be of type [Map].
  Future<String?> getString(
    String path, {
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    ResponseType responseType = ResponseType.json,
    String contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final dioResponse = await _dio.get<String>(
      path,
      queryParameters: queryParameters,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.GET.name,
      ),
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return dioResponse.data;
  }

  ///Handy method to make [HttpMethod.GET] request.
  ///data must be of type [Map].
  Future<K> get<R extends BaseNetworkModel<Object>, K>(
    String path, {
    required R responseModel,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    ResponseType responseType = ResponseType.json,
    String contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final dioResponse = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.GET.name,
      ),
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    final result = _convertToGenericType<R, K>(dioResponse, responseModel);
    return result;
  }

  ///Handy method to make [HttpMethod.DELETE] request.
  ///[data] must be of type [Map].
  Future<K> delete<R extends BaseNetworkModel<Object>, K>(
    String path, {
    required R responseModel,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String contentType = Headers.jsonContentType,
    ResponseType responseType = ResponseType.json,
    CancelToken? cancelToken,
  }) async {
    final dioResponse = await _dio.delete<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.DELETE.name,
      ),
    );

    final result = _convertToGenericType<R, K>(dioResponse, responseModel);
    return result;
  }

  ///Handy method to make [HttpMethod.PUT] request.
  ///[data] must be of type [Map].
  Future<K> put<R extends BaseNetworkModel<Object>, K>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required R responseModel,
    dynamic data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    ResponseType responseType = ResponseType.json,
    Map<String, dynamic>? headers,
    String contentType = Headers.jsonContentType,
  }) async {
    final dioResponse = await _dio.put<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      onReceiveProgress: onSendProgress,
      onSendProgress: onSendProgress,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.PUT.name,
      ),
    );

    final result = _convertToGenericType<R, K>(dioResponse, responseModel);
    return result;
  }

  ///Handy method to make [HttpMethod.PATCH] request.
  ///[data] must be of type [Map].
  Future<K> patch<R extends BaseNetworkModel<Object>, K>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required R responseModel,
    dynamic data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    ResponseType responseType = ResponseType.json,
    Map<String, dynamic>? headers,
    String contentType = Headers.jsonContentType,
  }) async {
    final dioResponse = await _dio.patch<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      onReceiveProgress: onSendProgress,
      onSendProgress: onSendProgress,
      options: Options(
        responseType: responseType,
        headers: headers,
        contentType: contentType,
        method: HttpMethod.PATCH.name,
      ),
    );

    final result = _convertToGenericType<R, K>(dioResponse, responseModel);
    return result;
  }

  Future<Response<dynamic>> download({
    required String urlPath,
    required String filePath,
    dynamic data,
    bool deleteOnError = true,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    ResponseType responseType = ResponseType.bytes,
  }) async {
    final result = await _dio.download(
      urlPath,
      filePath,
      onReceiveProgress: onReceiveProgress,
      data: data,
      deleteOnError: deleteOnError,
      cancelToken: cancelToken,
      options: Options(
        responseType: responseType,
      ),
    );
    return result;
  }

  K _convertToGenericType<R extends BaseNetworkModel<Object>, K>(
    Response<dynamic> dioResponse,
    R responseModel,
  ) {
    try {
      if (dioResponse.statusCode != null &&
          dioResponse.statusCode! >= 200 &&
          dioResponse.statusCode! <= 299) {
        final data = dioResponse.data;
        if (data is List) {

          final typedListModel = List<R>.from(
            data
                .map(
                  (e) => responseModel.fromJson(e as Map<String, dynamic>) as R,
                )
                .toList(),
          ) as K;
          return typedListModel;
        } else {
          final typedModel =
              responseModel.fromJson(data as Map<String, dynamic>) as K;
          return typedModel;
        }
      } else {
        throw StatusException(
          status: dioResponse.statusCode,
          error: dioResponse.statusMessage,
        );
      }
    } catch (error) {
      throw JsonParseException(error: error.toString());
    }
  }
}
