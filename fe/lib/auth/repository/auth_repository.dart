import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import '../model/login_model.dart';
import '../param/login_param.dart';
import 'dart:convert' show jsonEncode;
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

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
  Future<LoginModel> login({
    @Field() required String username,
    @Field() required String password,
  });
}
