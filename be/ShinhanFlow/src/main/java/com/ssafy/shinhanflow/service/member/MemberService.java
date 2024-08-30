package com.ssafy.shinhanflow.service.member;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.SecurityConfig;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.CreditScoreEntity;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreRequestDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreResponseDto;
import com.ssafy.shinhanflow.dto.member.SignUpRequestDto;
import com.ssafy.shinhanflow.repository.CreditScoreRepository;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class MemberService {
	@Value("${finance-api.key}")
	private String apiKey;
	private final MemberRepository memberRepository;
	private final FinanceApiService financeApiFetcher;
	private final SecurityConfig securityConfig;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;
	private final JWTUtil jwtUtil;
	private final CreditScoreRepository creditScoreRepository;

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

	public CreditScoreResponseDto getCreditScoreFromDB(String token) {
		CreditScoreResponseDto creditScore;
		long userId = jwtUtil.getId(token);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();
		LocalDateTime now = LocalDateTime.now();

		CreditScoreEntity creditScoreEntity = creditScoreRepository.findByMemberId(userId);
		// 우리 데이터베이스에 없거나 updateAt 이 하루 이상 지난 경우
		if (creditScoreEntity == null || creditScoreEntity.getUpdatedAt().plusDays(1).isBefore(now)) {
			// finance api 에서 조회
			creditScore = getCreditScore(token);
			// 우리 데이터베이스에 저장 및 업데이트
			creditScoreEntity = creditScoreEntity.builder()
				.id(userId)
				.ratingName(creditScore.getRec().ratingName())
				.demandDepositAssetValue(creditScore.getRec().demandDepositAssetValue())
				.depositSavingsAssetValue(creditScore.getRec().depositSavingsAssetValue())
				.totalAssetValue(creditScore.getRec().totalAssetValue())
				.memberId(userId)
				.build();
			creditScoreRepository.save(creditScoreEntity);
		} else {
			// 우리 데이터베이스에서 조회
			creditScore = CreditScoreResponseDto.builder()
				.rec(new CreditScoreResponseDto.Rec(creditScoreEntity.getRatingName(),
					creditScoreEntity.getDemandDepositAssetValue(), creditScoreEntity.getDepositSavingsAssetValue(),
					creditScoreEntity.getTotalAssetValue()))
				.build();
		}
		return creditScore;
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
