package com.example.smartspinapi.web;

import com.example.smartspinapi.model.entity.UserFriendship;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.resolvers.TriviaUser;
import com.example.smartspinapi.service.UserFriendshipService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user-friendship")
@RequiredArgsConstructor
public class UserFriendshipController {
    private final UserFriendshipService userFriendshipService;

    @GetMapping("/active")
    public List<UserFriendship> listActiveFriendships(@TriviaUser UserProfile userProfile) {
        return userFriendshipService.listActiveFriendships(userProfile.getId());
    }

    @GetMapping("/requests")
    public List<UserFriendship> listFriendRequests(@TriviaUser UserProfile userProfile) {
        return userFriendshipService.listFriendRequests(userProfile.getId());
    }

    @GetMapping("/{otherUserId}")
    public UserFriendship getFriendship(@TriviaUser UserProfile userProfile, @PathVariable String otherUserId) {
        return userFriendshipService.getFriendshipDetails(userProfile.getId(), otherUserId);
    }

    @PostMapping("/request/{otherUserId}")
    public UserFriendship requestFriendship(@TriviaUser UserProfile userProfile, @PathVariable String otherUserId) {
        return userFriendshipService.requestFriendship(userProfile.getId(), otherUserId);
    }

    @PatchMapping("/accept/{otherUserId}")
    public UserFriendship acceptFriendship(@TriviaUser UserProfile userProfile, @PathVariable String otherUserId) {
        return userFriendshipService.acceptFriendship(userProfile.getId(), otherUserId);
    }

    @DeleteMapping("/{otherUserId}")
    public UserFriendship deleteFriendship(@TriviaUser UserProfile userProfile, @PathVariable String otherUserId) {
        return userFriendshipService.deleteFriendship(userProfile.getId(), otherUserId);
    }

    @GetMapping("/mutual/{otherUserId}")
    public List<UserProfile> listMutualFriendships(@TriviaUser UserProfile userProfile, @PathVariable String otherUserId) {
        return userFriendshipService.getMutualFriends(userProfile.getId(), otherUserId);
    }
}
