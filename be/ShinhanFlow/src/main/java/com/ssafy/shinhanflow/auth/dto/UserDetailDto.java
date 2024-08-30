package com.ssafy.shinhanflow.auth.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class UserDetailDto {
	String name;
	String email;
	String createdAt;
}
