package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

import java.util.UUID;
import java.util.List;

@Entity
public class QuizCategory {
    @Id
    @GeneratedValue
    private UUID id;
    private String name;
    @OneToMany
    private List<QuizQuestion> questions;
}
