package com.example.smartspinapi.model.dto.openai;

import java.util.List;

public class ChatCompletionResponse {
    public String id;
    public String object;
    public long created;
    public String model;
    public List<Choice> choices;
    public Usage usage;
    public String systemFingerprint;

    public static class Choice {
        public int index;
        public Message message;
        public String finishReason;
        public Object logprobs;
    }

    public static class Message {
        public String role;
        public String content;
    }

    public static class Usage {
        public int promptTokens;
        public int completionTokens;
        public int totalTokens;
        public PromptTokensDetails promptTokensDetails;
        public int promptCacheHitTokens;
        public int promptCacheMissTokens;
    }

    public static class PromptTokensDetails {
        public int cachedTokens;
    }
}
