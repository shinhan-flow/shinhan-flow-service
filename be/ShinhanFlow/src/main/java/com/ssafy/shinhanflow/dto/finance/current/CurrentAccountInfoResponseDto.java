package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class CurrentAccountInfoResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String bankName, String userName, String accountNo, String accountName,
					   String accountTypeCode,
					   String accountTypeName, String accountCreatedDate, String accountExpiryDate,
					   String dailyTransferLimit, String oneTimeTransferLimit, String accountBalance,
					   String lastTransactionDate, String currency) {
	}

}
