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
public class CurrentAccountTransferRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	String depositAccountNo; // 입금 계좌번호
	Long transactionBalance; // 거래금액
	String withdrawalAccountNo; // 출금 계좌번호
	String depositTransferSummary; // 입금 이체내용
	String withdrawalTransferSummary; // 출금 이체내용
}
