package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.repository.QuizCategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizCategoryService {
    private final QuizCategoryRepository quizCategoryRepository;

    public List<QuizCategory> findAll() {
        return quizCategoryRepository.findAll();
    }

    public QuizCategory findById(UUID id) {
        return quizCategoryRepository.findById(id).orElseThrow(EntityNotFoundException::new);
    }

    public void save(QuizCategory quizCategory) {
        quizCategoryRepository.save(quizCategory);
    }
}
