package com.example.smartspinapi.model.exception;

import com.example.smartspinapi.model.entity.BaseEntity;

public class TriviaEntityExistsException extends RuntimeException {
    public TriviaEntityExistsException(BaseEntity entity) {
        super(entity.getClass().getName() + " with id " + entity.getId() + " already exists.");
    }
}
