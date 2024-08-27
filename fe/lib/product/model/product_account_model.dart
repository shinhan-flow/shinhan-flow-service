import 'package:json_annotation/json_annotation.dart';

import '../../common/model/entity_enum.dart';

part 'product_account_model.g.dart';

@JsonSerializable()
class ProductAccountModel {
  final String accountTypeUniqueNo;
  final String bankCode;
  final String bankName;
  final String accountTypeCode;
  final String accountTypeName;
  final String accountName;
  final String accountDescription;
  final String accountType;

  ProductAccountModel({
    required this.accountTypeUniqueNo,
    required this.bankCode,
    required this.bankName,
    required this.accountTypeCode,
    required this.accountTypeName,
    required this.accountName,
    required this.accountDescription,
    required this.accountType,
  });

  factory ProductAccountModel.fromJson(Map<String, dynamic> json) =>
      _$ProductAccountModelFromJson(json);
}

class ProductBankAccountModel {
  final BankType bankType;
  final List<ProductAccountModel> products;

  ProductBankAccountModel({
    required this.bankType,
    required this.products,
  });
}
