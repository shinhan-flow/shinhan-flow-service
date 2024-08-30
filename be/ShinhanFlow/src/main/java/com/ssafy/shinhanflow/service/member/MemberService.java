package com.ssafy.shinhanflow.service.member;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.SecurityConfig;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreRequestDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreResponseDto;
import com.ssafy.shinhanflow.dto.member.SignUpRequestDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
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
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;
	private final JWTUtil jwtUtil;

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

	public CreditScoreResponseDto getCreditScore(String token) {
		long userId = jwtUtil.getId(token);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireMyCreditRating", userKey,
			institutionCode);
		CreditScoreRequestDto dto = CreditScoreRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.getCreditScore(dto);
	}

	private MemberEntity findMemberOrThrow(long userId) {
		Optional<MemberEntity> memberEntityOptional = memberRepository.findById(userId);
		if (memberEntityOptional.isEmpty()) {
			throw new BadRequestException(ErrorCode.NOT_FOUND);
		} else {
			return memberEntityOptional.get();
		}
	}
}
