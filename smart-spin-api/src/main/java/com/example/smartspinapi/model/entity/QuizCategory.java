package com.example.smartspinapi.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import lombok.Getter;

import java.util.List;

@Entity
@Getter
public class QuizCategory extends BaseEntity {
    public String name;
    @OneToMany(mappedBy = "category")
    @JsonIgnore
    private List<QuizQuestion> questions;
}
