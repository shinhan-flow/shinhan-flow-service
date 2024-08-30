import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/common/model/default_model.dart';

import '../../param/account_param.dart';

part 'account_transfer_form_provider.g.dart';

@riverpod
class AccountTransferForm extends _$AccountTransferForm {
  @override
  AccountTransferParam build() {
    return AccountTransferParam(
        depositAccountNo: '',
        transactionBalance: 0,
        withdrawalAccountNo: '',
        depositTransferSummary: '',
        withdrawalTransferSummary: '');
  }

  void update({
    String? depositAccountNo,
    String? transactionBalance,
    String? withdrawalAccountNo,
    String? depositTransferSummary,
    String? withdrawalTransferSummary,
  }) {
    final balance = transactionBalance != null
        ? int.parse(transactionBalance.replaceAll(',', ''))
        : null;

    state = state.copyWith(
      depositAccountNo: depositAccountNo,
      transactionBalance: balance,
      withdrawalAccountNo: withdrawalAccountNo,
      depositTransferSummary: depositTransferSummary,
      withdrawalTransferSummary: withdrawalTransferSummary,
    );
  }
}
