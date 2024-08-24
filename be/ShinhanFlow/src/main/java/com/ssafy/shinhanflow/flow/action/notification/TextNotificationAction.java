package com.ssafy.shinhanflow.flow.action.notification;

import com.ssafy.shinhanflow.flow.action.Action;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record TextNotificationAction(
	Long memberId,
	Long flowId,
	@NotBlank
	String text

) implements Action {

	@Override
	public boolean execute() {
		return false;
	}
}
