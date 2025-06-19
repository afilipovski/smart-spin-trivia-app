package com.example.smartspinapi.resolvers;

import com.example.smartspinapi.model.exception.*;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler({UserProfileNotFoundException.class})
    public ResponseEntity<Object> handleUserProfileNotFoundException(UserProfileNotFoundException exception) {
        return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .body(exception.getMessage());
    }
    @ExceptionHandler({UserProfileExistsException.class, EntityExistsException.class, TriviaEntityExistsException.class})
    public ResponseEntity<Object> handleEntityExistsException(RuntimeException exception) {
        return ResponseEntity
                .status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(exception.getMessage());
    }
    @ExceptionHandler({EntityNotFoundException.class, TriviaEntityNotFoundException.class})
    public ResponseEntity<Object> handleEntityNotFoundException(RuntimeException exception) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(exception.getMessage());
    }
    @ExceptionHandler({IllegalArgumentException.class})
    public ResponseEntity<Object> handleIllegalArgumentException(IllegalArgumentException exception) {
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(exception.getMessage());
    }
    @ExceptionHandler({MaximumQuestionsReachedException.class})
    public ResponseEntity<Object> handleIllegalArgumentException(MaximumQuestionsReachedException exception) {
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(exception.getMessage());
    }
    @ExceptionHandler({UserIsNotMultiplayerQuizLeaderException.class})
    public ResponseEntity<Object> handleIllegalArgumentException(UserIsNotMultiplayerQuizLeaderException exception) {
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(exception.getMessage());
    }
}