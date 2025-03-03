package com.example.smartspinapi.service;

import com.example.smartspinapi.model.dto.AnswerQuestionResponseDTO;
import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.repository.QuizSessionRepository;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuizSessionService {
    private final QuizService quizService;
    private final QuizSessionRepository quizSessionRepository;

    public QuizSession createQuizSession(UUID quizId, UserProfile userProfile) {
        Quiz quiz = quizService.findById(quizId);
        if (userProfile.getQuizSession() != null)
            throw new EntityExistsException("Quiz session with user id " + userProfile.getId() + " already exists");
        QuizSession quizSession = new QuizSession(quiz, userProfile);
        return quizSessionRepository.save(quizSession);
    }

    public void setActiveQuestion(UserProfile userProfile, QuizQuestion quizQuestion) {
        QuizSession session = userProfile.getQuizSession();
        if (session == null) {
            throw new EntityNotFoundException("Quiz session with user id " + userProfile.getId() + " not found");
        }
        session.setActiveQuestion(quizQuestion);
        session.setTimeActiveQuestionServed(LocalDateTime.now());

        List<QuizQuestion> questions = session.getQuestions();
        if (questions == null) {
            questions = new ArrayList<>();
        }
        questions.add(quizQuestion);

        session.setQuestions(questions);
        quizSessionRepository.save(session);
    }

    public AnswerQuestionResponseDTO answerQuestion(UserProfile userProfile, String questionAnswer) {
        QuizSession session = userProfile.getQuizSession();
        if (session == null) {
            throw new EntityNotFoundException("Quiz session with user id " + userProfile.getId() + " not found");
        }
        if (session.getActiveQuestion() == null) {
            throw new EntityNotFoundException("Quiz session with user id " + userProfile.getId() + " doesn't have an active question");
        }

        AnswerQuestionResponseDTO response = new AnswerQuestionResponseDTO();

        String correctAnswer = session.getActiveQuestion().correctChoice().getContent();
        if (questionAnswer.equals(correctAnswer)) {
            response.status = "Correct";
            response.xpGain = session.getQuiz().getXpPerQuestion();
        }
        else {
            response.status = "Incorrect";
            response.xpGain = 0;
        }

        session.setActiveQuestion(null);
        quizSessionRepository.save(session);

        return response;
    }
}
