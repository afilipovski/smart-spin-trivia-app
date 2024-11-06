package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
public class QuizSession extends BaseEntity {
    @ManyToOne
    private Quiz quiz;
    @OneToOne
    private UserProfile userProfile;
    @ManyToMany
    private List<QuizQuestion> questions;
    private Integer xpCollected;

    private String joinCode;
    @ManyToOne
    private QuizQuestion activeQuestion;
    private LocalDateTime timeActiveQuestionServed;
}
