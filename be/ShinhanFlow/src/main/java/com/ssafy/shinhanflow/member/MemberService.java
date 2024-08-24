package com.ssafy.shinhanflow.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.dto.SignUpRequestDto;
import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.entity.MemberEntity;
import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.financeapi.FinanceApiFetcher;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	@Value("${finance-api.key}")
	private final String apiKey;
	private final MemberRepository memberRepository;
	private final FinanceApiFetcher financeApiFetcher;

	public MemberResponseDto createMember(SignUpRequestDto signUpRequestDto) {
		MemberRequestDto memberRequestDto = new MemberRequestDto(apiKey, signUpRequestDto.email());
		MemberResponseDto memberResponseDto = financeApiFetcher.createMember(memberRequestDto);
		memberRepository.save(new MemberEntity(memberResponseDto.getUserId(), signUpRequestDto.password(),
			memberResponseDto.getUsername(), memberResponseDto.getUserKey()));
		return memberResponseDto;
	}
}
