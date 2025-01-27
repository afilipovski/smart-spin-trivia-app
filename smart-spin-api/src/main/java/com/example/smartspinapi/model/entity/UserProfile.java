package com.example.smartspinapi.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
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
    private String id;
    private String email;
    private String fullName;
    private LocalDate birthDate;
    @ManyToMany
    private List<UserProfile> friends;
    private Integer streak;
    private ZonedDateTime streakLastExtended;

    public UserProfile(String id, String email, String fullName, LocalDate birthDate) {
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.friends = new ArrayList<>();
        this.streak = 0;
        this.streakLastExtended = ZonedDateTime.now();
    }
}
