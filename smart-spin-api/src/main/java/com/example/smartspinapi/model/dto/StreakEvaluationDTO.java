package com.example.smartspinapi.model.dto;

import java.time.ZonedDateTime;

public record StreakEvaluationDTO(int streak, ZonedDateTime streakLastExtended, boolean shouldReset) {}
