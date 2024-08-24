package com.ssafy.shinhanflow.finance.dto.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.finance.dto.FinanceApiRequestDto;
import com.ssafy.shinhanflow.finance.dto.header.RequestHeaderDto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class DemandDepositRequestDto extends FinanceApiRequestDto {
	@JsonProperty("Header")
	RequestHeaderDto header;
	String accountTypeUniqueNo;
}
