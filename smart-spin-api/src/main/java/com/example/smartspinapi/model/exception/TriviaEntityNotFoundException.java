package com.example.smartspinapi.model.exception;

import com.example.smartspinapi.model.entity.BaseEntity;

import java.util.UUID;

public class TriviaEntityNotFoundException extends RuntimeException {
    public TriviaEntityNotFoundException(Class<BaseEntity> triviaClass, UUID id) {
        super(triviaClass.getName() + " with id " + id + " not found.");
    }
}
