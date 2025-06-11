package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.UserFriendship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserFriendshipRepository extends JpaRepository<UserFriendship, UUID> {
    //List friend requests
    List<UserFriendship> findAllByFriendshipReceiverIdAndFriendshipAcceptedFalse(String friendshipReceiverId);
    //List friendships
    List<UserFriendship> findAllByFriendshipInitiatorIdOrFriendshipReceiverIdAndFriendshipAcceptedTrue(String friendshipInitiatorId, String friendshipReceiverId);
    //Find individual friendship
    Optional<UserFriendship> findByFriendshipInitiatorIdAndFriendshipReceiverId(String friendshipInitiatorId, String friendshipReceiverId);
}
