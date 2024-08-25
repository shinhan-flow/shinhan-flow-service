package com.ssafy.shinhanflow.service.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.SecurityConfig;
import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.member.SignUpRequestDto;
import com.ssafy.shinhanflow.entity.MemberEntity;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	@Value("${finance-api.key}")
	private String apiKey;
	private final MemberRepository memberRepository;
	private final FinanceApiService financeApiFetcher;
	private final SecurityConfig securityConfig;

	public Boolean createMember(SignUpRequestDto signUpRequestDto) {
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
		return true;
	}
}
