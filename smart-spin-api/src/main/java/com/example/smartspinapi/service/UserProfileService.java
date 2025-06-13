package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.UserProfileExistsException;
import com.example.smartspinapi.model.exception.UserProfileNotFoundException;
import com.example.smartspinapi.repository.UserProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserProfileService {
    private final UserProfileRepository userProfileRepository;

    public UserProfile register(String id, String email, String fullName, LocalDate birthDate) {
        Optional<UserProfile> existingProfile = userProfileRepository.getUserProfileById(id);
        if (existingProfile.isPresent()) {
            throw new UserProfileExistsException(id);
        }
        UserProfile profile = new UserProfile(id, email, fullName, birthDate);
        return userProfileRepository.save(profile);
    }

    public UserProfile getUserProfileById(String id) {
        return userProfileRepository
                .getUserProfileById(id)
                .orElseThrow(() -> new UserProfileNotFoundException(id));
    }
}
