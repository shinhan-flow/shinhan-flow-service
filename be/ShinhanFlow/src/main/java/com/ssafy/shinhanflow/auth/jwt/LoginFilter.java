package com.ssafy.shinhanflow.auth.jwt;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.auth.custom.CustomUserDetails;
import com.ssafy.shinhanflow.auth.dto.LoginSuccessResponseDto;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.ErrorResponse;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.repository.MemberRepository;

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
	private final long accessTokenExpireTime;
	private final long refreshTokenExpireTime;
	private final MemberRepository memberRepository;

	// 로그인 요청시 실행되는 메소드
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws
		AuthenticationException {

		//로그인 요청에서 username, password 추출
		String username = obtainUsername(request);
		String password = obtainPassword(request);

		// username 과 password 를 검증하기 위해 token 에 담아서 사용 (스프링 시큐리티에서)
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password);
		return authenticationManager.authenticate(authToken);
	}

	//로그인 성공시 실행하는 메소드 (JWT 발급)
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
		Authentication authentication) {

		CustomUserDetails userDetails = (CustomUserDetails)authentication.getPrincipal();

		// 사용자 이름 , 사용자 ID, fcmToken 을 가져옵니다.
		String username = userDetails.getUsername();
		long userId = userDetails.getUserId();
		String fcmToken = request.getParameter("fcmToken");

		log.info("username: {}, useId: {}, fcmToken: {} login 요청 성공", username, userId, fcmToken);

		// fcmToken DB에 저장
		Optional<MemberEntity> memberEntityOptional = memberRepository.findById(userId);
		if (memberEntityOptional.isPresent()) {
			MemberEntity memberEntity = memberEntityOptional.get();
			memberEntity.setFcmToken(fcmToken);
			memberRepository.save(memberEntity);
		}
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();

		//토큰 생성
		String accessToken = jwtUtil.createJwt("access", userId, role, accessTokenExpireTime);
		String refreshToken = jwtUtil.createJwt("refresh", userId, role, refreshTokenExpireTime);

		// 로그인 성공 응답 생성
		LoginSuccessResponseDto loginSuccessResponseDto = LoginSuccessResponseDto.builder()
			.accessToken(accessToken)
			.refreshToken(refreshToken)
			.build();

		// 성공 응답, 토큰 전송
		respondWithSuccess(response, SuccessResponse.of(loginSuccessResponseDto));
	}

	//로그인 실패시 실행하는 메소드
	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
		AuthenticationException failed) {

		log.error("login 요청 실패");
		respondWithError(response, ErrorResponse.of(ErrorCode.INVALID_CREDENTIALS));

	}

	private static <LoginSuccessResponseDto> void respondWithSuccess(HttpServletResponse response,
		SuccessResponse<LoginSuccessResponseDto> successResponse) {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try {
			String jsonResponse = new ObjectMapper().writeValueAsString(successResponse);
			response.setStatus(successResponse.getCode().value());
			response.getWriter().write(jsonResponse);
		} catch (IOException e) {
			log.error("Error writing JSON response", e);
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
	}

	private static void respondWithError(HttpServletResponse response, ErrorResponse errorResponse) {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try {
			String jsonResponse = new ObjectMapper().writeValueAsString(errorResponse);
			response.setStatus(HttpStatus.BAD_REQUEST.value());
			response.getWriter().write(jsonResponse);
		} catch (IOException e) {
			log.error("Error writing JSON response", e);
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
	}

}