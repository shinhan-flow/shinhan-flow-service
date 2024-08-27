package com.ssafy.shinhanflow.dto.finance.exchange;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
@Builder
public class ExchangeRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	String accountNo;
	String exchangeCurrency;
	/**
	 * Double 이지만 단위는 10이다.
	 */
	Integer exchangeAmount;
}
