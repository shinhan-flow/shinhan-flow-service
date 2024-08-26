package com.ssafy.shinhanflow.dto.finance.exchange;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ExchangeRateResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	ExchangeRate rec;

	private record ExchangeRate(String id, String currency, Double exchangeRate, Double exchangeMin, String created) {
	}
}
