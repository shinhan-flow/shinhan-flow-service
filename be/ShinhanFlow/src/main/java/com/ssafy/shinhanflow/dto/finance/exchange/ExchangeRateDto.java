package com.ssafy.shinhanflow.dto.finance.exchange;

import java.math.BigDecimal;

import lombok.Builder;
import lombok.Value;

@Builder
@Value
public class ExchangeRateDto {
	String currency;
	BigDecimal exchangeRate;
	BigDecimal exchangeMin;
	String created;
}
