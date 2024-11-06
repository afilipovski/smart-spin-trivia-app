package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class LimitedTimeEvent extends BaseEntity {
    public LocalDateTime startTime;
    public LocalDateTime endTime;
}
