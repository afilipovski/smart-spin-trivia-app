package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.repository.QuizSessionRepository;
import jakarta.persistence.EntityExistsException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizSessionService {
    private final QuizService quizService;
    private final QuizSessionRepository quizSessionRepository;

    public QuizSession createQuizSession(UUID quizId, UserProfile userProfile) {
        Quiz quiz = quizService.findById(quizId);
        Optional<QuizSession> existingQuizSession = quizSessionRepository.findByUserProfileId(userProfile.getId());
        if (existingQuizSession.isPresent())
            throw new EntityExistsException("Quiz session with user id " + userProfile.getId() + " already exists");
        QuizSession quizSession = new QuizSession(quiz, userProfile);
        return quizSessionRepository.save(quizSession);
    }
}
