package com.example.smartspinapi.model.exception;

public class UserIsNotMultiplayerQuizLeaderException extends Exception {
    public UserIsNotMultiplayerQuizLeaderException(String userId, String joinCode) {
        super("User with id " + userId + " is not the leader of " + joinCode);
    }
}
