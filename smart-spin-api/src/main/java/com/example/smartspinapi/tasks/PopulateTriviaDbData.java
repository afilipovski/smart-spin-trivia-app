package com.example.smartspinapi.tasks;

import com.example.smartspinapi.model.constants.SymbolicDatesAndOccasions;
import com.example.smartspinapi.model.dto.triviaapi.GetApiTokenResponse;
import com.example.smartspinapi.model.dto.triviaapi.GetQuestionsResponse;
import com.example.smartspinapi.model.dto.triviaapi.TriviaApiQuestion;
import com.example.smartspinapi.model.entity.*;
import com.example.smartspinapi.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.util.Objects;
import java.util.Random;

@Component
@RequiredArgsConstructor
@Order(1)
public class PopulateTriviaDbData implements CommandLineRunner {
    private final QuizCategoryService quizCategoryService;
    private final QuizService quizService;
    private final QuizQuestionService quizQuestionService;
    private final LimitedTimeEventService limitedTimeEventService;
    private final QuizQuestionChoiceService quizQuestionChoiceService;

    @Override
    public synchronized void run(String... args) throws InterruptedException {
        System.out.println("Initializing question categories from TriviaDB");

        if (!quizCategoryService.findAll().isEmpty())
            return;

        RestClient triviaApiClient = RestClient.builder()
                .baseUrl("https://opentdb.com")
                .build();

        var token = Objects.requireNonNull(triviaApiClient.get()
                .uri("/api_token.php?command=request").retrieve().body(GetApiTokenResponse.class))
                .token;

        // 20x50 = 1000 questions, 20x(5+2)=140 seconds (about two minutes to finish)
        for (int i = 0; i < 20; i++) {
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
            var quizCategory = assertQuizCategoryQuizAndLimitedTimeEvent(questionResponse);
            var question = createQuizQuestion(questionResponse, quizCategory);

            questionResponse.incorrect_answers.forEach(answer -> createQuestionChoice(answer, question, false));
            createQuestionChoice(questionResponse.correct_answer, question, true);
        });

        return true;
    }

    private void createQuizAndLimitedTimeEvent(QuizCategory quizCategory) {
        var quiz = new Quiz();
        quiz.setQuizCategory(quizCategory);
        Random random = new Random();
        int numQuestions = random.nextInt(7, 13);
        quiz.setNumQuestions(numQuestions);
        quiz.setXpPerQuestion(50/numQuestions);

        LimitedTimeEvent limitedTimeEvent = SymbolicDatesAndOccasions.getRandomLimitedTimeEvent();
        quiz.setEvent(limitedTimeEvent);

        limitedTimeEventService.save(limitedTimeEvent);
        quizService.save(quiz);
    }

    private void createQuestionChoice(String answer, QuizQuestion question, boolean correct) {
        var questionChoice = new QuizQuestionChoice();
        questionChoice.setContent(answer);
        questionChoice.setQuestion(question);
        questionChoice.setCorrect(correct);
        quizQuestionChoiceService.save(questionChoice);
    }

    private QuizQuestion createQuizQuestion(TriviaApiQuestion questionResponse, QuizCategory quizCategory) {
        var question = new QuizQuestion();
        question.setCategory(quizCategory);
        question.setContent(questionResponse.question);
        quizQuestionService.save(question);
        return question;
    }

    private QuizCategory assertQuizCategoryQuizAndLimitedTimeEvent(TriviaApiQuestion question) {
        var quizCategory = quizCategoryService.findByName(question.category);
        if (quizCategory == null) {
            quizCategory = new QuizCategory();
            quizCategory.setName(question.category);
            quizCategoryService.save(quizCategory);
            createQuizAndLimitedTimeEvent(quizCategory);
        }
        return quizCategory;
    }
}
