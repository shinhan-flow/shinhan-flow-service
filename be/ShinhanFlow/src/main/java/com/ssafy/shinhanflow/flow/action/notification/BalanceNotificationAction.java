package com.ssafy.shinhanflow.flow.action.notification;

import com.ssafy.shinhanflow.flow.action.Action;

import lombok.Builder;

@Builder
public record BalanceNotificationAction(
	Long memberId,
	Long flowId,
	String account

) implements Action {
	@Override
	public boolean execute() {
		return true;
	}
}
