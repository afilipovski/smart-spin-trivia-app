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
    @JoinColumn(name="category_id")
    private QuizCategory category;
    @OneToOne
    private QuizQuestionChoice correctChoice;
    @OneToMany(mappedBy = "question")
    private List<QuizQuestionChoice> choices;
    private String content;
}
