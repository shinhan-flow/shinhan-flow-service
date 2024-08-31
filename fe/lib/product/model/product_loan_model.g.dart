// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLoanModel _$ProductLoanModelFromJson(Map<String, dynamic> json) =>
    ProductLoanModel(
      bankCode: json['bankCode'] as String,
      bankName: json['bankName'] as String,
      ratingUniqueNo: json['ratingUniqueNo'] as String,
      ratingName: json['ratingName'] as String,
      accountName: json['accountName'] as String,
      loanPeriod: json['loanPeriod'] as String,
      minLoanBalance: json['minLoanBalance'] as String,
      maxLoanBalance: json['maxLoanBalance'] as String,
      interestRate: (json['interestRate'] as num).toDouble(),
      accountDescription: json['accountDescription'] as String,
      accountTypeCode: json['accountTypeCode'] as String,
      accountTypeName: json['accountTypeName'] as String,
      repaymentMethod: json['repaymentMethod'] as String?,
      repaymentMethodTypeName: json['repaymentMethodTypeName'] as String,
    );

Map<String, dynamic> _$ProductLoanModelToJson(ProductLoanModel instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'ratingUniqueNo': instance.ratingUniqueNo,
      'ratingName': instance.ratingName,
      'accountName': instance.accountName,
      'loanPeriod': instance.loanPeriod,
      'minLoanBalance': instance.minLoanBalance,
      'maxLoanBalance': instance.maxLoanBalance,
      'interestRate': instance.interestRate,
      'accountDescription': instance.accountDescription,
      'accountTypeCode': instance.accountTypeCode,
      'accountTypeName': instance.accountTypeName,
      'repaymentMethod': instance.repaymentMethod,
      'repaymentMethodTypeName': instance.repaymentMethodTypeName,
    };
