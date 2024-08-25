package com.ssafy.shinhanflow.auth.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.service.AuthService;
import com.ssafy.shinhanflow.config.error.SuccessResponse;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthController {
	private final AuthService refreshTokenService;

	@GetMapping("/access-token")
	public SuccessResponse<String> refreshAccessToken(@RequestHeader("refresh") String refreshToken) {
		String newAccessToken = refreshTokenService.validateAndGenerateNewAccessToken(refreshToken);
		return SuccessResponse.of(newAccessToken);
	}
}
