package com.ssafy.shinhanflow.dto.finance.current;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class CurrentAccountTransactionHistoryResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String totalCount, List<Transaction> list) {
	}

	private record Transaction(Long transactionUniqueNo, String transactionDate, String transactionTime,
							   String transactionType, String transactionTypeName, String transactionAccountNo,
							   Long transactionBalance, Long transactionAfterBalance, String transactionSummary,
							   String transactionMemo) {
	}

}
