package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
public class CurrentAccountProductResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	private record Rec(String accountTypeUniqueNo, String bankCode, String bankName, String accountTypeCode,
					   String accountTypeName, String accountName, String accountDescription, String accountType) {
	}
}
