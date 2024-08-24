package com.ssafy.shinhanflow.finance.dto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@Value
@EqualsAndHashCode(callSuper = true)
public class MemberRequestDto extends FinanceApiRequestDto {
	String apiKey;
	String userId;
}
