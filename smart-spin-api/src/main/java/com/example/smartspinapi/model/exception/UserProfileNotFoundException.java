package com.example.smartspinapi.model.exception;

public class UserProfileNotFoundException extends RuntimeException {
  public UserProfileNotFoundException(String id) {
    super("User profile with id " + id + " doesn't exist");
  }
}
