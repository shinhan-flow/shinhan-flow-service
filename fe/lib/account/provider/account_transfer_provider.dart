import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/account/provider/account_provider.dart';
import 'package:shinhan_flow/account/provider/account_transaction_history_provider.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../param/account_param.dart';
import '../repository/account_repository.dart';

part 'account_transfer_provider.g.dart';

/// 계좌 이체
@riverpod
Future<BaseModel> transferAccount(TransferAccountRef ref,
    {required AccountTransferParam param}) async {
  return await ref
      .watch(accountRepositoryProvider)
      .transferDeposit(param: param)
      .then<BaseModel>((value) async {
    ref.invalidate(accountListProvider);
    ref.invalidate(accountTransactionHistoryProvider);
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}
