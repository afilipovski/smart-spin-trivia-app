package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
public class QuizQuestion {
    @Id
    @GeneratedValue
    private UUID id;
    @ManyToOne
    private QuizCategory category;
    @OneToOne
    private QuizQuestionChoice correctChoice;
    @OneToMany
    private List<QuizQuestionChoice> choices;
    private String content;
}
