/*
     "ratingName": "A",
            "demandDepositAssetValue": 11001600100,
            "depositSavingsAssetValue": 0,
            "totalAssetValue": 11001600100
 */

import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final String name;
  final String email;
  final String createdAt;

  MemberModel({
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}

@JsonSerializable()
class MemberCreditScoreModel {
  final String ratingName;
  final int demandDepositAssetValue;
  final int depositSavingsAssetValue;
  final int totalAssetValue;

  MemberCreditScoreModel({
    required this.ratingName,
    required this.demandDepositAssetValue,
    required this.depositSavingsAssetValue,
    required this.totalAssetValue,
  });

  factory MemberCreditScoreModel.fromJson(Map<String, dynamic> json) =>
      _$MemberCreditScoreModelFromJson(json);
}
