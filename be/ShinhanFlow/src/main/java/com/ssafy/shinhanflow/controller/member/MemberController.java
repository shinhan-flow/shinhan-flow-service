package com.ssafy.shinhanflow.controller.member;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.member.CreditScoreResponseDto;
import com.ssafy.shinhanflow.dto.member.SignUpRequestDto;
import com.ssafy.shinhanflow.service.member.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/members")
@RequiredArgsConstructor
public class MemberController {
	private final MemberService memberService;

	@PostMapping
	public SuccessResponse<Boolean> createMember(@RequestBody SignUpRequestDto signUpRequestDto) {
		return SuccessResponse.of(memberService.createMember(signUpRequestDto));
	}

	@GetMapping("/credit-score")
	public SuccessResponse<CreditScoreResponseDto> getCreditScore(@RequestHeader("Authorization") String token) {
		return SuccessResponse.of(memberService.getCreditScore(token));
	}
}


