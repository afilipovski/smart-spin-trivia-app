package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Entity
@Getter
@Setter
public class Quiz {
    @Id
    @GeneratedValue
    private UUID id;
    @ManyToOne
    private QuizCategory quizCategory;
    private Integer xpPerQuestion;
    @OneToOne
    private LimitedTimeEvent event;
}
