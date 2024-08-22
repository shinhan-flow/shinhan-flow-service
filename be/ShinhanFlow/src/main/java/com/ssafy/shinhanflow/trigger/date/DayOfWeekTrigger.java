package com.ssafy.shinhanflow.trigger.date;

import java.time.DayOfWeek;
import java.time.LocalDate;

import com.ssafy.shinhanflow.trigger.Trigger;

public record DayOfWeekTrigger(DayOfWeek[] dayOfWeek) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		DayOfWeek todayOfWeek = today.getDayOfWeek();

		for(DayOfWeek day: dayOfWeek){
			if (todayOfWeek.equals(day)){
				return true;
			}

		}
		return false;
	}
}
