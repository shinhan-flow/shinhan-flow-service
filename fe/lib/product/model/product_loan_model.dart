/*

                "bankCode": "001",
                "bankName": "한국은행",
                "ratingUniqueNo": "RT-a335h7aa7f3x74ag5",
                "ratingName": "E",
                "accountName": "한국은행 대출 상품",
                "loanPeriod": "7",
                "minLoanBalance": "10000",
                "maxLoanBalance": "3000000",
                "interestRate": 10.0,
                "accountDescription": "",
                "accountTypeCode": "4",
                "accountTypeName": "대출",
                "repaymentMethod": null,
                "repaymentMethodTypeName": "원리금균등상환"
 */

import 'package:json_annotation/json_annotation.dart';

part 'product_loan_model.g.dart';

@JsonSerializable()
class ProductLoanModel {
  final String bankCode;
  final String bankName;
  final String ratingUniqueNo;
  final String ratingName;
  final String accountName;
  final String loanPeriod;
  final String minLoanBalance;
  final String maxLoanBalance;
  final double interestRate;
  final String accountDescription;
  final String accountTypeCode;
  final String accountTypeName;
  final String? repaymentMethod;
  final String repaymentMethodTypeName;

  ProductLoanModel({
    required this.bankCode,
    required this.bankName,
    required this.ratingUniqueNo,
    required this.ratingName,
    required this.accountName,
    required this.loanPeriod,
    required this.minLoanBalance,
    required this.maxLoanBalance,
    required this.interestRate,
    required this.accountDescription,
    required this.accountTypeCode,
    required this.accountTypeName,
    required this.repaymentMethod,
    required this.repaymentMethodTypeName,
  });

  factory ProductLoanModel.fromJson(Map<String, dynamic> json) =>
      _$ProductLoanModelFromJson(json);
}
