// "accountTypeUniqueNo": "001-3-36b456ce20f34f",
// "bankCode": "001",
// "bankName": "한국은행",
// "accountTypeCode": "3",
// "accountTypeName": "적금",
// "accountName": "한국은행 정기적금 상품",
// "accountDescription": "",
// "subscriptionPeriod": "7",
// "minSubscriptionBalance": "10000",
// "maxSubscriptionBalance": "1000000",
// "interestRate": "10",
// "rateDescription": "10%의 이자를 지급합니다."

import 'package:json_annotation/json_annotation.dart';

part 'product_saving_model.g.dart';

@JsonSerializable()
class ProductSavingModel {
  final String accountTypeUniqueNo;
  final String bankCode;
  final String bankName;
  final String accountTypeCode;
  final String accountTypeName;
  final String accountName;
  final String accountDescription;
  final String subscriptionPeriod;
  final String minSubscriptionBalance;
  final String maxSubscriptionBalance;
  final double interestRate;
  final String rateDescription;

  ProductSavingModel({
    required this.accountTypeUniqueNo,
    required this.bankCode,
    required this.bankName,
    required this.accountTypeCode,
    required this.accountTypeName,
    required this.accountName,
    required this.accountDescription,
    required this.subscriptionPeriod,
    required this.minSubscriptionBalance,
    required this.maxSubscriptionBalance,
    required this.interestRate,
    required this.rateDescription,
  });

  factory ProductSavingModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSavingModelFromJson(json);
}
