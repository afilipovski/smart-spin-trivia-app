package com.example.smartspinapi.tasks;

import com.example.smartspinapi.model.dto.triviaapi.GetApiTokenResponse;
import com.example.smartspinapi.model.dto.triviaapi.GetQuestionsResponse;
import com.example.smartspinapi.model.dto.triviaapi.TriviaApiQuestion;
import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.model.entity.QuizQuestionChoice;
import com.example.smartspinapi.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import javax.annotation.PostConstruct;
import java.util.Objects;

@Component
@RequiredArgsConstructor
public class PopulateTriviaDbData {
    private final QuizCategoryService quizCategoryService;
    private final QuizService quizService;
    private final QuizQuestionService quizQuestionService;
    private final LimitedTimeEventService limitedTimeEventService;
    private final QuizQuestionChoiceService quizQuestionChoiceService;

    @PostConstruct
    public synchronized void init() throws InterruptedException {
        if (!quizCategoryService.findAll().isEmpty())
            return;

        RestClient triviaApiClient = RestClient.builder()
                .baseUrl("https://opentdb.com")
                .build();

        var token = Objects.requireNonNull(triviaApiClient.get()
                .uri("/api_token.php?command=request").retrieve().body(GetApiTokenResponse.class))
                .token;

        // 20x50 = 1000 questions
        for (int i = 0; i < 1; i++) {
            if (!retrieveQuestionsSingleRun(triviaApiClient, token))
                return;
            wait(5000);
        }

    }

    private boolean retrieveQuestionsSingleRun(RestClient triviaApiClient, String token) {
        var questions = Objects.requireNonNull(triviaApiClient.get()
                .uri("/api.php?amount=50&token=" + token)
                .retrieve().body(GetQuestionsResponse.class));

        if (questions.response_code != 0)
            return false;

        questions.results.forEach(questionResponse -> {
            var quizCategory = assertQuizCategory(questionResponse);

            var question = new QuizQuestion();
            question.setCategory(quizCategory);
            question.setContent(questionResponse.question);
            quizQuestionService.save(question);

            questionResponse.incorrect_answers.forEach(answer -> {
                var questionChoice = new QuizQuestionChoice();
                questionChoice.setContent(answer);
                questionChoice.setQuestion(question);
                questionChoice.setCorrect(false);
                quizQuestionChoiceService.save(questionChoice);
            });
            var questionChoice = new QuizQuestionChoice();
            questionChoice.setQuestion(question);
            questionChoice.setCorrect(true);
            questionChoice.setContent(questionResponse.correct_answer);
            quizQuestionChoiceService.save(questionChoice);

        });

        return true;
    }

    private QuizCategory assertQuizCategory(TriviaApiQuestion question) {
        var quizCategory = quizCategoryService.findByName(question.category);
        if (quizCategory == null) {
            quizCategory = new QuizCategory();
            quizCategory.setName(question.category);
            quizCategoryService.save(quizCategory);
        }
        return quizCategory;
    }
}
