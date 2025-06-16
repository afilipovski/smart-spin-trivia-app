package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.QuizQuestionChoice;
import com.example.smartspinapi.repository.QuizQuestionChoiceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class QuizQuestionChoiceService {
    private final QuizQuestionChoiceRepository quizQuestionChoiceRepository;

    public void save(QuizQuestionChoice quizQuestionChoice) {
        quizQuestionChoiceRepository.save(quizQuestionChoice);
    }
}
