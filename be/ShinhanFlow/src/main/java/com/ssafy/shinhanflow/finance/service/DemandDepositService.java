package com.ssafy.shinhanflow.finance.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.entity.MemberEntity;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositBalanceRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositBalanceResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositHolderRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositHolderResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositResponseDto;
import com.ssafy.shinhanflow.finance.dto.header.RequestHeaderDto;
import com.ssafy.shinhanflow.util.FinanceApiFetcher;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class DemandDepositService {

	private final FinanceApiFetcher financeApiFetcher;
	private final MemberRepository memberRepository;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public DemandDepositResponseDto createDemandDepositAccount(long userId, String accountTypeUniqueNo) {

		log.info("createDemandDepositAccount - userId: {}, accountTypeUniqueNo: {}", userId, accountTypeUniqueNo);
		if (accountTypeUniqueNo == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("createDemandDepositAccount", userKey,
			institutionCode);
		DemandDepositRequestDto dto = DemandDepositRequestDto.builder()
			.header(header)
			.accountTypeUniqueNo(accountTypeUniqueNo)
			.build();

		return financeApiFetcher.createDemandDepositAccount(dto);
	}

	public DemandDepositHolderResponseDto inquireDemandDepositAccountHolderName(long userId, String accountNo) {

		log.info("inquireDemandDepositAccountHolderName - userId: {}, accountNo: {}", userId, accountNo);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDemandDepositAccountHolderName",
			userKey,
			institutionCode);
		DemandDepositHolderRequestDto dto = DemandDepositHolderRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.inquireDemandDepositAccountHolderName(dto);
	}

	public DemandDepositBalanceResponseDto inquireDemandDepositAccountBalance(long userId, String accountNo) {

		log.info("inquireDemandDepositAccountBalance - userId: {}, accountNo: {}", userId, accountNo);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDemandDepositAccountBalance", userKey,
			institutionCode);
		DemandDepositBalanceRequestDto dto = DemandDepositBalanceRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.inquireDemandDepositAccountBalance(dto);
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
