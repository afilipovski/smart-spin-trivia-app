package com.example.smartspinapi.model.exception;

public class UserProfileExistsException extends RuntimeException {
  public UserProfileExistsException(String id) {
    super("User profile with id " + id + " already exists");
  }
}
