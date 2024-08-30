package com.ssafy.shinhanflow.auth.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.dto.UserDetailDto;
import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.repository.MemberRepository;

import io.jsonwebtoken.ExpiredJwtException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {
	private final JWTUtil jwtUtil;
	private final MemberRepository memberRepository;

	@Value("${jwt.access.expire-time}")
	private long accessTokenExpireTime;

	public String validateAndGenerateNewAccessToken(String refreshToken) {

		// 토큰 형태 검증
		if (refreshToken == null || !refreshToken.startsWith("Bearer")) {
			throw new BadRequestException(ErrorCode.INVALID_TOKEN);
		}

		refreshToken = refreshToken.substring(7);

		String category = jwtUtil.getCategory(refreshToken);
		if (!"refresh".equals(category)) {
			throw new BadRequestException(ErrorCode.INVALID_TOKEN);
		}

		// 만료됐는지 확인
		try {
			jwtUtil.isExpired(refreshToken);
		} catch (ExpiredJwtException e) {
			throw new BadRequestException(ErrorCode.EXPIRED_TOKEN);
		}
		// make new JWT
		long userId = jwtUtil.getUserId(refreshToken);
		String role = jwtUtil.getRole(refreshToken);

		return jwtUtil.createJwt("access", userId, role, accessTokenExpireTime);
	}

	public UserDetailDto getUserInfoFromToken(String token) {

		long userId = jwtUtil.getId(token);

		MemberEntity memberEntity = memberRepository.findById(userId)
			.orElseThrow(() -> new BadRequestException(ErrorCode.NOT_FOUND));

		LocalDate localDate = memberEntity.getCreatedAt().toLocalDate();
		String createdAt = localDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		return UserDetailDto.builder()
			.name(memberEntity.getName())
			.email(memberEntity.getEmail())
			.createdAt(createdAt)
			.build();
	}
}
