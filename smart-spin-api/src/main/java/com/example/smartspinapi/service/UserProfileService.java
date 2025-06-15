package com.example.smartspinapi.service;

import com.example.smartspinapi.model.dto.StreakEvaluationDTO;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.UserProfileExistsException;
import com.example.smartspinapi.model.exception.UserProfileNotFoundException;
import com.example.smartspinapi.repository.UserProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.*;
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

    public UserProfile extendStreak(String id, ZoneId currentZone) {
        UserProfile profile = userProfileRepository.getUserProfileById(id).orElseThrow();

        ZonedDateTime nowInCurrentZone = ZonedDateTime.now(currentZone);
        ZonedDateTime lastExtended = profile.getStreakLastExtended();

        if (lastExtended == null) {
            extend(profile, nowInCurrentZone);
            return userProfileRepository.save(profile);
        }

        LocalDate lastDate = lastExtended.withZoneSameInstant(currentZone).toLocalDate();
        LocalDate currentDate = nowInCurrentZone.toLocalDate();

        long daysBetween = Duration.between(lastDate.atStartOfDay(), currentDate.atStartOfDay()).toDays();

        if (daysBetween == 0) {
            return profile;
        } else if (daysBetween == 1) {
            extend(profile, nowInCurrentZone);
        } else {
            reset(profile, nowInCurrentZone);
        }

        return userProfileRepository.save(profile);
    }

    private void extend(UserProfile profile, ZonedDateTime newTime) {
        profile.setStreak(profile.getStreak() + 1);
        profile.setStreakLastExtended(newTime);
    }

    private void reset(UserProfile profile, ZonedDateTime newTime) {
        profile.setStreak(0);
        profile.setStreakLastExtended(newTime);
    }

    public StreakEvaluationDTO getEvaluatedStreak(String id, ZoneId currentZone) {
        UserProfile profile = userProfileRepository.getUserProfileById(id).orElseThrow();

        ZonedDateTime nowInCurrentZone = ZonedDateTime.now(currentZone);
        ZonedDateTime lastExtended = profile.getStreakLastExtended();

        int evaluatedStreak = profile.getStreak();
        boolean shouldReset = false;

        if (lastExtended != null) {
            LocalDate lastDate = lastExtended.withZoneSameInstant(currentZone).toLocalDate();
            LocalDate currentDate = nowInCurrentZone.toLocalDate();

            long daysBetween = Duration.between(lastDate.atStartOfDay(), currentDate.atStartOfDay()).toDays();

            if (daysBetween > 1) {
                evaluatedStreak = 0;
                shouldReset = true;
            }
        }

        return new StreakEvaluationDTO(evaluatedStreak, lastExtended, shouldReset);
    }

    public UserProfile getUserProfileById(String id) {
        return userProfileRepository
                .getUserProfileById(id)
                .orElseThrow(() -> new UserProfileNotFoundException(id));
    }

}