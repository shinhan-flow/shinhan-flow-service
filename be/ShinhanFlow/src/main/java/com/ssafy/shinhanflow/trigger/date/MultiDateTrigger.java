package com.ssafy.shinhanflow.trigger.date;

import java.time.LocalDate;
import java.util.List;

import com.ssafy.shinhanflow.trigger.Trigger;

public record MultiDateTrigger(List<LocalDate> dates) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		for(LocalDate date: dates){
			if(today.isEqual(date)){
				return true;
			}
		}
		return false;
	}
}
