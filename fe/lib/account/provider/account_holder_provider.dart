import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../repository/account_repository.dart';

part 'account_holder_provider.g.dart';

/// 예금주 조회 (수시 입출금)
// @riverpod
// class AccountHolder extends _$AccountHolder {
//   @override
//   BaseModel build({required String accountNo}) {
//     get(accountNo: accountNo);
//     return LoadingModel();
//   }
//
//   Future<void> get({required String accountNo}) async {
//     final repository = ref.watch(accountRepositoryProvider);
//     await repository.getHolder(accountNo: accountNo).then((value) {
//       logger.i(value);
//       state = value;
//     }).catchError((e) {
//       final error = ErrorModel.respToError(e);
//       logger.e('code ${error.code}\nmessage = ${error.message}');
//       state = error;
//     });
//   }
// }

@riverpod
Future<BaseModel> accountHolder(AccountHolderRef ref,
    {required String accountNo}) async {
  return await ref
      .watch(accountRepositoryProvider)
      .getHolder(accountNo: accountNo)
      .then<BaseModel>((value) async {
    logger.i('login $value!');

    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}
