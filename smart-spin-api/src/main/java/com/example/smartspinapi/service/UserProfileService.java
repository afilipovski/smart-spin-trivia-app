package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.UserProfileAlreadyExistsException;
import com.example.smartspinapi.repository.UserProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserProfileService {
    private final UserProfileRepository userProfileRepository;

    public UserProfile register(String id, String email, String fullName, LocalDate birthday) {
        Optional<UserProfile> existingProfile = userProfileRepository.getUserProfileById(id);
        if (existingProfile.isPresent()) {
            throw new UserProfileAlreadyExistsException(id);
        }
        UserProfile profile = new UserProfile(id, email, fullName, birthday);
        return userProfileRepository.save(profile);
    }
}
