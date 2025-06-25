package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.*;
import com.example.smartspinapi.model.exception.MaximumQuestionsReachedException;
import com.example.smartspinapi.repository.QuizQuestionRepository;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuizQuestionService {
    private final QuizQuestionRepository quizQuestionRepository;
    private final QuizSessionService quizSessionService;

    public QuizQuestion serveRandomQuestion(UserProfile userProfile) {
        QuizSession quizSession = userProfile.getQuizSession();
        if (quizSession == null) {
            throw new EntityNotFoundException("Quiz session with user id "+ userProfile.getId() + " not found");
        }
        if (quizSession.getActiveQuestion() != null) {
            throw new EntityExistsException("Quiz session with user id "+ userProfile.getId() + " already has an active question");
        }

        List<QuizQuestion> sessionQuestions = quizSession.getQuestions();

        if (quizSession.getNumQuestions() == sessionQuestions.size()) {
            throw new MaximumQuestionsReachedException(quizSession.getId().toString());
        }

        Set<UUID> questionIds = quizSession
                .getQuiz()
                .getQuizCategory()
                .getQuestions()
                .stream()
                .map(BaseEntity::getId)
                .collect(Collectors.toSet());
        Set<UUID> usedQuestions = sessionQuestions
                .stream()
                .map(BaseEntity::getId)
                .collect(Collectors.toSet());
        List<QuizQuestion> eligibleQuestions = quizQuestionRepository.findQuizQuestionsByCategory(quizSession.getQuiz().getQuizCategory())
                .stream()
                .filter(qq -> questionIds.contains(qq.getId()) && !usedQuestions.contains(qq.getId()))
                .toList();

        Random random = new Random();
        QuizQuestion quizQuestion = eligibleQuestions.get(random.nextInt(eligibleQuestions.size()));
        quizSessionService.setActiveQuestion(userProfile, quizQuestion);
        return quizQuestion;
    }

    public void save(QuizQuestion quizQuestion) {
        quizQuestionRepository.save(quizQuestion);
    }

    public long countQuizQuestionsByCategory(QuizCategory category) {
        return quizQuestionRepository.countQuizQuestionsByCategory(category);
    }
}
