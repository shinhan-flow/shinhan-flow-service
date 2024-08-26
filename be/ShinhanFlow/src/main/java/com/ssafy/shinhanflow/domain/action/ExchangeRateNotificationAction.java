package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.util.constants.Currency;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record ExchangeRateNotificationAction(
	@NotNull
	Currency currency

) implements Action {

	@Override
	public boolean execute() {
		return false;
	}
}
