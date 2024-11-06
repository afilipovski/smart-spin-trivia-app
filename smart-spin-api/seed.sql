-- Insert sample data into quiz_category
INSERT INTO quiz_category (id, name) VALUES
                                         ('d5e8efc0-1f83-4d9d-a7e9-1b4d5d4c0e6b', 'Science'),
                                         ('bbd4e43c-92e2-4a6e-9bd7-4fd67e4b0eec', 'History'),
                                         ('a1f8b2c7-4ad3-4e3e-a50c-7c1b5d8f0c9d', 'Math');

-- Insert sample data into quiz
INSERT INTO quiz (id, xp_per_question, quiz_category_id) VALUES
                                                             ('823d4940-9d3c-4e57-bd3a-4d1b45bcb6c6', 10, 'd5e8efc0-1f83-4d9d-a7e9-1b4d5d4c0e6b'),
                                                             ('d76e3d53-ff94-4a2e-9e85-0a2b5c6c1c8a', 15, 'bbd4e43c-92e2-4a6e-9bd7-4fd67e4b0eec');

-- Insert sample data into quiz_question
INSERT INTO quiz_question (category_id, id, content) VALUES
                                                         ('d5e8efc0-1f83-4d9d-a7e9-1b4d5d4c0e6b', '122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f6', 'What is the chemical symbol for water?'),
                                                         ('bbd4e43c-92e2-4a6e-9bd7-4fd67e4b0eec', '7a9c3d1b-5f7e-4a4c-a8f1-9f7b8e1c6d8e', 'Who was the first president of the United States?');

-- Insert sample data into quiz_question_choice
INSERT INTO quiz_question_choice (correct, id, question_id, content) VALUES
                                                                (TRUE, '273ed8a0-1f4a-4a9c-b9b4-5b9f7d1c6f3e', '122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f6', 'H2O'),
                                                                (FALSE, '96fe5a2e-9c6e-4d9b-a6b9-3e7d4f1c0c9f', '122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f6', 'CO2'),
                                                                (TRUE, 'd8a2c9f3-4b1f-4e6a-b2b7-9d4e1c6b0f5e', '7a9c3d1b-5f7e-4a4c-a8f1-9f7b8e1c6d8e', 'George Washington'),
                                                                (FALSE, '4e1f9b2d-7c6f-4a9e-9d5a-3c6f7e8b1d9f', '7a9c3d1b-5f7e-4a4c-a8f1-9f7b8e1c6d8e', 'Thomas Jefferson');



-- Insert sample data into user_profile
INSERT INTO user_profile (id, birth_date, streak, email, full_name) VALUES
                                                                        ('user1', '1990-01-01', 5, 'user1@example.com', 'Alice Johnson'),
                                                                        ('user2', '1985-06-15', 2, 'user2@example.com', 'Bob Smith');

-- Insert sample data into quiz_session
INSERT INTO quiz_session (id, xp_collected, active_question_id, quiz_id, join_code, user_profile_id) VALUES
    ('9b3f1d2e-8a9c-4f3e-a7d8-1e6f5b7d3c4f', 10, '122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f6', '823d4940-9d3c-4e57-bd3a-4d1b45bcb6c6', 'JOIN123', 'user1');

-- Insert sample data into quiz_session_questions
INSERT INTO quiz_session_questions (questions_id, quiz_session_id) VALUES
    ('122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f6', '9b3f1d2e-8a9c-4f3e-a7d8-1e6f5b7d3c4f');


-- Insert sample data into user_profile_friends
INSERT INTO user_profile_friends (user_profile_id, friends_id) VALUES
    ('user1', 'user2');
