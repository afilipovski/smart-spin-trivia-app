package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
public class LimitedTimeEvent {
    @Id
    @GeneratedValue
    private UUID id;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
}
