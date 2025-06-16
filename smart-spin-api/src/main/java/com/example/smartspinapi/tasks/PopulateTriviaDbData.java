package com.example.smartspinapi.tasks;

import com.example.smartspinapi.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

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
        System.out.println("Hello World!");
    }
}
