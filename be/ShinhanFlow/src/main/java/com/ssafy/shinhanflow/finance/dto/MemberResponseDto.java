package com.ssafy.shinhanflow.finance.dto;

import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.Value;

@Value
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class MemberResponseDto extends FinanceApiResponseDto {
	String userId; // email
	String userKey; // pk
}
