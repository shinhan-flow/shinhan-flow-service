package com.ssafy.shinhanflow.finance.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class MemberResponseDto extends FinanceApiResponseDto {
	private String userId;
	private String userName;
	private String institutionCode;
	private String userKey;
	private String created, modified;
}
