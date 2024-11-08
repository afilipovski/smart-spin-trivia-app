package com.example.smartspinapi.resolvers;

import com.example.smartspinapi.model.exception.UserProfileDoesntExistException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler({UserProfileDoesntExistException.class})
    public ResponseEntity<Object> handleStudentNotFoundException(UserProfileDoesntExistException exception) {
        return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .body(exception.getMessage());
    }
}