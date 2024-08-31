package com.ssafy.shinhanflow.dto.finance.product;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
@Builder
public class LoanProductCreateRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	String bankCode;
	String accountName;
	String accountDescription;
	String ratingUniqueNo;
	int loanPeriod;
	Long minLoanBalance;
	Long maxLoanBalance;
	double interestRate;
}