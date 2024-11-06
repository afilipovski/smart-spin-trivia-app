package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
public class QuizSession {
    @Id
    @GeneratedValue
    private UUID id;
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
