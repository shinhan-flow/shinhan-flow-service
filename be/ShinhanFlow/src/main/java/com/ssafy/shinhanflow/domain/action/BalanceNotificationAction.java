package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.service.flow.FinanceActionService;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record BalanceNotificationAction(
	@NotBlank
	String account

) implements Action {
	@Override
	public boolean execute(FinanceActionService financeActionService, Long memberId) {
		financeActionService.sendBalanceNotification(memberId, account);
		return true;
	}
}
