package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.service.flow.FlowActionService;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record BalanceNotificationAction(
	@NotBlank
	String account

) implements Action {
	@Override
	public boolean execute(FlowActionService flowActionService) {
		return true;
	}
}
