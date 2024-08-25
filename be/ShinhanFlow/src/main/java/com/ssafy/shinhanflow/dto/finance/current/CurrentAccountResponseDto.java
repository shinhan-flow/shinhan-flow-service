package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class CurrentAccountResponseDto extends FinanceApiResponseDto {

	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String accountNo, Currency currency) {
	}

	private record Currency(String currency, String currencyName) {
	}
}
