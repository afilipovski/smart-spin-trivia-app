package com.example.smartspinapi.model.dto.openai;

import java.util.List;

public class ChatRequest {
    public String model;
    public List<ChatMessage> messages;
    public boolean stream;
}

