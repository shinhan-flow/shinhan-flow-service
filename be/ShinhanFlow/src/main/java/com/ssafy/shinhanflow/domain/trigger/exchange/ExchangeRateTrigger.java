package com.ssafy.shinhanflow.domain.trigger.exchange;

import java.math.BigDecimal;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.util.constants.Currency;

import lombok.NonNull;

public record ExchangeRateTrigger(@NonNull Currency currency, @NonNull BigDecimal rate) implements Trigger {

	@Override
	public boolean isTriggered() {
		// todo: currency로 환율 가져오기
		BigDecimal rate = BigDecimal.valueOf(2.02);
		return this.rate.compareTo(rate) >= 0;
	}

}
