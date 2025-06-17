package com.example.smartspinapi.model.constants;

import com.example.smartspinapi.model.entity.LimitedTimeEvent;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

public class SymbolicDatesAndOccasions
{
    public static LocalDateTime[][] eventPeriods = {
            // First month from quiz release
            { LocalDate.now().atStartOfDay(), LocalDate.now().plusMonths(1).atTime(23,59,59) },

            // Ilinden / Day of the Republic (national holiday)
            { LocalDateTime.of(2025, 8, 2, 0, 0), LocalDateTime.of(2025, 8, 2, 23, 59, 59) },

            // Independence Day of Macedonia
            { LocalDateTime.of(2025, 9, 8, 0, 0), LocalDateTime.of(2025, 9, 8, 23, 59, 59) },

            // Start of the school year
            { LocalDateTime.of(2025, 9, 1, 0, 0), LocalDateTime.of(2025, 9, 1, 23, 59, 59) },

            // New Year's Eve and Day
            { LocalDateTime.of(2025, 12, 31, 18, 0), LocalDateTime.of(2026, 1, 1, 23, 59, 59) },

            // Orthodox Christmas
            { LocalDateTime.of(2026, 1, 7, 0, 0), LocalDateTime.of(2026, 1, 7, 23, 59, 59) },

            // Orthodox Easter (2026 tentative: April 12)
            { LocalDateTime.of(2026, 4, 10, 0, 0), LocalDateTime.of(2026, 4, 13, 23, 59, 59) },

            // Labour Day
            { LocalDateTime.of(2026, 5, 1, 0, 0), LocalDateTime.of(2026, 5, 1, 23, 59, 59) }
    };

    public static LimitedTimeEvent getRandomLimitedTimeEvent() {
        var limitedTimeEvent = new LimitedTimeEvent();
        Random random = new Random();
        LocalDateTime[] timeSpan = eventPeriods[random.nextInt(eventPeriods.length)];
        limitedTimeEvent.setStartTime(timeSpan[0]);
        limitedTimeEvent.setEndTime(timeSpan[1]);
        return limitedTimeEvent;
    }
}
