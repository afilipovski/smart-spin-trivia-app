package com.example.smartspinapi.service;

import com.example.smartspinapi.model.dto.multiplayer.MultiplayerQuizSession;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.enums.MultiplayerQuizSessionStatus;
import com.example.smartspinapi.model.exception.UserIsNotMultiplayerQuizLeaderException;
import com.example.smartspinapi.repository.MultiplayerQuizSessionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
@RequiredArgsConstructor
public class MultiplayerQuizSessionService {
    private final MultiplayerQuizSessionRepository multiplayerQuizSessionRepository;

    public void createMultiplayerQuizSession(String userId, QuizSession quizSession) {
        MultiplayerQuizSession multiplayerQuizSession = new MultiplayerQuizSession();
        multiplayerQuizSession.leader = userId;
        multiplayerQuizSession.players = Collections.singletonList(userId);
        multiplayerQuizSession.status = MultiplayerQuizSessionStatus.CREATED.name();
        multiplayerQuizSessionRepository.save(quizSession.joinCode, multiplayerQuizSession).join();
    }

    public void addPlayerToMultiplayerQuizSession(String userId, String joinCode) {
        var session = multiplayerQuizSessionRepository.findByJoinCode(joinCode).join();
        if (!session.players.contains(userId)) {
            session.players.add(userId);
        }
        multiplayerQuizSessionRepository.save(joinCode,session).join();
    }

    public void removePlayerFromMultiplayerQuizSession(String userId, String joinCode) {
        var session = multiplayerQuizSessionRepository.findByJoinCode(joinCode).join();
        if (session == null) {
            return;
        }
        if (session.leader.equals(userId)) {
            multiplayerQuizSessionRepository.delete(joinCode).join();
        }
        else {
            session.players.remove(userId);
            multiplayerQuizSessionRepository.save(joinCode, session).join();
        }
    }

    public void startGame(UserProfile user) throws UserIsNotMultiplayerQuizLeaderException {
        var localSession = user.getQuizSession();
        var session = multiplayerQuizSessionRepository.findByJoinCode(localSession.joinCode).join();
        if (!session.leader.equals(user.getId()))
            throw new UserIsNotMultiplayerQuizLeaderException(user.getId(), localSession.joinCode);
        session.status = MultiplayerQuizSessionStatus.ACTIVE.name();
        multiplayerQuizSessionRepository.save(localSession.joinCode, session).join();
    }
}
