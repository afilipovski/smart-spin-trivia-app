package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.repository.QuizRepository;
import jakarta.persistence.EntityExistsException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizService {
    private final QuizRepository quizRepository;

    public Quiz findById(UUID id) {
        return quizRepository.findById(id).orElseThrow(EntityExistsException::new);
    }

    public List<Quiz> findAll() { return quizRepository.findAll(); }
}
