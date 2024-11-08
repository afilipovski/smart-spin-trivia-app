package com.example.smartspinapi.web;

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
        return quizSessionService.createQuizSession(createQuizSessionDTO.quizId, userProfile);
    }
}
