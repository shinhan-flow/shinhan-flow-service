package com.ssafy.shinhanflow.auth.jwt;

import java.io.IOException;
import java.util.Optional;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.ssafy.shinhanflow.auth.custom.CustomUserDetails;
import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.entity.MemberEntity;

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
			handleException(response, HttpServletResponse.SC_UNAUTHORIZED, "Token has expired.");
			return;
		} catch (JwtException e) { // 잘못된 토큰
			handleException(response, HttpServletResponse.SC_UNAUTHORIZED, "Invalid token.");
			return;
		}

		// 토큰 검증 완료 후 토큰에서 userId 추출
		long userId = jwtUtil.getUserId(accessToken);

		log.info("userId: {}", userId);

		// 추출한 userId로 회원 정보 조회
		Optional<MemberEntity> memberOptional = memberRepository.findById(userId);

		// 회원 정보가 없을 경우
		if (memberOptional.isEmpty()) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"no user\"}");
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
			throw new JwtException("Refresh token expired");
		}
		String category = jwtUtil.getCategory(token);
		if (!"access".equals(category)) {
			throw new JwtException("Invalid token category.");
		}
	}

	private void handleException(HttpServletResponse response, int status, String message) throws IOException {
		log.error("error: {}", message);
		response.setStatus(status);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"error\": \"" + message + "\"}");
	}

	private void setAuthentication(MemberEntity memberEntity) {
		CustomUserDetails customUserDetails = new CustomUserDetails(memberEntity);
		Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null,
			customUserDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authToken);
	}
}
