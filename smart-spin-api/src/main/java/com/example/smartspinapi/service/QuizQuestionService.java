package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.repository.QuizQuestionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizQuestionService {
    private final QuizQuestionRepository quizQuestionRepository;
    private final QuizCategoryService quizCategoryService;

    public QuizQuestion serveRandomQuestion(UUID categoryId) {
        QuizCategory category = quizCategoryService.findById(categoryId);
        List<QuizQuestion> eligibleQuestions = quizQuestionRepository.findQuizQuestionsByCategory(category);
        return eligibleQuestions.get(0);
    }
}
