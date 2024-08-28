package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

public class CurrentAccountDeleteResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;

	@JsonProperty("REC")
	Rec rec;

	private record Rec(String status, String accountNo, String refundAccountNo, long accountBalance) {
	}
}
