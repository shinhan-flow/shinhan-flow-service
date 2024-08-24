package com.ssafy.shinhanflow.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.entity.MemberEntity;
import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.financeapi.FinanceApiFetcher;
import com.ssafy.shinhanflow.member.dto.SignUpRequestDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	@Value("${finance-api.key}")
	private String apiKey;
	private final MemberRepository memberRepository;
	private final FinanceApiFetcher financeApiFetcher;

	public MemberResponseDto createMember(SignUpRequestDto signUpRequestDto) {
		// communicate with finance api
		MemberRequestDto memberRequestDto = new MemberRequestDto(apiKey, signUpRequestDto.email());
		MemberResponseDto memberResponseDto = financeApiFetcher.createMember(memberRequestDto);
		// save member info
		MemberEntity memberEntity = new MemberEntity(memberResponseDto.getUserId(), signUpRequestDto.password(),
			signUpRequestDto.name(), memberResponseDto.getUserKey());
		memberRepository.save(memberEntity);
		// return response
		return memberResponseDto;
	}
}
