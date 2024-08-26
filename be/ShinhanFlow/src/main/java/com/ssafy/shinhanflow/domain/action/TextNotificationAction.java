package com.ssafy.shinhanflow.domain.action;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record TextNotificationAction(
	@NotBlank
	String text

) implements Action {

	@Override
	public boolean execute() {
		return false;
	}
}
