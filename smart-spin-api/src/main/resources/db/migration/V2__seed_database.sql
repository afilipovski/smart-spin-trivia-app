-- Insert sample data into user_profile
INSERT INTO user_profile (id, birth_date, streak, email, full_name) VALUES
                                                                        ('user1', '1990-01-01', 5, 'user1@example.com', 'Alice Johnson'),
                                                                        ('user2', '1985-06-15', 2, 'user2@example.com', 'Bob Smith');


-- Insert sample data into user_profile_friends
INSERT INTO user_friendship (friendship_accepted, id, friendship_initiator_id, friendship_receiver_id) VALUES
    (false, '122f9b2e-7f2e-4568-9e3e-1f82e8c0c5f7', 'user1', 'user2');
