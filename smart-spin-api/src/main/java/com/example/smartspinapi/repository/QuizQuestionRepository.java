package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.QuizCategory;
import com.example.smartspinapi.model.entity.QuizQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface QuizQuestionRepository extends JpaRepository<QuizQuestion, UUID> {
    public List<QuizQuestion> findQuizQuestionsByCategory(QuizCategory category);
}
