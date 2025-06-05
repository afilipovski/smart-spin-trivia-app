package com.example.smartspinapi.web;

import com.example.smartspinapi.model.dto.RegisterUserProfileDTO;
import com.example.smartspinapi.model.dto.StreakEvaluationDTO;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.UserProfileExistsException;
import com.example.smartspinapi.resolvers.TriviaUser;
import com.example.smartspinapi.service.UserProfileService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.ZonedDateTime;

@RestController
@RequestMapping("/user-profile")
@AllArgsConstructor
public class UserProfileController {
    private final UserProfileService userProfileService;

    @ExceptionHandler(UserProfileExistsException.class)
    public ResponseEntity<String> handleUserProfileAlreadyExistsException(UserProfileExistsException ex) {
        return ResponseEntity
                .status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(ex.getMessage());
    }

    @PostMapping("/register")
    public UserProfile registerUser(@RequestAttribute String uid,
                                    @RequestAttribute String email,
                                    @RequestBody RegisterUserProfileDTO registerUserProfileDTO) {
        return userProfileService.register(uid, email,
                registerUserProfileDTO.fullName,
                registerUserProfileDTO.birthDate);
    }

    @GetMapping("/streak")
    public StreakEvaluationDTO streak(@TriviaUser UserProfile userProfile, @RequestParam ZonedDateTime userTime) {
        return userProfileService.getEvaluatedStreak(userProfile.getId(), userTime.getZone());
    }
}
