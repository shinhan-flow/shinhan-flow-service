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
import '../model/account_balance_model.dart';
import '../model/account_model.dart';
import '../model/account_transaction_history_model.dart';
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
  Future<ResponseModel<BankBaseModel<AccountDetailModel>>> getAccount(
      {@Path() required String accountNo});

  /// 계좌 생성 (수시 입출금)
  @Headers({'token': 'true'})
  @POST('/current-accounts')
  Future<ResponseModel<BankBaseModel<AccountModel>>> createAccount({
    @Body() required AccountCreateParam param,
  });

  /// 본인 계좌 목록 전체 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts')
  Future<ResponseModel<BankListBaseModel<AccountDetailModel>>> getAccounts();

  /// 예금주 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts/{accountNo}/account-holder')
  Future<ResponseModel<BankBaseModel<AccountHolderModel>>> getHolder(
      {@Path() required String accountNo});

  /// 계좌 잔액 조회 (수시 입출금)
  @Headers({'token': 'true'})
  @GET('/current-accounts/{accountNo}/balance')
  Future<ResponseModel<BankBaseModel<AccountBalanceModel>>> getBalance(
      {@Path() required String accountNo});

  /// 거래 내역 조회
  @Headers({'token': 'true'})
  @POST('/current-accounts/transaction-history')
  Future<
          ResponseModel<
              BankBaseModel<RecListModel<AccountTransactionHistoryModel>>>>
      getTransactionHistory(
          {@Body() required AccountTransactionHistoryParam param});

  /// 계좌 이체
  @Headers({'token': 'true'})
  @POST('/current-accounts/transfer')
  Future<ResponseModel<BankListBaseModel<AccountTransferModel>>>
      transferDeposit({@Body() required AccountTransferParam param});
}
