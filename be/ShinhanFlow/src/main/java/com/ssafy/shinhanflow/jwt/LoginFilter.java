package com.ssafy.shinhanflow.jwt;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class LoginFilter extends UsernamePasswordAuthenticationFilter {

	private final AuthenticationManager authenticationManager;
	private final JWTUtil jwtUtil;

	private final long ACCESS_TOKEN_EXPIRE_TIME = 30 * 1000L; // 30초
	private final long REFRESH_TOKEN_EXPIRE_TIME = 60 * 1000L; // 1분

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws
		AuthenticationException {

		//로그인 요청에서 username, password 추출
		String username = obtainUsername(request);
		String password = obtainPassword(request);

		// username 과 password 를 검증하기 위해 token 에 담아서 사용 (스프링 시큐리티에서)
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password,
			null);

		return authenticationManager.authenticate(authToken);
	}

	//로그인 성공시 실행하는 메소드 (JWT 발급)
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
		Authentication authentication) {

		String username = authentication.getName();
		log.info("{} login 요청 성공", username);

		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();

		//토큰 생성
		String access = jwtUtil.createJwt("access", username, role, ACCESS_TOKEN_EXPIRE_TIME);
		String refresh = jwtUtil.createJwt("refresh", username, role, REFRESH_TOKEN_EXPIRE_TIME);

		// 응답 설정
		response.setHeader("access", access);
		response.setHeader("refresh", refresh);
		response.setStatus(HttpStatus.OK.value());
	}

	//로그인 실패시 실행하는 메소드
	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
		AuthenticationException failed) {
		log.info("login 요청 실패");
		response.setStatus(HttpStatus.UNAUTHORIZED.value());
	}
}