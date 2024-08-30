import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import '../../product/model/product_account_model.dart';
import '../model/member_model.dart';

part 'member_repository.g.dart';

final memberRepositoryProvider = Provider<MemberRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = MemberRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL)
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _MemberRepository;

  /// 사용자 정보 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/auth/user-info')
  Future<ResponseModel<MemberModel>> getMemberInfo();

  /// 신용 정보 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/members/credit-score')
  Future<ResponseModel<BankBaseModel<MemberCreditScoreModel>>> getCreditScore();
}
