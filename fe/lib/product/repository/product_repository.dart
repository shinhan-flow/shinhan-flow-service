//계좌 생성 (수시 입출금)

import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shinhan_flow/account/model/account_holder_model.dart';
import 'package:shinhan_flow/product/model/product_account_model.dart';

import '../../account/model/account_model.dart';
import '../../auth/model/login_model.dart';
import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';

part 'product_repository.g.dart';

const String accountEndPoint = '/api/v1/finances/product';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ProductRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL)
abstract class ProductRepository {
  factory ProductRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _ProductRepository;

  /// 수시입출금 상품 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/finances/products/current-accounts')
  Future<ResponseModel<BankListBaseModel<ProductAccountModel>>>
      getProductAccount();
}
