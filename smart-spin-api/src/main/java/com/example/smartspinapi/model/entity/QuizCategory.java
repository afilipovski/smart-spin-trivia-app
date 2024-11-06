package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
public class QuizCategory extends BaseEntity {
    private String name;
    @OneToMany(mappedBy = "category")
    private List<QuizQuestion> questions;
}
