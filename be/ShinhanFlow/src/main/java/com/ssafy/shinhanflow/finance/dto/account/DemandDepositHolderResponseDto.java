package com.ssafy.shinhanflow.finance.dto.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.header.ResponseHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class DemandDepositHolderResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String bankCode, String bankName, String userName, String currency) {
	}
}
