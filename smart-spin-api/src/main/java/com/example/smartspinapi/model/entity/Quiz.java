package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Quiz extends BaseEntity {
    @ManyToOne
    public QuizCategory quizCategory;
    public Integer xpPerQuestion;
    @OneToOne
    public LimitedTimeEvent event;
}
