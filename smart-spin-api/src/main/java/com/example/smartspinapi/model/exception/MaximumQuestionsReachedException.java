package com.example.smartspinapi.model.exception;

public class MaximumQuestionsReachedException extends RuntimeException {
    public MaximumQuestionsReachedException(String id) {
        super("Maximum questions reached for quiz session " + id);
    }
}
