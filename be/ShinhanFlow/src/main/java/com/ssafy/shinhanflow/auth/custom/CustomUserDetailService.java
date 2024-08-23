package com.ssafy.shinhanflow.auth.custom;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CustomUserDetailService implements UserDetailsService {
	//TODO: UserRepository 를 주입받아서 로그인 처리 로직 작성하기
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		// UserRepository 에서 username 으로 DB에서 유저 정보를 가져와서 UserDetails 객체를 만들어서 리턴
		if (username != null) {
			//일단 전부 로그인 처리
			log.info("loadUserByUsername: {}", username);
			return new CustomUserDetails();
		}
		return null;
	}
}
