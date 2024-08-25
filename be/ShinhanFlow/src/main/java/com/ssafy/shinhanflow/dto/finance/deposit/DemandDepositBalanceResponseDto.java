package com.ssafy.shinhanflow.dto.finance.deposit;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

public class DemandDepositBalanceResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String accountNo, String accountBalance, String accountCreatedDate,
					   String accountExpiryDate, String lastTransactionDate, String currency) {

	}
}
