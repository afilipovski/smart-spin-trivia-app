package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.QuizQuestionChoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface QuizQuestionChoiceRepository extends JpaRepository<QuizQuestionChoice, UUID> {
}
