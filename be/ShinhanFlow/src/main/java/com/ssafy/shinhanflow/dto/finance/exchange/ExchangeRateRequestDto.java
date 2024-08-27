package com.ssafy.shinhanflow.dto.finance.exchange;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.util.constants.Currency;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ExchangeRateRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	Currency currency;
}
