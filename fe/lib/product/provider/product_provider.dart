import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/product/model/product_account_model.dart';
import 'package:shinhan_flow/product/repository/product_repository.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../../common/model/entity_enum.dart';

part 'product_provider.g.dart';

@riverpod
class ProductAccount extends _$ProductAccount {
  @override
  BaseModel build() {
    get();
    return LoadingModel();
  }

  Future<void> get() async {
    final repository = ref.watch(productRepositoryProvider);
    await repository.getProductAccount().then((value) {
      final result = BankType.values.map((e) {
        final bank =
            value.data!.rec.where((v) => v.bankCode == e.bankCode).toList();
        return ProductBankAccountModel(
          bankType: e,
          products: bank,
        );
      }).toList();
      logger.i(value);
      state = ResponseModel(code: '200', message: '', data: result);
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}
