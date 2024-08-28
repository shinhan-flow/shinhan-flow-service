import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/exchange/repository/exchange_repository.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';

part 'exchange_provider.g.dart';

@riverpod
class ExchangeRate extends _$ExchangeRate {
  @override
  BaseModel build() {
    getExchangeRates();
    return LoadingModel();
  }

  void getExchangeRates() {
    final repository = ref.read(exchangeRateRepositoryProvider);
    repository.getExchangeRates().then((value) {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}
