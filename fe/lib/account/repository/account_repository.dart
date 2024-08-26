//계좌 생성 (수시 입출금)

import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shinhan_flow/account/model/account_holder_model.dart';

import '../../auth/model/login_model.dart';
import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import '../model/account_balance_model.dart';
import '../model/account_model.dart';
import '../param/account_param.dart';

part 'account_repository.g.dart';

const String accountEndPoint = '/api/v1/finances';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = AccountRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL + accountEndPoint)
abstract class AccountRepository {
  factory AccountRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _AccountRepository;

  /// 본인 계좌 목록 단건 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts/{accountNo}')
  Future<ResponseModel<AccountBaseModel<AccountDetailModel>>> getAccount(
      {@Path() required String accountNo});

  /// 계좌 생성 (수시 입출금)
  @Headers({'token': 'true'})
  @POST('/current-accounts')
  Future<ResponseModel<AccountBaseModel<AccountModel>>> createAccount({
    @Body() required AccountCreateParam param,
  });

  /// 본인 계좌 목록 전체 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts')
  Future<ResponseModel<AccountBaseModel<List<AccountDetailModel>>>>
      getAccounts();

  /// 예금주 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts/{accountNo}/account-holder')
  Future<ResponseModel<AccountBaseModel<AccountHolderModel>>> getHolder(
      {@Path() required String accountNo});

  /// 계좌 잔액 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts/{accountNo}/balance')
  Future<ResponseModel<AccountBaseModel<AccountBalanceModel>>> getBalance(
      {@Path() required String accountNo});

  /// 입금 (수시입출금)
}
