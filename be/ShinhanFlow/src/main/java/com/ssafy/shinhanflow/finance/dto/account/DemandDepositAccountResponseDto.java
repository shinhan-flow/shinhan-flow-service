package com.ssafy.shinhanflow.finance.dto.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class DemandDepositAccountResponseDto extends FinanceApiResponseDto {

	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	@Value
	private static class Rec {
		String bankCode;
		String accountNo;
		Currency currency;
	}

	@Value
	private static class Currency {
		String currency;
		String currencyName;
	}
}
