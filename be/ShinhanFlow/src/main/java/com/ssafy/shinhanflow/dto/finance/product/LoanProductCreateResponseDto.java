package com.ssafy.shinhanflow.dto.finance.product;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
public class LoanProductCreateResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	public record Rec(String accountTypeUniqueNo, String bankCode, String bankName, String accountTypeCode,
					  String accountTypeName, String accountName, String accountDescription, String ratingUniqueNo,
					  String ratingName, String loanTypeCode, String loanTypeName, String repaymentMethodTypeCode,
					  String repaymentMethodTypeName, int loanPeriod, Long minLoanBalance, Long maxLoanBalance,
					  double interestRate) {
	}
}
