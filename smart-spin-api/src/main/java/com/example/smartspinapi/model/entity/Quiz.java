package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Quiz extends BaseEntity {
    @ManyToOne
    private QuizCategory quizCategory;
    private Integer xpPerQuestion;
    @OneToOne
    private LimitedTimeEvent event;
}
