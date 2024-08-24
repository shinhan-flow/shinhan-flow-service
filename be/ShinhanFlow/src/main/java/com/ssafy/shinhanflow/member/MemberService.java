package com.ssafy.shinhanflow.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.config.SecurityConfig;
import com.ssafy.shinhanflow.entity.MemberEntity;
import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.member.dto.SignUpRequestDto;
import com.ssafy.shinhanflow.util.FinanceApiFetcher;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	@Value("${finance-api.key}")
	private String apiKey;
	private final MemberRepository memberRepository;
	private final FinanceApiFetcher financeApiFetcher;
	private final SecurityConfig securityConfig;

	public MemberResponseDto createMember(SignUpRequestDto signUpRequestDto) {
		// communicate with finance api
		MemberRequestDto memberRequestDto = new MemberRequestDto(apiKey, signUpRequestDto.email());
		MemberResponseDto memberResponseDto = financeApiFetcher.createMember(memberRequestDto);
		// save member info
		MemberEntity memberEntity = MemberEntity.builder()
			.email(signUpRequestDto.email())
			.password(securityConfig.bCryptPasswordEncoder().encode(signUpRequestDto.password()))
			.name(signUpRequestDto.name())
			.userKey(memberResponseDto.getUserKey())
			.build();
		memberRepository.save(memberEntity);
		// return response
		return memberResponseDto;
	}
}
