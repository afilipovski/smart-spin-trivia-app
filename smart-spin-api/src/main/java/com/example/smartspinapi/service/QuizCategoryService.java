package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.repository.QuizCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuizCategoryService {
    private final QuizCategoryRepository quizCategoryRepository;

    public List<QuizCategory> findAll() {
        return quizCategoryRepository.findAll();
    }
}
