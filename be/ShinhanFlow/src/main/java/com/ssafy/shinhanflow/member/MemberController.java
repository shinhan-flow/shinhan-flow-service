package com.ssafy.shinhanflow.member;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.member.dto.SignUpRequestDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/members")
@RequiredArgsConstructor
public class MemberController {
	private final MemberService memberService;

	@PostMapping
	public SuccessResponse<MemberResponseDto> createMember(@RequestBody SignUpRequestDto signUpRequestDto) {
		return SuccessResponse.of(memberService.createMember(signUpRequestDto));
	}
}
