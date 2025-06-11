package com.example.smartspinapi.model.exception;

import com.example.smartspinapi.model.entity.BaseEntity;

import java.util.UUID;

public class TriviaEntityNotFoundException extends RuntimeException {
    public TriviaEntityNotFoundException(Class<? extends BaseEntity> triviaClass, UUID id) {
        super(triviaClass.getName() + " with id " + id + " not found.");
    }
    public TriviaEntityNotFoundException(Class<? extends BaseEntity> triviaClass) {
        super(triviaClass.getName() + " not found with those search parameters.");
    }
}
