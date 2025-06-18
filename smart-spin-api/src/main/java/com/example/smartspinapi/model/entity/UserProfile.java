package com.example.smartspinapi.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class UserProfile {
    @Id
    public String id;
    public String email;
    public String fullName;
    public LocalDate birthDate;

    public Integer streak;
    public ZonedDateTime streakLastExtended;

    @OneToOne(mappedBy = "userProfile")
    @JsonIgnore
    private QuizSession quizSession;

    public UserProfile(String id, String email, String fullName, LocalDate birthDate) {
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.streak = 0;
    }
}
