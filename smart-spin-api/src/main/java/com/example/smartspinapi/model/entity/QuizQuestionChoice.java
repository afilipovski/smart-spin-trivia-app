package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Entity
@Getter
@Setter
public class QuizQuestionChoice {
    @Id
    @GeneratedValue
    private UUID id;
    @ManyToOne
    private QuizQuestion question;
    private String content;
}
