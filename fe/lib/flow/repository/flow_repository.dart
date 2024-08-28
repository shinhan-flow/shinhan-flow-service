//계좌 생성 (수시 입출금)

import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shinhan_flow/account/model/account_holder_model.dart';

import '../../auth/model/login_model.dart';
import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import '../param/flow_param.dart';

part 'flow_repository.g.dart';

const String flowEndPoint = '/api/v1/flow';

final flowRepositoryProvider = Provider<FlowRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = FlowRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL )
abstract class FlowRepository {
  factory FlowRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _FlowRepository;

  /// Flow 생성
  @Headers({'token': 'true'})
  @POST('/api/v1/flows')
  Future<ResponseModel<bool>> createFlow({@Body() required FlowParam param});
}
