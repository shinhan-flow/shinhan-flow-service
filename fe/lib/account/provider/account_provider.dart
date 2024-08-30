import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/account/model/account_model.dart';
import 'package:shinhan_flow/account/provider/widget/account_transaction_history_form_provider.dart';
import 'package:shinhan_flow/account/repository/account_repository.dart';
import 'package:shinhan_flow/common/model/default_model.dart';

import '../../action/provider/widget/exchange_action_form_provider.dart';
import '../../action/provider/widget/transfer_action_form_provider.dart';
import '../../common/logger/custom_logger.dart';
import '../param/account_param.dart';

part 'account_provider.g.dart';

//ResponseModel<AccountBaseModel<AccountModel>>
/// 계좌 생성 (수시 입출금)
@riverpod
Future<BaseModel> createAccount(CreateAccountRef ref,
    {required AccountCreateParam param}) async {
  return await ref
      .watch(accountRepositoryProvider)
      .createAccount(param: param)
      .then<BaseModel>((value) async {
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}

/// 본인 계좌 목록 단건 조회 (수시 입출금)
@riverpod
class Account extends _$Account {
  @override
  BaseModel build({required String accountNo}) {
    get(accountNo: accountNo);
    return LoadingModel();
  }

  Future<void> get({required String accountNo}) async {
    final repository = ref.watch(accountRepositoryProvider);
    await repository.getAccount(accountNo: accountNo).then((value) {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}

/// 본인 계좌 목록 전체 조회 (수시 입출금)
@riverpod
class AccountList extends _$AccountList {
  @override
  BaseModel build() {
    getList();
    return LoadingModel();
  }

  Future<void> getList() async {
    final repository = ref.watch(accountRepositoryProvider);
    await repository.getAccounts().then((value) {
      logger.i(value);
      final fromAccount =
          value.data!.rec.isNotEmpty ? value.data!.rec.first.accountNo : '';
      ref
          .read(acTransferFormProvider.notifier)
          .update(fromAccount: fromAccount);
      ref
          .read(acExchangeFormProvider.notifier)
          .update(fromAccount: fromAccount);
      ref.read(defaultAccountNoProvider.notifier).update((n) => fromAccount);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}

/// 계좌 잔액 조회 (수시 입출금)
@riverpod
class AccountBalance extends _$AccountBalance {
  @override
  BaseModel build({required String accountNo}) {
    get(accountNo: accountNo);
    return LoadingModel();
  }

  Future<void> get({required String accountNo}) async {
    final repository = ref.watch(accountRepositoryProvider);
    await repository.getBalance(accountNo: accountNo).then((value) {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}
