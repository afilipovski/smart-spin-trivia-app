package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.dto.multiplayer.MultiplayerQuizSession;

import java.util.List;
import java.util.concurrent.CompletableFuture;

public interface MultiplayerQuizSessionRepository {

    CompletableFuture<Void> save(String joinCode, MultiplayerQuizSession session);

    CompletableFuture<MultiplayerQuizSession> findByJoinCode(String joinCode);

    CompletableFuture<List<MultiplayerQuizSession>> findAll();

    CompletableFuture<Void> delete(String joinCode);
}
