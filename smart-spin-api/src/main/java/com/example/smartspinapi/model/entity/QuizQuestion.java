package com.example.smartspinapi.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
    @JsonIgnore
    public QuizCategory category;
    @OneToMany(mappedBy = "question")
    public List<QuizQuestionChoice> choices;
    public String content;

    public QuizQuestionChoice correctChoice() {
        return choices.stream()
                .filter(c -> c.correct)
                .findAny()
                .orElseThrow();
    }
}
