package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.exception.TriviaEntityNotFoundException;
import com.example.smartspinapi.repository.QuizRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizService {
    private final QuizRepository quizRepository;

    public Quiz findById(UUID id) {
        return quizRepository.findById(id).orElseThrow(() -> new TriviaEntityNotFoundException(Quiz.class, id));
    }
}
