package com.ssafy.shinhanflow.finance;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
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

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class FinanceService {
	@Value("${finance-api.key}")
	private String apiKey;

	private final FinanceApiFetcher financeApiFetcher;
	private final MemberRepository memberRepository;

	public DemandDepositResponseDto createDemandDepositAccount(long userId, String accountTypeUniqueNo) {

		log.info("createDemandDepositAccount - userId: {}, accountTypeUniqueNo: {}", userId, accountTypeUniqueNo);
		if (accountTypeUniqueNo == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = generateHeader("createDemandDepositAccount", userKey, institutionCode);
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

		RequestHeaderDto header = generateHeader("inquireDemandDepositAccountHolderName", userKey, institutionCode);
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

		RequestHeaderDto header = generateHeader("inquireDemandDepositAccountBalance", userKey, institutionCode);
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

	private RequestHeaderDto generateHeader(String apiName, String userKey, String institutionCode) {
		LocalDateTime now = LocalDateTime.now();
		String datePart = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String timePart = now.format(DateTimeFormatter.ofPattern("HHmmss"));
		Random random = new Random();
		int randomNumber = random.nextInt(1000000);
		String formattedNumber = String.format("%06d", randomNumber);

		return RequestHeaderDto.builder()
			.apiName(apiName)
			.transmissionDate(datePart)
			.transmissionTime(timePart)
			.institutionCode(institutionCode)
			.fintechAppNo("001")
			.apiServiceCode(apiName)
			.institutionTransactionUniqueNo(datePart + timePart + formattedNumber)
			.apiKey(apiKey)
			.userKey(userKey)
			.build();
	}

}
