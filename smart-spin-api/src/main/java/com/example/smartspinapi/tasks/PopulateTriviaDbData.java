package com.example.smartspinapi.tasks;

import com.example.smartspinapi.model.dto.triviaapi.GetApiTokenResponse;
import com.example.smartspinapi.model.dto.triviaapi.GetQuestionsResponse;
import com.example.smartspinapi.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import javax.annotation.PostConstruct;

@Component
@RequiredArgsConstructor
public class PopulateTriviaDbData {
    private final QuizCategoryService quizCategoryService;
    private final QuizService quizService;
    private final QuizQuestionService quizQuestionService;
    private final LimitedTimeEventService limitedTimeEventService;
    private final QuizQuestionChoiceService quizQuestionChoiceService;

    @PostConstruct
    public void init() {
        RestClient triviaApiClient = RestClient.builder()
                .baseUrl("https://opentdb.com")
                .build();

        var tokenResponse = triviaApiClient.get()
                .uri("/api_token.php?command=request").retrieve().body(GetApiTokenResponse.class);

        var questions = triviaApiClient.get()
                .uri("/api.php?amount=50&token=" + tokenResponse.token)
                .retrieve().body(GetQuestionsResponse.class);

        return;
    }
}
