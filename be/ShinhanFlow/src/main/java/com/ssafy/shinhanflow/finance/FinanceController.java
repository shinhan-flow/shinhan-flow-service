package com.ssafy.shinhanflow.finance;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/")
@RequiredArgsConstructor
public class FinanceController {
	private final FinanceService financeService;

	@PostMapping("/member")
	public MemberResponseDto createMember(@RequestBody MemberRequestDto memberRequestDto) {
		return financeService.createMember(memberRequestDto);
	}
}
