package com.ssafy.shinhanflow.dto.finance.product;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.Value;

@Value
public class DepositAndSavingProductCreateResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	// @JsonCreator
	// public DepositAndSavingProductsResponseDto(ResponseHeaderDto header, List<Rec> rec) {
	// 	this.header = header;
	// 	this.rec = rec;
	// }

	public record Rec(String accountTypeUniqueNo, String bankCode, String bankName, String accountTypeCode,
					  String accountTypeName, String accountName, String accountDescription, String subscriptionPeriod,
					  String minSubscriptionBalance, String maxSubscriptionBalance, double interestRate,
					  String rateDescription) {
	}
}
