package com.ssafy.shinhanflow.flow.action.notification;

import com.ssafy.shinhanflow.flow.action.Action;
import com.ssafy.shinhanflow.flow.trigger.exchange.ExchangeRateTrigger.Currency;

import lombok.Builder;

@Builder
public record ExchangeRateNotificationAction(
	Long memberId,
	Long flowId,
	Currency currency

) implements Action {

	@Override
	public boolean execute() {
		return false;
	}
}
