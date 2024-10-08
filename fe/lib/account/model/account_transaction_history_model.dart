import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/model/default_model.dart';

part 'account_transaction_history_model.g.dart';

/*
    "transactionUniqueNo": 4541,
    "transactionAccountNO": null,
    "transactionDate": "20240829",
        "transactionType": "2",
    "transactionTypeName": "출금(이체)",

    "accountNo": "0010301441449430",

 */
@JsonSerializable()
class AccountTransferModel extends BaseModel {
  final int? transactionUniqueNo;
  final String? transactionAccountNO;
  final String transactionDate;
  final String transactionType;
  final String transactionTypeName;

  AccountTransferModel({
    required this.transactionUniqueNo,
    required this.transactionAccountNO,
    required this.transactionDate,
    required this.transactionType,
    required this.transactionTypeName,
  });

  factory AccountTransferModel.fromJson(Map<String, dynamic> json) =>
      _$AccountTransferModelFromJson(json);
}

@JsonSerializable()
class AccountTransactionHistoryModel extends BaseModel {
  final int transactionUniqueNo;
  final String transactionDate;
  final String transactionTime;
  final String transactionType;
  final String transactionTypeName;
  final String transactionAccountNo;
  final int transactionBalance;
  final int transactionAfterBalance;
  final String transactionSummary;
  final String transactionMemo;

  AccountTransactionHistoryModel({
    required this.transactionUniqueNo,
    required this.transactionDate,
    required this.transactionTime,
    required this.transactionType,
    required this.transactionTypeName,
    required this.transactionAccountNo,
    required this.transactionBalance,
    required this.transactionAfterBalance,
    required this.transactionSummary,
    required this.transactionMemo,
  });

  factory AccountTransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$AccountTransactionHistoryModelFromJson(json);
}

/*
                    "transactionUniqueNo": 4542,
                    "transactionDate": "20240829",
                    "transactionTime": "143425",
                    "transactionType": "1",
                    "transactionTypeName": "입금(이체)",
                    "transactionAccountNo": "0010301441449430",
                    "transactionBalance": 100,
                    "transactionAfterBalance": 11001400100,
                    "transactionSummary": "",
                    "transactionMemo": ""

 */

/*
                    "transactionUniqueNo": 4385,
                    "transactionDate": "20240829",
                    "transactionTime": "010150",
                    "transactionType": "1",
                    "transactionTypeName": "입금",
                    "transactionAccountNo": "",
                    "transactionBalance": 1000000,
                    "transactionAfterBalance": 1000000,
                    "transactionSummary": "이체 내용 작성 필수값 아님",
                    "transactionMemo": ""

 */
/*
  "accountNo": "0010337226851755",
  "startDate": "20240801",
  "endDate": "20240930",
  "transactionType": "A",
  "orderByType": "DESC"
 */
