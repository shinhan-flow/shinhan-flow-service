package com.ssafy.shinhanflow.dto.member;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
@Builder
public class CreditScoreResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	RequestHeaderDto requestHeader;

	@JsonProperty("REC")
	Rec rec;

	public record Rec(String ratingName, Long demandDepositAssetValue, Long depositSavingsAssetValue,
					  Long totalAssetValue) {
	}
}
