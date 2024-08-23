package com.ssafy.shinhanflow.auth.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.service.RefreshTokenService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthController {
	private final RefreshTokenService refreshTokenService;

	@GetMapping("/token-test")
	public String checkToken() {
		return "정상 토큰 입니다.";
	}

	@GetMapping("/access-token")
	public ResponseEntity<?> refreshAccessToken(HttpServletRequest request, HttpServletResponse response) {

		String refreshToken = request.getHeader("refresh");

		if (refreshToken != null && refreshToken.startsWith("Bearer ")) {
			refreshToken = refreshToken.substring(7);
		} else {
			return new ResponseEntity<>("no refresh token", HttpStatus.BAD_REQUEST);
		}

		try {
			String newAccessToken = refreshTokenService.validateAndGenerateNewAccessToken(refreshToken);
			Map<String, Object> claims = new HashMap<>();
			claims.put("access", newAccessToken);
			return new ResponseEntity<>(claims, HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
}
