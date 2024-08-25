package com.ssafy.shinhanflow.dto.finance.deposit;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class DemandDepositResponseDto extends FinanceApiResponseDto {

	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String accountNo, Currency currency) {
	}

	private record Currency(String currency, String currencyName) {
	}
}
