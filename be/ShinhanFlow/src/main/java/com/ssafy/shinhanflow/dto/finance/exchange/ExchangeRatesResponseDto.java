package com.ssafy.shinhanflow.dto.finance.exchange;

import java.math.BigDecimal;
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
