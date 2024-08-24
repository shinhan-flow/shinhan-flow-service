package com.ssafy.shinhanflow.finance.dto.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.header.ResponseHeaderDto;

public class DemandDepositBalanceResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String accountNo, String accountBalance, String accountCreatedDate,
					   String accountExpiryDate, String lastTransactionDate, String currency) {

	}
}
