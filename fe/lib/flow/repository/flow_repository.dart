//계좌 생성 (수시 입출금)

import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shinhan_flow/account/model/account_holder_model.dart';
import 'package:shinhan_flow/common/param/pagination_param.dart';
import 'package:shinhan_flow/flow/model/flow_model.dart';

import '../../auth/model/login_model.dart';
import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../common/repository/base_pagination_repository.dart';
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

@RestApi(baseUrl: serverURL)
abstract class FlowRepository {
  factory FlowRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _FlowRepository;

  /// Flow 생성
  @Headers({'token': 'true'})
  @POST('/api/v1/flows')
  Future<ResponseModel<bool>> createFlow({@Body() required FlowParam param});

  /// Flow 상세 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/flows/{flowId}')
  Future<ResponseModel<FlowDetailModel>> getFlow({@Path() required int flowId});

  /// Flow 상태 변경
  @Headers({'token': 'true'})
  @PATCH('/api/v1/flows/{flowId}')
  Future<ResponseModel<bool>> toggleFlow({
    @Path() required int flowId,
  });

  /// Flow 상세 조회
  @Headers({'token': 'true'})
  @DELETE('/api/v1/flows/{flowId}')
  Future<ResponseModel<bool>> deleteFlow({@Path() required int flowId});

  /// Flow 프롬프트 생성
  @Headers({'token': 'true'})
  @DELETE('/api/v1/ai/flow-generator')
  Future<ResponseModel<FlowDetailModel>> prompt({@Path() required int flowId});
}

final flowPRepositoryProvider = Provider<FlowPRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FlowPRepository(dio);
});

@RestApi(baseUrl: serverURL)
abstract class FlowPRepository
    extends IBasePaginationRepository<FlowModel, FlowPParam> {
  factory FlowPRepository(Dio dio) = _FlowPRepository;

  @override
  @Headers({'token': 'true'})
  @GET('/api/v1/flows')
  Future<ResponseModel<PaginationModel<FlowModel>>> paginate({
    @Queries() required PaginationParam paginationParams,
    @Queries() FlowPParam? param,
    @Path('userId') int? path,
  });
}
