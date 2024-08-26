package com.ssafy.shinhanflow.dto.finance.current;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@Value
@EqualsAndHashCode(callSuper = true)
public class CurrentAccountTransferResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	List<Rec> rec;

	private record Rec(Long transactionUniqueNo, String accountNo, String transactionDate, String transactionType,
					   String transactionTypeName, String transactionAccountNO) {

	}
}
