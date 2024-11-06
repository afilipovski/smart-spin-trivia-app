package com.example.smartspinapi.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class QuizQuestion extends BaseEntity {
    @ManyToOne
    private QuizCategory category;
    @OneToOne
    private QuizQuestionChoice correctChoice;
    @OneToMany
    private List<QuizQuestionChoice> choices;
    private String content;
}
