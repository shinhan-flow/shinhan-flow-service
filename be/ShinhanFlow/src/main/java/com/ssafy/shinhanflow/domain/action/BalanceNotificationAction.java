package com.ssafy.shinhanflow.domain.action;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record BalanceNotificationAction(
	@NotBlank
	String account

) implements Action {
	@Override
	public boolean execute() {
		return true;
	}
}
