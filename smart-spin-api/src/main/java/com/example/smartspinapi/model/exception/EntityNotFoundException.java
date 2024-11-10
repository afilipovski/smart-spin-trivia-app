package com.example.smartspinapi.model.exception;

import com.example.smartspinapi.model.entity.BaseEntity;

public class EntityNotFoundException extends RuntimeException {
    public EntityNotFoundException(BaseEntity entity) {
        super(entity.getClass().getName() + " with id " + entity.getId() + " not found.");
    }
}
