package com.ssafy.shinhanflow.dto.finance.product;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
public class LoanProductsResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	List<Rec> rec;

	public record Rec(String bankCode, String bankName, String ratingUniqueNo, String ratingName, String accountName,
					  String loanPeriod, String minLoanBalance, String maxLoanBalance, double interestRate,
					  String accountDescription, String accountTypeCode, String accountTypeName,
					  String repaymentMethod, String repaymentMethodTypeName) {
	}
}
