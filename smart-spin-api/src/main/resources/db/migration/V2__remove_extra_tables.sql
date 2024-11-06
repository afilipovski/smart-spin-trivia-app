alter table if exists user_profile
    add column birth_date date;
alter table if exists user_profile
    drop column birthday;

alter table if exists user_profile
alter
column streak_last_extended set data type timestamp(6) with time zone;


drop table quiz_category_questions;
drop table quiz_question_choices;