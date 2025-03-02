package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.BaseEntity;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.repository.QuizQuestionRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuizQuestionService {
    private final QuizQuestionRepository quizQuestionRepository;

    public QuizQuestion serveRandomQuestion(UserProfile userProfile) {
        QuizSession quizSession = userProfile.getQuizSession();
        if (quizSession == null) {
            throw new EntityNotFoundException("Quiz session with user id "+ userProfile.getId() + " not found");
        }
        Set<UUID> questionIds = userProfile.getQuizSession()
                .getQuiz()
                .getQuizCategory()
                .getQuestions()
                .stream()
                .map(BaseEntity::getId)
                .collect(Collectors.toSet());
        List<QuizQuestion> eligibleQuestions = quizQuestionRepository.findQuizQuestionsByCategory(quizSession.getQuiz().getQuizCategory())
                .stream()
                .filter(qq -> questionIds.contains(qq.getId()))
                .toList();
        if (eligibleQuestions.isEmpty()) {
            throw new EntityNotFoundException("No relevant questions found for the quiz with id: " + quizSession.getQuiz().getId());
        }
        Random random = new Random();
        return eligibleQuestions.get(random.nextInt(eligibleQuestions.size()));
    }
}
