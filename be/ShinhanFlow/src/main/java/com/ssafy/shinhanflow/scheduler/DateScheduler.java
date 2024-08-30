package com.ssafy.shinhanflow.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ssafy.shinhanflow.repository.TriggerRepository;
import com.ssafy.shinhanflow.service.finance.ExchangeRateService;
import com.ssafy.shinhanflow.util.TriggerChecker;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class DateScheduler {

	private final TriggerChecker triggerChecker;
	private final TriggerRepository triggerRepository;
	private final ExchangeRateService exchangeRateService;

	@Scheduled(cron = "*/5 * * * * *")
	public void checkDateTrigger() {
		triggerChecker.run();
	}

	/**
	 * 환율 업데이트
	 * 현재 금융망 API의 경우 매 6분 45초경에 환율 정보가 초기화됨
	 * 따라서 매 7분 마다 환율 정보를 가저오도록 스케줄링함
	 */
	@Scheduled(cron = "0 7,17,27,37,47,57 * * * *")
	public void updateExchangeRates() {
		exchangeRateService.updateExchangeRates();
	}

}
