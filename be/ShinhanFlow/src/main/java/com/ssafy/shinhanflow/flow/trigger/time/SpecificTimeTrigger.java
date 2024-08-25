package com.ssafy.shinhanflow.flow.trigger.time;

import java.time.LocalTime;

import com.ssafy.shinhanflow.flow.trigger.Trigger;

public record SpecificTimeTrigger(LocalTime time) implements Trigger {

	@Override
	public boolean isTriggered() {
		LocalTime now = LocalTime.now();
		return this.time.getHour() == now.getHour();
	}
}
