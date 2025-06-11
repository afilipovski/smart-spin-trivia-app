package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.UserFriendship;
import com.example.smartspinapi.model.exception.TriviaEntityNotFoundException;
import com.example.smartspinapi.repository.UserFriendshipRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserFriendshipService {
    private final UserFriendshipRepository userFriendshipRepository;

    public List<UserFriendship> listActiveFriendships(String userProfileId) {
        return userFriendshipRepository.findAllByFriendshipInitiatorIdOrFriendshipReceiverIdAndFriendshipAcceptedTrue(userProfileId,userProfileId);
    }

    public List<UserFriendship> listFriendRequests(String userProfileId) {
        return userFriendshipRepository.findAllByFriendshipReceiverIdAndFriendshipAcceptedFalse(userProfileId);
    }

    private Optional<UserFriendship> getFriendship(String userAId, String userBId) {
        return Optional.ofNullable(userFriendshipRepository.findByFriendshipInitiatorIdAndFriendshipReceiverId(userAId,userBId)
                .orElse(userFriendshipRepository.findByFriendshipInitiatorIdAndFriendshipReceiverId(userBId,userAId)
                        .orElse(null)));
    }

    public UserFriendship requestFriendship(String userAId, String userBId) {
        return getFriendship(userAId,userBId).orElseThrow(() -> new TriviaEntityNotFoundException(UserFriendship.class));
    }
}
