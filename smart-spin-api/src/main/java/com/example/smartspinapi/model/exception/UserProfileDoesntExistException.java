package com.example.smartspinapi.model.exception;

public class UserProfileDoesntExistException extends RuntimeException {
  public UserProfileDoesntExistException(String id) {
    super("User profile with id " + id + " doesn't exist");
  }
}
