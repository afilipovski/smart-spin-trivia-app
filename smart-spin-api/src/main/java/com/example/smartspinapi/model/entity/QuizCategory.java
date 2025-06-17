package com.example.smartspinapi.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class QuizCategory extends BaseEntity {
    public String name;
    @OneToMany(mappedBy = "category")
    @JsonIgnore
    private List<QuizQuestion> questions;
}
