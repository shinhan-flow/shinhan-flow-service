package com.ssafy.shinhanflow.finance.dto;

import com.ssafy.shinhanflow.entity.MemberEntity;

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

	public MemberEntity toMemberEntity(String password) {
		return new MemberEntity(this.userId, password, this.username, this.userKey);
	}
}
