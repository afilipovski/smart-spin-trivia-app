package com.example.smartspinapi.web;

import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.service.QuizService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/quiz")
@RequiredArgsConstructor
public class QuizController {
    private final QuizService quizService;

    @GetMapping()
    public List<Quiz> findAllQuizzes() {
        return quizService.findAll();
    }
}
