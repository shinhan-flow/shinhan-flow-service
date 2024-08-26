import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../repository/account_repository.dart';

part 'account_balance_provider.g.dart';

/// 계좌 잔액 조회 (수시 입출금)
@riverpod
class AccountHolder extends _$AccountHolder {
  @override
  BaseModel build({required String accountNo}) {
    get(accountNo: accountNo);
    return LoadingModel();
  }

  Future<void> get({required String accountNo}) async {
    final repository = ref.watch(accountRepositoryProvider);
    await repository.getHolder(accountNo: accountNo).then((value) {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('status_code = ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}
