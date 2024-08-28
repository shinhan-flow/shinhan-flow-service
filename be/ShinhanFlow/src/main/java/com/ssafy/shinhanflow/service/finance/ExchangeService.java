package com.ssafy.shinhanflow.service.finance;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class ExchangeService {
	private final FinanceApiService financeApiService;
	private final MemberRepository memberRepository;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public ExchangeResponseDto exchange(long userId, String accountNo, String exchangeCurrency,
		Integer exchangeAmount) {
		log.info("exchange - userId: {}, accountNo: {}, exchangeAmount: {}", userId, accountNo, exchangeAmount);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("exchange", userKey, institutionCode);
		ExchangeRequestDto dto = ExchangeRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.exchangeCurrency(exchangeCurrency)
			.exchangeAmount(exchangeAmount)
			.build();

		return financeApiService.exchange(dto);
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
