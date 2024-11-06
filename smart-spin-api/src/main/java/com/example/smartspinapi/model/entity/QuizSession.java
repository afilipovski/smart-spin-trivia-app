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
    public Quiz quiz;
    @OneToOne
    public UserProfile userProfile;
    @ManyToMany
    public List<QuizQuestion> questions;
    public Integer xpCollected;

    public String joinCode;
    @ManyToOne
    public QuizQuestion activeQuestion;
    public LocalDateTime timeActiveQuestionServed;
}
