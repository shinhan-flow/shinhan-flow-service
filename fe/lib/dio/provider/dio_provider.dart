import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/provider/secure_storage_provider.dart';
import '../dio_interceptor.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(CustomDioInterceptor(storage: storage, ref: ref));
  return dio;
});