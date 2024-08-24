package com.ssafy.shinhanflow.finance.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class MemberResponseDto extends FinanceApiResponseDto {
	private String userId; // userName@host
	private String username;
	private String institutionCode;
	private String userKey; // 이게 중요해요
	private String created, modified;
}
