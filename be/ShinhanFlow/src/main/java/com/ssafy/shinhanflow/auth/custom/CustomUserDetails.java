package com.ssafy.shinhanflow.auth.login;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class CustomUserDetails implements UserDetails {
	@Override
	public boolean isAccountNonExpired() {
		// return UserDetails.super.isAccountNonExpired();
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// return UserDetails.super.isAccountNonLocked();
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// return UserDetails.super.isCredentialsNonExpired();
		return true;
	}

	@Override
	public boolean isEnabled() {
		// return UserDetails.super.isEnabled();
		return true;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {

		Collection<GrantedAuthority> collection = new ArrayList<>();
		collection.add(new GrantedAuthority() {
			@Override
			public String getAuthority() {
				return "USER";
			}
		});
		return collection;
	}

	@Override
	public String getPassword() {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder.encode("password");
	}

	@Override
	public String getUsername() {
		return "test-username";
	}
}
