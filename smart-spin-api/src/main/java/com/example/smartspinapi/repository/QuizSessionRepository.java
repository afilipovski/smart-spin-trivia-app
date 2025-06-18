package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.QuizSession;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface QuizSessionRepository extends JpaRepository<QuizSession, UUID> {
    @EntityGraph(attributePaths = {"questions"})
    Optional<QuizSession> findByUserProfileId(String userProfileId);
    Optional<QuizSession> findByJoinCode(String joinCode);
}
