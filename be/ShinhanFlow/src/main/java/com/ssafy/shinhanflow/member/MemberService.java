package com.ssafy.shinhanflow.member;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.util.FinanceApiFetcher;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	private final FinanceApiFetcher financeApiFetcher;

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) {
		return financeApiFetcher.createMember(memberRequestDto);
	}
}
