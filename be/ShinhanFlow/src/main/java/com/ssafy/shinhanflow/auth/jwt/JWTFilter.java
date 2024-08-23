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
		String accessToken = request.getHeader("Authorization");

		if (accessToken != null && accessToken.startsWith("Bearer ")) {
			accessToken = accessToken.substring(7);
		} else {
			filterChain.doFilter(request, response);
			return;
		}

		// TODO: 토큰 에러 발생시 상태코드 정하기
		try {
			jwtUtil.isExpired(accessToken);
			String category = jwtUtil.getCategory(accessToken);
			if (!"access".equals(category)) {
				throw new Exception();
			}
		} catch (ExpiredJwtException e) { //토큰 만료
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"token has expired.\"}");
			return;
		} catch (Exception e) { // 잘못된 토큰
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"invalid token.\"}");
			return;
		}

		// 토큰 검증 완료 후 토큰에서 userId 추출
		String userId = jwtUtil.getUserId(accessToken);

		// 추출한 userId로 회원 정보 조회
		Optional<MemberEntity> byId = memberRepository.findById(Long.parseLong(userId));

		// 회원 정보가 없을 경우
		if (byId.isEmpty()) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"no user\"}");
			return;
		}

		// 회원 정보가 있으면 SecurityContextHolder 에 회원 정보 저장
		MemberEntity memberEntity = byId.get();

		CustomUserDetails customUserDetails = new CustomUserDetails(memberEntity);
		Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null,
			customUserDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authToken);

		filterChain.doFilter(request, response);

	}
}
