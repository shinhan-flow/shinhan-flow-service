package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class CurrentAccountHolderResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	public record Rec(String bankCode, String bankName, String userName, String currency) {
	}
}
