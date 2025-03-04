package com.example.smartspinapi.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
public class QuizQuestionChoice extends BaseEntity {
    @ManyToOne
    @JoinColumn(name = "question_id")
    @JsonIgnore
    public QuizQuestion question;
    public String content;
    @JsonIgnore
    public Boolean correct;
}
