package com.example.smartspinapi.web;

import com.example.smartspinapi.model.dto.AnswerQuestionRequestDTO;
import com.example.smartspinapi.model.dto.AnswerQuestionResponseDTO;
import com.example.smartspinapi.model.dto.CreateQuizSessionDTO;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.resolvers.TriviaUser;
import com.example.smartspinapi.service.QuizSessionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/quiz-session")
public class QuizSessionController {
    private final QuizSessionService quizSessionService;

    @PostMapping
    public QuizSession createQuizSession(@RequestBody CreateQuizSessionDTO createQuizSessionDTO, @TriviaUser UserProfile userProfile) {
        if (createQuizSessionDTO.quizId == null) {
            throw new IllegalArgumentException("Quiz ID cannot be null");
        }
        return quizSessionService.createQuizSession(createQuizSessionDTO.quizId, userProfile);
    }

    @PostMapping("/answer")
    public AnswerQuestionResponseDTO answerQuestion(@RequestBody AnswerQuestionRequestDTO answerQuestionRequestDTO, @TriviaUser UserProfile userProfile) {
        return quizSessionService.answerQuestion(userProfile, answerQuestionRequestDTO.answer);
    }

    @PostMapping("/end")
    public QuizSession endQuizSession(@TriviaUser UserProfile userProfile) {
        return quizSessionService.endQuizSession(userProfile);
    }
}
