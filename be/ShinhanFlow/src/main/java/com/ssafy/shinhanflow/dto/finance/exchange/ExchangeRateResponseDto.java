package com.ssafy.shinhanflow.dto.finance.exchange;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
public class ExchangeRateResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	ExchangeRate rec;

	@Value
	public static class ExchangeRate {
		Long id;
		String currency;
		BigDecimal exchangeRate;
		BigDecimal exchangeMin;
		String created;

		ExchangeRate(Long id, String currency, String exchangeRate, String exchangeMin, String created) {
			this.id = id;
			this.currency = currency;
			this.exchangeRate = new BigDecimal(exchangeRate.replace(",", ""));
			this.exchangeMin = new BigDecimal(exchangeMin.replace(",", ""));
			this.created = created;
		}
	}
}
