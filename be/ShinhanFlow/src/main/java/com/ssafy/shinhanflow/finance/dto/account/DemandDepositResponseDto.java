package com.ssafy.shinhanflow.finance.dto.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.header.ResponseHeaderDto;

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
