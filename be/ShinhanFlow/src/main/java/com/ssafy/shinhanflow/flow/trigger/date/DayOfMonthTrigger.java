package com.ssafy.shinhanflow.flow.trigger.date;

import com.ssafy.shinhanflow.flow.trigger.Trigger;

import lombok.NonNull;

import java.time.LocalDate;
import java.util.Set;

public record DayOfMonthTrigger(@NonNull Set<Integer> days) implements Trigger {

    @Override
    public boolean isTriggered() {
        LocalDate today = LocalDate.now();
        for(Integer day : days) {
            if(today.getDayOfMonth() == day) {
                return true;
            }
        }
        return false;
    }
}
