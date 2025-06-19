package com.example.smartspinapi.utils;

import java.util.Random;

public class QuizSessionJoinCodeGenerator {
    private static final String JOIN_CODE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int JOIN_CODE_LENGTH = 6;

    public static String generateCode() {
        Random random = new Random();
        StringBuilder code = new StringBuilder(JOIN_CODE_LENGTH);

        for (int i = 0; i < JOIN_CODE_LENGTH; i++) {
            int index = random.nextInt(JOIN_CODE_CHARACTERS.length());
            code.append(JOIN_CODE_CHARACTERS.charAt(index));
        }

        return code.toString();
    }
}
