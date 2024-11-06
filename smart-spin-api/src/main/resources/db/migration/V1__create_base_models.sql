create table limited_time_event
(
    id         uuid not null,
    end_time   timestamp(6),
    start_time timestamp(6),
    primary key (id)
);

create table quiz
(
    id               uuid not null,
    xp_per_question  integer,
    event_id         uuid,
    quiz_category_id uuid,
    primary key (id)
);

create table quiz_category
(
    id   uuid not null,
    name varchar(255),
    primary key (id)
);

create table quiz_category_questions
(
    quiz_category_id uuid not null,
    questions_id     uuid not null
);

create table quiz_question
(
    id                uuid not null,
    content           varchar(255),
    category_id       uuid,
    correct_choice_id uuid,
    primary key (id)
);

create table quiz_question_choices
(
    quiz_question_id uuid not null,
    choices_id       uuid not null
);

create table quiz_question_choice
(
    id          uuid not null,
    content     varchar(255),
    question_id uuid,
    primary key (id)
);

create table quiz_session
(
    id                          uuid not null,
    join_code                   varchar(255),
    time_active_question_served timestamp(6),
    xp_collected                integer,
    active_question_id          uuid,
    quiz_id                     uuid,
    user_profile_id             varchar(255),
    primary key (id)
);

create table quiz_session_questions
(
    quiz_session_id uuid not null,
    questions_id    uuid not null
);

create table user_profile
(
    id                   varchar(255) not null,
    birthday             date,
    email                varchar(255),
    full_name            varchar(255),
    streak               integer,
    streak_last_extended date,
    primary key (id)
);

create table user_profile_friends
(
    user_profile_id varchar(255) not null,
    friends_id      varchar(255) not null
);

alter table if exists quiz
drop
constraint if exists UKcld7e3xryco2cqkyjroy8nil1;

alter table if exists quiz
    add constraint UKcld7e3xryco2cqkyjroy8nil1 unique (event_id);

alter table if exists quiz_category_questions
drop
constraint if exists UKkdi8cffrb4fivahetjgv6tbus;

alter table if exists quiz_category_questions
    add constraint UKkdi8cffrb4fivahetjgv6tbus unique (questions_id);

alter table if exists quiz_question
drop
constraint if exists UKqa94kvawox6yea07i02gmowe;

alter table if exists quiz_question
    add constraint UKqa94kvawox6yea07i02gmowe unique (correct_choice_id);

alter table if exists quiz_question_choices
drop
constraint if exists UKcrnhtj62acv97jsljvks0ag7h;

alter table if exists quiz_question_choices
    add constraint UKcrnhtj62acv97jsljvks0ag7h unique (choices_id);

alter table if exists quiz_session
drop
constraint if exists UKkjc4ys9hfp19200m9ls351p5h;

alter table if exists quiz_session
    add constraint UKkjc4ys9hfp19200m9ls351p5h unique (user_profile_id);

alter table if exists quiz
    add constraint FKg9jrladyteurgxqemcwg8t3sm
    foreign key (event_id)
    references limited_time_event;

alter table if exists quiz
    add constraint FKs5ig2wnpqeng8mq7wpqga9fr0
    foreign key (quiz_category_id)
    references quiz_category;

alter table if exists quiz_category_questions
    add constraint FKl4lvxvcqf5f8ltjdgn6jq5gls
    foreign key (questions_id)
    references quiz_question;

alter table if exists quiz_category_questions
    add constraint FK1grib9ryfpgbc15m3r2j0de7m
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

alter table if exists quiz_question_choices
    add constraint FK583hvfdfciu5rjyrja2yelttm
    foreign key (choices_id)
    references quiz_question_choice;

alter table if exists quiz_question_choices
    add constraint FKjfc0e5xj7oh64ce41tvusuvpw
    foreign key (quiz_question_id)
    references quiz_question;

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
