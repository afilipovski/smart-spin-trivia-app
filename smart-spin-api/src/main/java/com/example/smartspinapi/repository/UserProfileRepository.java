package com.example.smartspinapi.repository;

import com.example.smartspinapi.model.entity.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserProfileRepository extends JpaRepository<UserProfile, String> {
    Optional<UserProfile> getUserProfileById(String id);
    List<UserProfile> findAllByFullNameLike(String fullName);
}
