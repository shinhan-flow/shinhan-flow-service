package com.ssafy.shinhanflow.service.finance;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.ExchangeRateEntity;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateResponseDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRatesRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRatesResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.repository.ExchangeRateRepository;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;
import com.ssafy.shinhanflow.util.constants.Currency;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class ExchangeRateService {
	private final FinanceApiService financeApiService;
	private final MemberRepository memberRepository;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;
	private final ExchangeRateRepository exchangeRateRepository;

	public ExchangeRatesResponseDto getExchangeRates() {
		log.info("getExchangeRates");

		// userKey 필요 없음
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("exchangeRate", null, "00100");
		ExchangeRatesRequestDto dto = ExchangeRatesRequestDto.builder()
			.header(header)
			.build();

		return financeApiService.getExchangeRates(dto);
	}

	public ExchangeRateResponseDto getExchangeRate(String currencyCode) {
		log.info("getExchangeRate - currencyCode: {}", currencyCode);
		if (currencyCode == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		// userKey 필요 없음
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("exchangeRate", null, "00100");
		ExchangeRateRequestDto dto = ExchangeRateRequestDto.builder()
			.header(header)
			.currency(Currency.valueOf(currencyCode))
			.build();

		return financeApiService.getExchangeRate(dto);
	}

	/**
	 * 우리 서비스 DB 에서 환율 조회 메서드
	 */
	public List<ExchangeRateDto> getExchangeRatesFromDB() {
		log.info("getExchangeRatesFromDB 호출");
		List<ExchangeRateEntity> exchangeRateList = exchangeRateRepository.findAll();

		List<ExchangeRateDto> list = new ArrayList<>();

		exchangeRateList.forEach(exchangeRate -> {
			ExchangeRateDto dto = ExchangeRateDto.builder()
				.currency(exchangeRate.getCurrency())
				.exchangeRate(exchangeRate.getExchangeRate())
				.exchangeMin(exchangeRate.getExchangeMin())
				.created(exchangeRate.getCreated())
				.build();
			list.add(dto);
		});
		return list;
	}

	/**
	 * 환율 정보 최신화 메서드
	 */
	public void updateExchangeRates() {
		log.info("데이터베이스 환율 정보 최신화 실행");

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("exchangeRate", null, "00100");
		ExchangeRatesRequestDto dto = ExchangeRatesRequestDto.builder()
			.header(header)
			.build();

		// 황율 정보를 가저와서 서비스 DB 에 저장
		List<ExchangeRatesResponseDto.ExchangeRate> exchangeRates = financeApiService.getExchangeRates(dto).getRec();
		exchangeRates.forEach(rate -> {
			ExchangeRateEntity entity = exchangeRateRepository.findByCurrency(rate.getCurrency());
			entity.setExchangeRate(rate.getExchangeRate());
			entity.setExchangeMin(rate.getExchangeMin());
			entity.setCreated(rate.getCreated());

			exchangeRateRepository.save(entity);
		});
	}
}
