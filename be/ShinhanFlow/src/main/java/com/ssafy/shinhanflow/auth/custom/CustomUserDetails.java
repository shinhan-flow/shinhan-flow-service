package com.ssafy.shinhanflow.auth.custom;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.ssafy.shinhanflow.domain.entity.MemberEntity;

import lombok.RequiredArgsConstructor;

/**
 * UserDetails를 상속받아 CustomUserDetails를 만들어 사용자 정보를 담는다.
 */
@RequiredArgsConstructor
public class CustomUserDetails implements UserDetails {

	private final MemberEntity memberEntity;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
	}

	@Override
	public String getPassword() {
		return memberEntity.getPassword();
	}

	@Override
	public String getUsername() {
		return memberEntity.getEmail();
	}

	public long getUserId() {
		return memberEntity.getId();
	}

	public String getFcmToken() {
		return memberEntity.getFcmToken();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

}
