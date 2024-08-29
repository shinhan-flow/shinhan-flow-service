package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.service.flow.FinanceActionService;
import com.ssafy.shinhanflow.util.constants.Currency;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record ExchangeRateNotificationAction(
	@NotNull
	Currency currency

) implements Action {

	@Override
	public boolean execute(FinanceActionService financeActionService, Long memberId) {
		financeActionService.sendExchangeRateNotification(memberId, currency.name());
		return true;
	}
}
