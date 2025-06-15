package com.example.smartspinapi.web;

import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.service.QuizCategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/quiz-category")
@RequiredArgsConstructor
public class QuizCategoryController {
    private final QuizCategoryService quizCategoryService;

    @GetMapping()
    public List<QuizCategory> getAll() {
        return quizCategoryService.findAll();
    }
}
