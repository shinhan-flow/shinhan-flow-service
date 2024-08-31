//계좌 생성 (수시 입출금)

import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shinhan_flow/account/model/account_holder_model.dart';
import 'package:shinhan_flow/exchange/model/exchange_rate_model.dart';

import '../../auth/model/login_model.dart';
import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';

part 'exchange_repository.g.dart';

const String exchangeEndPoint = '/api/v1/finances/exchange-rates';

final exchangeRateRepositoryProvider = Provider<ExchangeRateRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ExchangeRateRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL + exchangeEndPoint)
abstract class ExchangeRateRepository {
  factory ExchangeRateRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _ExchangeRateRepository;

  /// 환율 조회 (전체)
  @Headers({'token': 'true'})
  @GET('')
  Future<ResponseListModel<ExchangeRateModel>> getExchangeRates();
}
