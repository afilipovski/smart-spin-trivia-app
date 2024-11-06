package com.example.smartspinapi.model.exception;

public class UserProfileAlreadyExistsException extends RuntimeException {
  public UserProfileAlreadyExistsException(String id) {
    super("User profile with id " + id + " already exists");
  }
}
