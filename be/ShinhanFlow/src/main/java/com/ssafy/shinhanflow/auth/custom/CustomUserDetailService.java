package com.ssafy.shinhanflow.auth.custom;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.NotFoundException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.repository.MemberRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

	private final MemberRepository memberRepository;

	/**
	 * 로그인을 하면 로그인 정보(username == email)를 기준으로 DB에서 사용자 정보를 가져옴
	 * 가져온 사용자 정보는 CustomUserDetails 객체에 담아서 반환
	 */
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		MemberEntity userData = memberRepository.findByEmail(email).orElseThrow(
			() -> new NotFoundException(ErrorCode.NOT_FOUND)
		);
		// 사용자가 존재할 경우, CustomUserDetails 객체에 user 정보를 넣어서 반환
		return new CustomUserDetails(userData);
	}
}
