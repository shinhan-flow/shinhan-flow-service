package com.ssafy.shinhanflow.domain.trigger.exchange;

import java.math.BigDecimal;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;
import com.ssafy.shinhanflow.util.constants.Currency;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record ExchangeRateTrigger(
	@NotNull
	Currency currency,
	@NotNull
	@Positive
	BigDecimal rate

) implements Trigger {

	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService) {
		// todo: currency로 환율 가져오기
		BigDecimal rate = BigDecimal.valueOf(2.02);
		return this.rate.compareTo(rate) >= 0;
	}

}
