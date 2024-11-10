package com.example.smartspinapi.web;

import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.resolvers.TriviaUser;
import com.example.smartspinapi.service.QuizQuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/quiz-question")
@RequiredArgsConstructor
public class QuizQuestionController {
    private final QuizQuestionService quizQuestionService;

    public QuizQuestion serveRandomQuizQuestion(@TriviaUser UserProfile userProfile) {
        return quizQuestionService.serveRandomQuestion();
    }
}
