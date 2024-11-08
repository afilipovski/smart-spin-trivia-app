package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.repository.QuizSessionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizSessionService {
    private final QuizService quizService;
    private final QuizSessionRepository quizSessionRepository;

    public QuizSession createQuizSession(UUID quizId, UserProfile userProfile) {
        Quiz quiz = quizService.findById(quizId);
        QuizSession quizSession = new QuizSession(quiz, userProfile);
        return quizSessionRepository.save(quizSession);
    }
}
