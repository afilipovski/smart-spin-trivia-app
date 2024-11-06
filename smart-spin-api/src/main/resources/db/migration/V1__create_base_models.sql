alter table if exists quiz
drop
constraint if exists FKg9jrladyteurgxqemcwg8t3sm;

alter table if exists quiz
drop
constraint if exists FKs5ig2wnpqeng8mq7wpqga9fr0;

alter table if exists quiz_question
drop
constraint if exists FKqos9fj49eqtt2atica3hifaw;

alter table if exists quiz_question
drop
constraint if exists FKakqyu5s2n32ycpvhkh9sx7m35;

alter table if exists quiz_question_choice
drop
constraint if exists FK52fu1bvy4qy8rda4aiwwvxwys;

alter table if exists quiz_session
drop
constraint if exists FK32rwh5bfaxrwdhneodb39il2;

alter table if exists quiz_session
drop
constraint if exists FKiv0bo0e0f1p69i01xyy19r32x;

alter table if exists quiz_session
drop
constraint if exists FKgg97qtqahfib7te01hli7ufq;

alter table if exists quiz_session_questions
drop
constraint if exists FKd7sdpod3c2tdcq71w9bhsu8s0;

alter table if exists quiz_session_questions
drop
constraint if exists FKoubmblffc9vuft3e09cm1jb8l;

alter table if exists user_profile_friends
drop
constraint if exists FK5lb28kivsykk6e7nl1oyom6uf;

alter table if exists user_profile_friends
drop
constraint if exists FKjucexl0egjmb7g5fvjm9d7f9d;

drop table if exists limited_time_event cascade;

drop table if exists quiz cascade;

drop table if exists quiz_category cascade;

drop table if exists quiz_question cascade;

drop table if exists quiz_question_choice cascade;

drop table if exists quiz_session cascade;

drop table if exists quiz_session_questions cascade;

drop table if exists user_profile cascade;

drop table if exists user_profile_friends cascade;

create table limited_time_event
(
    end_time   timestamp(6),
    start_time timestamp(6),
    id         uuid not null,
    primary key (id)
);

create table quiz
(
    xp_per_question  integer,
    event_id         uuid unique,
    id               uuid not null,
    quiz_category_id uuid,
    primary key (id)
);

create table quiz_category
(
    id   uuid not null,
    name varchar(255),
    primary key (id)
);

create table quiz_question
(
    category_id       uuid,
    correct_choice_id uuid unique,
    id                uuid not null,
    content           varchar(255),
    primary key (id)
);

create table quiz_question_choice
(
    id          uuid not null,
    question_id uuid,
    content     varchar(255),
    primary key (id)
);

create table quiz_session
(
    xp_collected                integer,
    time_active_question_served timestamp(6),
    active_question_id          uuid,
    id                          uuid not null,
    quiz_id                     uuid,
    join_code                   varchar(255),
    user_profile_id             varchar(255) unique,
    primary key (id)
);

create table quiz_session_questions
(
    questions_id    uuid not null,
    quiz_session_id uuid not null
);

create table user_profile
(
    birth_date           date,
    streak               integer,
    streak_last_extended timestamp(6) with time zone,
    email                varchar(255),
    full_name            varchar(255),
    id                   varchar(255) not null,
    primary key (id)
);

create table user_profile_friends
(
    friends_id      varchar(255) not null,
    user_profile_id varchar(255) not null
);

alter table if exists quiz
    add constraint FKg9jrladyteurgxqemcwg8t3sm
    foreign key (event_id)
    references limited_time_event;

alter table if exists quiz
    add constraint FKs5ig2wnpqeng8mq7wpqga9fr0
    foreign key (quiz_category_id)
    references quiz_category;

alter table if exists quiz_question
    add constraint FKqos9fj49eqtt2atica3hifaw
    foreign key (category_id)
    references quiz_category;

alter table if exists quiz_question
    add constraint FKakqyu5s2n32ycpvhkh9sx7m35
    foreign key (correct_choice_id)
    references quiz_question_choice;

alter table if exists quiz_question_choice
    add constraint FK52fu1bvy4qy8rda4aiwwvxwys
    foreign key (question_id)
    references quiz_question;

alter table if exists quiz_session
    add constraint FK32rwh5bfaxrwdhneodb39il2
    foreign key (active_question_id)
    references quiz_question;

alter table if exists quiz_session
    add constraint FKiv0bo0e0f1p69i01xyy19r32x
    foreign key (quiz_id)
    references quiz;

alter table if exists quiz_session
    add constraint FKgg97qtqahfib7te01hli7ufq
    foreign key (user_profile_id)
    references user_profile;

alter table if exists quiz_session_questions
    add constraint FKd7sdpod3c2tdcq71w9bhsu8s0
    foreign key (questions_id)
    references quiz_question;

alter table if exists quiz_session_questions
    add constraint FKoubmblffc9vuft3e09cm1jb8l
    foreign key (quiz_session_id)
    references quiz_session;

alter table if exists user_profile_friends
    add constraint FK5lb28kivsykk6e7nl1oyom6uf
    foreign key (friends_id)
    references user_profile;

alter table if exists user_profile_friends
    add constraint FKjucexl0egjmb7g5fvjm9d7f9d
    foreign key (user_profile_id)
    references user_profile;

alter table if exists quiz
drop
constraint if exists FKg9jrladyteurgxqemcwg8t3sm;

alter table if exists quiz
drop
constraint if exists FKs5ig2wnpqeng8mq7wpqga9fr0;

alter table if exists quiz_question
drop
constraint if exists FKqos9fj49eqtt2atica3hifaw;

alter table if exists quiz_question
drop
constraint if exists FKakqyu5s2n32ycpvhkh9sx7m35;

alter table if exists quiz_question_choice
drop
constraint if exists FK52fu1bvy4qy8rda4aiwwvxwys;

alter table if exists quiz_session
drop
constraint if exists FK32rwh5bfaxrwdhneodb39il2;

alter table if exists quiz_session
drop
constraint if exists FKiv0bo0e0f1p69i01xyy19r32x;

alter table if exists quiz_session
drop
constraint if exists FKgg97qtqahfib7te01hli7ufq;

alter table if exists quiz_session_questions
drop
constraint if exists FKd7sdpod3c2tdcq71w9bhsu8s0;

alter table if exists quiz_session_questions
drop
constraint if exists FKoubmblffc9vuft3e09cm1jb8l;

alter table if exists user_profile_friends
drop
constraint if exists FK5lb28kivsykk6e7nl1oyom6uf;

alter table if exists user_profile_friends
drop
constraint if exists FKjucexl0egjmb7g5fvjm9d7f9d;

drop table if exists limited_time_event cascade;

drop table if exists quiz cascade;

drop table if exists quiz_category cascade;

drop table if exists quiz_question cascade;

drop table if exists quiz_question_choice cascade;

drop table if exists quiz_session cascade;

drop table if exists quiz_session_questions cascade;

drop table if exists user_profile cascade;

drop table if exists user_profile_friends cascade;

create table limited_time_event
(
    end_time   timestamp(6),
    start_time timestamp(6),
    id         uuid not null,
    primary key (id)
);

create table quiz
(
    xp_per_question  integer,
    event_id         uuid unique,
    id               uuid not null,
    quiz_category_id uuid,
    primary key (id)
);

create table quiz_category
(
    id   uuid not null,
    name varchar(255),
    primary key (id)
);

create table quiz_question
(
    category_id       uuid,
    correct_choice_id uuid unique,
    id                uuid not null,
    content           varchar(255),
    primary key (id)
);

create table quiz_question_choice
(
    id          uuid not null,
    question_id uuid,
    content     varchar(255),
    primary key (id)
);

create table quiz_session
(
    xp_collected                integer,
    time_active_question_served timestamp(6),
    active_question_id          uuid,
    id                          uuid not null,
    quiz_id                     uuid,
    join_code                   varchar(255),
    user_profile_id             varchar(255) unique,
    primary key (id)
);

create table quiz_session_questions
(
    questions_id    uuid not null,
    quiz_session_id uuid not null
);

create table user_profile
(
    birth_date           date,
    streak               integer,
    streak_last_extended timestamp(6) with time zone,
    email                varchar(255),
    full_name            varchar(255),
    id                   varchar(255) not null,
    primary key (id)
);

create table user_profile_friends
(
    friends_id      varchar(255) not null,
    user_profile_id varchar(255) not null
);

alter table if exists quiz
    add constraint FKg9jrladyteurgxqemcwg8t3sm
    foreign key (event_id)
    references limited_time_event;

alter table if exists quiz
    add constraint FKs5ig2wnpqeng8mq7wpqga9fr0
    foreign key (quiz_category_id)
    references quiz_category;

alter table if exists quiz_question
    add constraint FKqos9fj49eqtt2atica3hifaw
    foreign key (category_id)
    references quiz_category;

alter table if exists quiz_question
    add constraint FKakqyu5s2n32ycpvhkh9sx7m35
    foreign key (correct_choice_id)
    references quiz_question_choice;

alter table if exists quiz_question_choice
    add constraint FK52fu1bvy4qy8rda4aiwwvxwys
    foreign key (question_id)
    references quiz_question;

alter table if exists quiz_session
    add constraint FK32rwh5bfaxrwdhneodb39il2
    foreign key (active_question_id)
    references quiz_question;

alter table if exists quiz_session
    add constraint FKiv0bo0e0f1p69i01xyy19r32x
    foreign key (quiz_id)
    references quiz;

alter table if exists quiz_session
    add constraint FKgg97qtqahfib7te01hli7ufq
    foreign key (user_profile_id)
    references user_profile;

alter table if exists quiz_session_questions
    add constraint FKd7sdpod3c2tdcq71w9bhsu8s0
    foreign key (questions_id)
    references quiz_question;

alter table if exists quiz_session_questions
    add constraint FKoubmblffc9vuft3e09cm1jb8l
    foreign key (quiz_session_id)
    references quiz_session;

alter table if exists user_profile_friends
    add constraint FK5lb28kivsykk6e7nl1oyom6uf
    foreign key (friends_id)
    references user_profile;

alter table if exists user_profile_friends
    add constraint FKjucexl0egjmb7g5fvjm9d7f9d
    foreign key (user_profile_id)
    references user_profile;
