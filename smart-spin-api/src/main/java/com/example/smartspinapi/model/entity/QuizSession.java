package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class QuizSession extends BaseEntity {
    @ManyToOne
    public Quiz quiz;
    @OneToOne
    public UserProfile userProfile;
    @ManyToMany
    public List<QuizQuestion> questions;

    public Integer xpCollected = 0;

    public String joinCode;
    @ManyToOne
    public QuizQuestion activeQuestion;
    public LocalDateTime timeActiveQuestionServed;

    @Transient
    public Integer numQuestions;

    public Integer getNumQuestions() {
        return Math.min(quiz.getNumQuestions(), quiz.getQuizCategory().getQuestions().size());
    }

    public QuizSession(Quiz quiz, UserProfile userProfile) {
        this.quiz = quiz;
        this.userProfile = userProfile;
    }
}
