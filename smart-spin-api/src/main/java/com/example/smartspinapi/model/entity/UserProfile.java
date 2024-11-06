package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@Setter
public class UserProfile {
    @Id
    private String id;
    private String email;
    private String fullName;
    private LocalDate birthday;
    @ManyToMany
    private List<UserProfile> friends;
    private Integer streak;
    private LocalDate streakLastExtended;
}
