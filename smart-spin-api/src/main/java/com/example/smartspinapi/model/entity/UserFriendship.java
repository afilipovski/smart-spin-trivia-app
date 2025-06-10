package com.example.smartspinapi.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
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

    public boolean friendshipInvolves(UserProfile profile) {
        return friendshipInitiatorId.equals(profile.getId()) ||
                friendshipReceiverId.equals(profile.getId());
    }

    public UserProfile getOtherProfile(UserProfile profile) {
        return friendshipInitiator.getId().equals(profile.getId()) ? friendshipReceiver : friendshipInitiator;
    }
}
