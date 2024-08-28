package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Getter;

@Getter
public class CurrentAccountBalanceResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	public record Rec(String bankCode, String accountNo, Long accountBalance, String accountCreatedDate,
					  String accountExpiryDate, String lastTransactionDate, String currency) {

	}
}
