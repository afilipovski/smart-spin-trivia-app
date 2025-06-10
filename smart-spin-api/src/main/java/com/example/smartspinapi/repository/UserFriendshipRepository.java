package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.UserFriendship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface UserFriendshipRepository extends JpaRepository<UserFriendship, UUID> {
//List friend requests
    List<UserFriendship> findAllByFriendshipReceiverIdAndFriendshipAcceptedFalse(UUID friendshipReceiverId);
//List friendships
    List<UserFriendship> findAllByFriendshipInitiatorIdOrFriendshipReceiverIdAndFriendshipAcceptedTrue(UUID friendshipInitiatorId, UUID friendshipReceiverId);
}
