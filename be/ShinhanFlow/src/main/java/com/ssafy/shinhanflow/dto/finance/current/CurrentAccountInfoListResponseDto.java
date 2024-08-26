package com.ssafy.shinhanflow.dto.finance.current;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class CurrentAccountInfoListResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	List<Rec> rec;

	private record Rec(String bankCode, String bankName, String userName, String accountNo, String accountName,
					   String accountTypeCode,
					   String accountTypeName, String accountCreatedDate, String accountExpiryDate,
					   String dailyTransferLimit, String oneTimeTransferLimit, String accountBalance,
					   String lastTransactionDate, String currency) {
	}

}
