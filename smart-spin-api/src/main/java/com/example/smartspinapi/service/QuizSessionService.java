package com.example.smartspinapi.service;

import com.example.smartspinapi.model.dto.AnswerQuestionResponseDTO;
import com.example.smartspinapi.model.entity.Quiz;
import com.example.smartspinapi.model.entity.QuizQuestion;
import com.example.smartspinapi.model.entity.QuizSession;
import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.TriviaEntityNotFoundException;
import com.example.smartspinapi.repository.QuizSessionRepository;
import com.example.smartspinapi.utils.QuizSessionJoinCodeGenerator;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class QuizSessionService {
    private final QuizService quizService;
    private final QuizSessionRepository quizSessionRepository;
    private final MultiplayerQuizSessionService multiplayerQuizSessionService;

    public QuizSession createQuizSession(UUID quizId, UserProfile userProfile) {
        Quiz quiz = quizService.findById(quizId);
        if (userProfile.getQuizSession() != null)
            throw new EntityExistsException("Quiz session with user id " + userProfile.getId() + " already exists");

        String joinCode = QuizSessionJoinCodeGenerator.generateCode();
        QuizSession quizSession = new QuizSession(quiz, userProfile, joinCode);

        multiplayerQuizSessionService.createMultiplayerQuizSession(userProfile.getId(), quizSession);

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

        int currentXp = session.getXpCollected();
        session.setXpCollected(currentXp + response.xpGain);

        session.setActiveQuestion(null);
        quizSessionRepository.save(session);

        return response;
    }

    public QuizSession endQuizSession(UserProfile userProfile) {
        QuizSession session = quizSessionRepository.findByUserProfileId(userProfile.getId())
                .orElseThrow(() -> new EntityNotFoundException("Quiz session with id " + userProfile.getId() + " not found"));
        multiplayerQuizSessionService.removePlayerFromMultiplayerQuizSession(userProfile.getId(), session.joinCode);
        quizSessionRepository.delete(session);
        return session;
    }

    public QuizSession getQuizSession(UserProfile userProfile) {
        return quizSessionRepository.findByUserProfileId(userProfile.getId())
                .orElseThrow(() -> new TriviaEntityNotFoundException(QuizSession.class));
    }

    public QuizSession joinQuizSession(UserProfile userProfile, String joinCode) {
        QuizSession session = userProfile.getQuizSession();
        if (session != null) {
            throw new EntityExistsException("Quiz session with user id " + userProfile.getId() + " already exists");
        }

        QuizSession sessionToJoin = quizSessionRepository.findByJoinCode(joinCode)
                .orElseThrow(() -> new EntityNotFoundException("Quiz session with join code " + joinCode + " not found"));

        QuizSession newSession = new QuizSession();
        newSession.setJoinCode(joinCode);
        newSession.setUserProfile(userProfile);
        newSession.setQuiz(sessionToJoin.getQuiz());

        multiplayerQuizSessionService.addPlayerToMultiplayerQuizSession(userProfile.getId(), joinCode);

        return quizSessionRepository.save(newSession);
    }
}
