import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../common/logger/custom_logger.dart';

const String serverURL = "http://13.124.223.172:8080";

class CustomDioInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  final Ref ref;

  CustomDioInterceptor({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // logger.d("Logger is working!");

    // 요청 전 accestoken을 header에 주입
    if (options.headers['token'] == 'true') {
      String? accessToken = await storage.read(key: 'accessToken');
      options.headers.remove('token');
      if (options.headers.containsKey('required') &&
          options.headers['required'] == 'false') {
        options.headers.remove('required');
        if (accessToken != null) {
          /// 토큰이 필수가 아니면서 토큰 값이 없으면 토큰 주입 X
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        }
      } else {
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
      }
    }
    if (options.headers['refresh'] == 'true') {
      String? refreshToken = await storage.read(key: 'refreshToken');
      log('refresh ${refreshToken}');
      // options.headers.remove('refreshToken');
      options.headers.addAll({'refresh': '$refreshToken'});
    }
    List<String> requestLog = [];
    requestLog.add(
        '[REQUEST] [${options.method}] ${options.baseUrl}${options.uri.path}\n');

    if (options.uri.queryParameters.isNotEmpty) {
      requestLog.add('[QueryParameters] ${options.uri.queryParameters}\n');
    }
    if (options.uri.data != null) {
      requestLog.add('[URI Parameters] ${options.uri.data!.parameters}\n');
    }
    requestLog.add('[Headers] ${options.headers}\n');
    requestLog.add('[Data] ${options.data}');

    logger.d(requestLog.reduce((value, element) => value + element));
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    List<String> errorLog = [];
    final noneAuthUrl = [
      // 'auth/login/kakao',
      // 'auth/login/apple',
      // '/auth/login/email',
      // 'auth/verify-code',
    ];

    log('err.message ${err.message} , err.error = ${err.error}, err.type = ${err.type}');
    final noneAUth = noneAuthUrl.contains(err.requestOptions.uri.path);

    errorLog.add(
        '[ERROR] [${err.response?.statusCode ?? 'None StatusCode'}] [${err.requestOptions.method}] ${err.requestOptions.baseUrl}${err.requestOptions.uri.path}\n');
    if (err.requestOptions.queryParameters.isNotEmpty) {
      errorLog.add('[QueryParameters] ${err.requestOptions.queryParameters}\n');
    }
    errorLog.add('[Headers] ${err.requestOptions.headers}');
    logger.w(errorLog.reduce((value, element) => value + element));
    // 어세스 토큰이 만료되 경우
    if (err.response!.statusCode == 401 &&
        err.requestOptions.uri.path != '/auth/refresh-token' &&
        !noneAUth) {
      try {
        Dio dio = Dio();
        // final newAccessToken =
        //     await ref.read(authProvider.notifier).reIssueToken();
        // err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        log("[RE-REQUEST] [${err.requestOptions.method}] ${err.requestOptions.baseUrl}${err.requestOptions.path}");
        if (err.requestOptions.uri.queryParameters.isNotEmpty) {
          log("[RE-REQUEST] [${err.requestOptions.method}] ${err.requestOptions.uri.queryParameters}");
        }
        // 재요청
        final reResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(reResponse);
      } on DioException catch (e) {
        // 리프레쉬 토큰 만료 된 경우
        log("리프레쉬 만료 !!");
        // await ref.read(tokenProvider.notifier).logout();
        return;
      }
    }

    handler.reject(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<String> responseLog = [];
    responseLog.add(
        '[RESPONSE] [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path}\n');
    if (response.requestOptions.uri.queryParameters.isNotEmpty) {
      responseLog.add(
          '[QueryParameters] ${response.requestOptions.uri.queryParameters}');
    }
    logger.d(responseLog.reduce((value, element) => value + element));

    super.onResponse(response, handler);
  }
}
