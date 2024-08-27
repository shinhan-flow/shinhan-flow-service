package com.ssafy.shinhanflow.auth.dto;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class LoginSuccessResponseDto {
	String accessToken;
	String refreshToken;
}
