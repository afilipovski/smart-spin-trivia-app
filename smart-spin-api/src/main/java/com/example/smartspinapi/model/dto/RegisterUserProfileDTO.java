package com.example.smartspinapi.model.dto;

import lombok.Getter;

import java.time.LocalDate;

@Getter
public class RegisterUserProfileDTO {
    String fullName;
    LocalDate birthDate;
}
