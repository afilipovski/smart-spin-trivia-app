package com.example.smartspinapi.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class UserFriendship extends BaseEntity {
    @ManyToOne
    @JoinColumn(name = "friendship_initiator_id")
    public UserProfile friendshipInitiator;

    @ManyToOne
    @JoinColumn(name = "friendship_receiver_id")
    public UserProfile friendshipReceiver;

    @Column(name = "friendship_initiator_id", insertable = false, updatable = false)
    public String friendshipInitiatorId;

    @Column(name = "friendship_receiver_id", insertable = false, updatable = false)
    public String friendshipReceiverId;

    public boolean friendshipAccepted;

    public UserFriendship(UserProfile friendshipInitiator, UserProfile friendshipReceiver) {
        this.friendshipInitiator = friendshipInitiator;
        this.friendshipReceiver = friendshipReceiver;
    }

    public String getOtherProfileId(String id) {
        return friendshipInitiator.getId().equals(id) ? friendshipReceiverId : friendshipInitiatorId;
    }
}
