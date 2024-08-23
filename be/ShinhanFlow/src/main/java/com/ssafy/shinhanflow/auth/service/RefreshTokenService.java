package com.ssafy.shinhanflow.auth.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;

import io.jsonwebtoken.ExpiredJwtException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {
	private final JWTUtil jwtUtil;

	@Value("${jwt.access.expire-time}")
	private long accessTokenExpireTime;

	public String validateAndGenerateNewAccessToken(String refreshToken) {
		//expired check
		try {
			jwtUtil.isExpired(refreshToken);
		} catch (ExpiredJwtException e) {
			throw new IllegalArgumentException("Refresh token expired");
		}

		// 토큰이 refresh 인지 확인 (발급시 페이로드에 명시)
		String category = jwtUtil.getCategory(refreshToken);
		if (!"refresh".equals(category)) {
			throw new IllegalArgumentException("Invalid refresh token");
		}

		// make new JWT
		long userId = jwtUtil.getUserId(refreshToken);
		String role = jwtUtil.getRole(refreshToken);

		return jwtUtil.createJwt("access", userId, role, accessTokenExpireTime);
	}
}
