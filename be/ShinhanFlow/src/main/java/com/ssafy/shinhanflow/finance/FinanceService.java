package com.ssafy.shinhanflow.finance;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
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
	@Value("${finance.api-key}")
	private String apiKey;
	// private String apiKey = "317ea1cf50b044559dbeaa4de319fe52";

	private final FinanceApiFetcher financeApiFetcher;
	private final MemberRepository memberRepository;

	public DemandDepositResponseDto createDemandDepositAccount(long userId, String accountTypeUniqueNo) {

		log.info("createDemandDepositAccount - userId: {}, accountTypeUniqueNo: {}", userId, accountTypeUniqueNo);
		if (accountTypeUniqueNo == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		String userKey = memberRepository.findUserKeyById(userId);
		if (userKey == null) {
			throw new BadRequestException(ErrorCode.NOT_FOUND);
		}

		RequestHeaderDto header = generateHeader("createDemandDepositAccount", userKey);
		DemandDepositRequestDto dto = DemandDepositRequestDto.builder()
			.header(header)
			.accountTypeUniqueNo(accountTypeUniqueNo)
			.build();

		return financeApiFetcher.createDemandDepositAccount(dto);
	}

	public DemandDepositHolderResponseDto inquireDemandDepositAccountHolderName(long userId, String accountNo) {

		String userKey = memberRepository.findUserKeyById(userId);
		if (userKey == null) {
			throw new BadRequestException(ErrorCode.NOT_FOUND);
		}

		RequestHeaderDto header = generateHeader("inquireDemandDepositAccountHolderName", userKey);
		DemandDepositHolderRequestDto dto = DemandDepositHolderRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.inquireDemandDepositAccountHolderName(dto);
	}

	public DemandDepositBalanceResponseDto inquireDemandDepositAccountBalance(long userId, String accountNo) {

		String userKey = memberRepository.findUserKeyById(userId);
		if (userKey == null) {
			throw new BadRequestException(ErrorCode.NOT_FOUND);
		}

		RequestHeaderDto header = generateHeader("inquireDemandDepositAccountBalance", userKey);
		DemandDepositBalanceRequestDto dto = DemandDepositBalanceRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.inquireDemandDepositAccountBalance(dto);
	}

	private RequestHeaderDto generateHeader(String apiName, String userKey) {
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
			.institutionCode("00100")
			.fintechAppNo("001")
			.apiServiceCode(apiName)
			.institutionTransactionUniqueNo(datePart + timePart + formattedNumber)
			.apiKey(apiKey)
			.userKey(userKey)
			.build();
	}

}
