import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinhan_flow/auth/model/token_model.dart';
import 'package:shinhan_flow/auth/provider/auth_provider.dart';

import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import '../model/login_model.dart';
import '../param/login_param.dart';
import 'dart:convert' show jsonEncode;
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../param/sign_up_param.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = AuthRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL)
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {ParseErrorLogger errorLogger}) =
  _AuthRepository;

  @POST('/login')
  @FormUrlEncoded()
  Future<ResponseModel<AuthModel>> login({
    @Field() required String username,
    @Field() required String password,
    @Field() required String fcmToken,
  });

  @POST('/api/v1/members')
  Future<ResponseModel<bool>> signUp({
    @Body() required SignUpParam param,
  });

  @Headers({'refresh': 'true'})
  @GET('/api/v1/auth/access-token')
  Future<ResponseModel<String>> getReIssueToken();

//
}