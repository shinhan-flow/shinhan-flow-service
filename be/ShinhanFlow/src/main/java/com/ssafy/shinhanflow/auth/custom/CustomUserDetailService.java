package com.ssafy.shinhanflow.auth.custom;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.entity.MemberEntity;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

	private final MemberRepository memberRepository;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		MemberEntity userData = memberRepository.findByEmail(email);

		// 사용자가 없을 경우 예외 발생
		if (userData == null) {
			log.error("User not found with email: {}", email);
			throw new UsernameNotFoundException("User not found with email: " + email);
		}

		// 사용자가 존재할 경우, CustomUserDetails 객체에 user 정보를 넣어서 반환
		return new CustomUserDetails(userData);
	}
}
