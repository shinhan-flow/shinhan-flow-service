package com.ssafy.shinhanflow.dto.finance.exchange;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class ExchangeRateResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	ExchangeRate rec;

	@JsonCreator
	public ExchangeRateResponseDto(
		@JsonProperty("Header") ResponseHeaderDto header,
		@JsonProperty("REC") ExchangeRate rec) {
		this.header = header;
		this.rec = rec;
	}

	private record ExchangeRate(Long id, String currency, BigDecimal exchangeRate, BigDecimal exchangeMin,
								String created) {
	}
}