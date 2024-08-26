package com.ssafy.shinhanflow.dto.finance.exchange;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class ExchangeRatesResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	List<ExchangeRate> rec;

	private record ExchangeRate(String id, String currency, Double exchangeRate, Double exchangeMin, String created) {
	}
}
