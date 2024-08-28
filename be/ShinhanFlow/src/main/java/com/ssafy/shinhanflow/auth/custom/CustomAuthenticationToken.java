package com.ssafy.shinhanflow.auth.custom;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import lombok.Getter;

@Getter
public class CustomAuthenticationToken extends UsernamePasswordAuthenticationToken {
	private String fcmToken;

	public CustomAuthenticationToken(Object principal, Object credentials, String fcmToken) {
		super(principal, credentials);
		this.fcmToken = fcmToken;
	}

}
