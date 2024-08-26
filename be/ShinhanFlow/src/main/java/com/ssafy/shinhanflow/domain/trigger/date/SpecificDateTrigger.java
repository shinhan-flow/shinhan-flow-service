package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;

public record SpecificDateTrigger(
	@NotNull
	@FutureOrPresent
	LocalDate localDate

) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		return today.isEqual(localDate);
	}

}
