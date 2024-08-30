package com.ssafy.shinhanflow.dto.member;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

public class CreditScoreResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	RequestHeaderDto requestHeader;

	@JsonProperty("REC")
	Rec rec;

	private record Rec(String ratingName, Long demandDepositAssetValue, Long depositSavingsAssetValue,
					   Long totalAssetValue) {
	}
}
