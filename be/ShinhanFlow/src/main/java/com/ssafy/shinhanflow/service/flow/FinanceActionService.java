package com.ssafy.shinhanflow.service.flow;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.FcmMessageRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;
import com.ssafy.shinhanflow.util.FirebaseCloudMessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FinanceActionService {
	private final FirebaseCloudMessageService fcmService;
	private final FinanceApiHeaderGenerator headerGenerator;
	private final MemberRepository memberRepository;
	private final FinanceApiService financeApiService;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public void sendTextNotification(Long memberId, String text) {

		fcmService.sendMessage(FcmMessageRequestDto.builder()
			.memberId(memberId)
			.title("플로우 알림")
			.content(text)
			.build());
	}

	public void sendBalanceNotification(Long memberId, String accountNo) {
		MemberEntity memberEntity = memberRepository.findById(memberId).orElseThrow();
		RequestHeaderDto requestHeaderDto = headerGenerator.createHeader("inquireDemandDepositAccountBalance",
			memberEntity.getUserKey(), "00100");
		CurrentAccountBalanceRequestDto requestDto = CurrentAccountBalanceRequestDto.builder()
			.header(requestHeaderDto)
			.accountNo(accountNo)
			.build();

		Long balance = financeApiService.currentAccountBalance(requestDto).getRec().accountBalance();
		String message = "계좌 잔액이 " + balance + "원 입니다.";
		fcmService.sendMessage(FcmMessageRequestDto.builder()
			.memberId(memberId)
			.title("플로우 알림")
			.content(message)
			.build());
	}

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
