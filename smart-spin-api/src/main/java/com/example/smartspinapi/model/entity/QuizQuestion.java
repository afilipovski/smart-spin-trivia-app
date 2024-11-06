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
    public QuizCategory category;
    @OneToMany(mappedBy = "question")
    public List<QuizQuestionChoice> choices;
    public String content;
}
