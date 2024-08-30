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
import '../model/product_loan_model.dart';
import '../model/product_saving_model.dart';

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

  /// 대출 상품 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/finances/products/loans')
  Future<ResponseModel<BankListBaseModel<ProductLoanModel>>> getProductLoan();

  /// 적금 상품 조회
  @Headers({'token': 'true'})
  @GET('/api/v1/finances/products/savings')
  Future<ResponseModel<BankListBaseModel<ProductSavingModel>>>
      getProductSaving();
}
