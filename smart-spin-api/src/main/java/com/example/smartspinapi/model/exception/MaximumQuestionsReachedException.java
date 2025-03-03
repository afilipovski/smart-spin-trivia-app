package com.example.smartspinapi.model.exception;

public class MaximumQuestionsReachedException extends RuntimeException {
    public MaximumQuestionsReachedException() {
        super("Maximum questions reached for quiz session ");
    }
}
