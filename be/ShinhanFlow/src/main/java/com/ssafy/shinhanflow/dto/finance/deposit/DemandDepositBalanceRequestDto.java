package com.ssafy.shinhanflow.dto.finance.deposit;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class DemandDepositBalanceRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	String accountNo;
}
