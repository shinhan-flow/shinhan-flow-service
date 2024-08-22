package com.ssafy.shinhanflow.trigger.exchange;

import java.math.BigDecimal;

import com.ssafy.shinhanflow.trigger.Trigger;

public record ExchangeRateTrigger(Currency currency, BigDecimal rate) implements Trigger {

	@Override
	public boolean isTriggered() {
		// todo: currency로 환율 가져오기
		BigDecimal rate = BigDecimal.valueOf(2.02);
		return this.rate.compareTo(rate) >= 0;
	}

	public enum Currency{
		USD, EUR, JPY, CNY, GBP, CHF, CAD
	}
}
