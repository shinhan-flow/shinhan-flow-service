import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/account/param/account_param.dart';

part 'account_transaction_history_form_provider.g.dart';

final defaultAccountNoProvider = StateProvider<String>((ref) => '');

@riverpod
class AccountTransactionHistoryForm extends _$AccountTransactionHistoryForm {
  @override
  AccountTransactionHistoryParam build() {
    final accountNo = ref.read(defaultAccountNoProvider);
    final df = DateFormat('yyyyMMdd');
    final nowDate = df.format(DateTime.now());
    final endDate = df.format(DateTime.now());
    return AccountTransactionHistoryParam(
      accountNo: accountNo,
      startDate: nowDate,
      endDate: endDate,
      orderByType: 'DESC',
    );
  }

  void update({
    String? accountNo,
    String? startDate,
    String? endDate,
    String? orderByType,
  }) {
    state = state.copyWith(
      accountNo: accountNo,
      startDate: startDate,
      endDate: endDate,
      orderByType: orderByType,
    );
  }
}
