package com.ssafy.shinhanflow.finance.dto;

import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.Value;

@Value
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class MemberResponseDto extends FinanceApiResponseDto {
	String userId; // userName@host
	String username;
	String institutionCode;
	String userKey; // 이게 중요해요
	String created, modified;
}
