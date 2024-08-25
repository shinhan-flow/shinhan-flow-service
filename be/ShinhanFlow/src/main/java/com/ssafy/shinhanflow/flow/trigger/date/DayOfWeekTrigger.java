package com.ssafy.shinhanflow.flow.trigger.date;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.flow.trigger.Trigger;

import lombok.NonNull;

public record DayOfWeekTrigger(@NonNull Set<DayOfWeek> daysOfWeek) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		DayOfWeek todayOfWeek = today.getDayOfWeek();

		for(DayOfWeek day: daysOfWeek){
			if (todayOfWeek.equals(day)){
				return true;
			}

		}
		return false;
	}
}
