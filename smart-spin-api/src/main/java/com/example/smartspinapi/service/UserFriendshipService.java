package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.UserFriendship;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.TriviaEntityExistsException;
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
    private final UserProfileService userProfileService;

    public List<UserFriendship> listActiveFriendships(String userId) {
        return userFriendshipRepository.findAllByFriendshipInitiatorIdOrFriendshipReceiverIdAndFriendshipAcceptedTrue(userId,userId);
    }

    public List<UserFriendship> listFriendRequests(String userId) {
        return userFriendshipRepository.findAllByFriendshipReceiverIdAndFriendshipAcceptedFalse(userId);
    }

    private Optional<UserFriendship> getFriendship(String userAId, String userBId) {
        return Optional.ofNullable(userFriendshipRepository.findByFriendshipInitiatorIdAndFriendshipReceiverId(userAId,userBId)
                .orElse(userFriendshipRepository.findByFriendshipInitiatorIdAndFriendshipReceiverId(userBId,userAId)
                        .orElse(null)));
    }

    public UserFriendship requestFriendship(String userAId, String userBId) {
        var friendship = getFriendship(userAId,userBId);
        if (friendship.isPresent()) {
            throw new TriviaEntityExistsException(friendship.get());
        }

        UserProfile initiator = userProfileService.getUserProfileById(userAId);
        UserProfile receiver = userProfileService.getUserProfileById(userBId);

        var newFriendship = new UserFriendship(initiator,receiver);

        return userFriendshipRepository.save(newFriendship);
    }

    public UserFriendship acceptFriendship(String userAId, String userBId) {
        var friendship = getFriendship(userAId,userBId)
                .orElseThrow(() -> new TriviaEntityNotFoundException(UserFriendship.class));
        friendship.setFriendshipAccepted(true);
        return userFriendshipRepository.save(friendship);
    }

//    Both decline and delete

    public UserFriendship deleteFriendship(String userAId, String userBId) {
        var friendship = getFriendship(userAId,userBId)
                .orElseThrow(() -> new TriviaEntityNotFoundException(UserFriendship.class));
        userFriendshipRepository.delete(friendship);
        return friendship;
    }


}
