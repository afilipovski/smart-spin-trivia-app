package com.example.smartspinapi.model.exception;

import com.example.smartspinapi.model.entity.BaseEntity;

public class EntityExistsException extends RuntimeException {
    public EntityExistsException(BaseEntity entity) {
        super(entity.getClass().getName() + " with id " + entity.getId() + " already exists.");
    }
}
