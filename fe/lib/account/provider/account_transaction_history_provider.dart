import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/account/provider/widget/account_transaction_history_form_provider.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../repository/account_repository.dart';

part 'account_transaction_history_provider.g.dart';

@riverpod
class AccountTransactionHistory extends _$AccountTransactionHistory {
  @override
  BaseModel build() {
    getHistories();
    return LoadingModel();
  }

  Future<void> getHistories() async {
    final param = ref.read(accountTransactionHistoryFormProvider);

    await ref
        .read(accountRepositoryProvider)
        .getTransactionHistory(param: param)
        .then<BaseModel>((value) async {
      logger.i('history $value!');
      state = value;
      return value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
      return error;
    });
  }
}
