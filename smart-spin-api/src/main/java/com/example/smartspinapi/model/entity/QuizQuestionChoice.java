package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
public class QuizQuestionChoice extends BaseEntity {
    @ManyToOne
    private QuizQuestion question;
    private String content;
}
