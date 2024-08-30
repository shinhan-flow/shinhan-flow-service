package com.ssafy.shinhanflow.auth.jwt;

import static com.ssafy.shinhanflow.auth.jwt.JWTResponse.respondWithError;

import java.io.IOException;
import java.util.Optional;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.ssafy.shinhanflow.auth.custom.CustomUserDetails;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.ErrorResponse;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.repository.MemberRepository;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class JWTFilter extends OncePerRequestFilter {
	private final JWTUtil jwtUtil;
	private final MemberRepository memberRepository;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
		FilterChain filterChain) throws ServletException, IOException {

		// 헤더에서 Authorization 에 담긴 토큰을 꺼냄
		String accessToken = extractToken(request);

		// 토큰이 없을 경우
		if (accessToken == null) {
			filterChain.doFilter(request, response);
			return;
		}

		// 토큰 검증
		try {
			validateToken(accessToken);
		} catch (ExpiredJwtException e) { //토큰 만료
			respondWithError(response, ErrorResponse.of(ErrorCode.EXPIRED_TOKEN));
			return;
		} catch (JwtException e) { // 잘못된 토큰
			respondWithError(response, ErrorResponse.of(ErrorCode.INVALID_TOKEN));
			return;
		}

		// 토큰 검증 완료 후 토큰에서 userId 추출
		Long userId = jwtUtil.getUserId(accessToken);

		log.info("userId: {}", userId);

		// 추출한 userId로 회원 정보 조회
		Optional<MemberEntity> memberOptional = memberRepository.findById(userId);

		// 회원 정보가 없을 경우
		if (memberOptional.isEmpty()) {
			respondWithError(response, ErrorResponse.of(ErrorCode.NOT_FOUND));
			return;
		}

		// 회원 정보가 있으면 SecurityContextHolder 에 회원 정보 저장
		MemberEntity memberEntity = memberOptional.get();
		setAuthentication(memberEntity);

		filterChain.doFilter(request, response);

	}

	private String extractToken(HttpServletRequest request) {
		String header = request.getHeader("Authorization");
		if (header != null && header.startsWith("Bearer ")) {
			return header.substring(7);
		}
		return null;
	}

	private void validateToken(String token) {
		try {
			jwtUtil.isExpired(token);
		} catch (ExpiredJwtException e) {
			throw new BadRequestException(ErrorCode.EXPIRED_TOKEN);
		}
		String category = jwtUtil.getCategory(token);
		if (!"access".equals(category)) {
			throw new BadRequestException(ErrorCode.INVALID_TOKEN);
		}
	}

	private void setAuthentication(MemberEntity memberEntity) {
		CustomUserDetails customUserDetails = new CustomUserDetails(memberEntity);
		Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null, null);
		SecurityContextHolder.getContext().setAuthentication(authToken);
	}
}
