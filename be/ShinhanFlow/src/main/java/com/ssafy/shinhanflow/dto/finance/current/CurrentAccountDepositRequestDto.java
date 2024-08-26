package com.ssafy.shinhanflow.dto.finance.current;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Value;

@Value
@Builder
@EqualsAndHashCode(callSuper = true)
public class CurrentAccountDepositRequestDto extends FinanceApiRequestDto {

	@JsonProperty("Header")
	RequestHeaderDto header;
	String accountNo; // 계좌번호
	Long transactionBalance; // 입금 금액
	String transactionSummary; // 이체내용
}
