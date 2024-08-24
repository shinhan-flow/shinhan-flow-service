package com.ssafy.shinhanflow.finance.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class MemberRequestDto extends FinanceApiRequestDto {
	private String userId;
}
