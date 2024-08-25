package com.ssafy.shinhanflow.flow.action;

import com.ssafy.shinhanflow.flow.trigger.exchange.ExchangeRateTrigger.Currency;

import lombok.Builder;

@Builder
public record ExchangeAction(
	Long memberId,
	Long flowId,
	Currency currency,
	String fromAccount,
	Long amount

) implements Action {
	@Override
	public boolean execute() {
		return false;
	}
}
