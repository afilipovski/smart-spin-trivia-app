package com.example.smartspinapi.model.dto.triviaapi;

import java.util.List;

public class TriviaApiQuestion {
    public String type;
    public String difficulty;
    public String category;
    public String question;
    public String correct_answer;
    public List<String> incorrect_answers;
}
