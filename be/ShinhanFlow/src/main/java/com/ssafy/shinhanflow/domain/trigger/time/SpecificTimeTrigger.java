package com.ssafy.shinhanflow.domain.trigger.time;

import java.time.LocalTime;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import jakarta.validation.constraints.NotNull;

public record SpecificTimeTrigger(
	@NotNull
	LocalTime time

) implements Trigger {

	@Override
	public boolean isTriggered() {
		LocalTime now = LocalTime.now();
		return this.time.getHour() == now.getHour();
	}
}
