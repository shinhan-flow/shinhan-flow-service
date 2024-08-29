package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.service.flow.FinanceActionService;
import com.ssafy.shinhanflow.util.constants.Currency;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Builder
public record ExchangeAction(
	@NotNull
	Currency currency,

	@NotBlank
	String fromAccount,

	@NotNull
	@Positive
	Long amount

) implements Action {
	@Override
	public boolean execute(FinanceActionService financeActionService, Long userId) {
		financeActionService.exchange(userId, fromAccount, currency.name(), amount.intValue());
		return true;
	}
}
