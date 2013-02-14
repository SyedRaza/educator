CREATE TABLE education_histories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    school_attended DATE,
    year_graduated DATE,
    major VARCHAR(255),
    user_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE educator_types (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE employment_grade_associations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employment_history_id INT,
    grade_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE employment_histories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    school_attended DATE,
    school_city VARCHAR(255),
    state VARCHAR(255),
    year_started DATE,
    year_ended DATE,
    user_id INT,
    subject_id INT,
    grade_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE employment_subject_associations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employment_history_id INT,
    subject_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE friend_requests (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    requesed_user_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE friends (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    friend_user_id INT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE grades (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE messages (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    from_user INT,
    to_user INT,
    read_flag BIT(0),
    subject VARCHAR(255),
    message TEXT,
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE schema_migrations (
    version VARCHAR(255) NOT NULL
);
CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations (version);
CREATE TABLE subjects (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME
);
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    nick_name VARCHAR(255),
    password VARCHAR(255),
    re_enter_password VARCHAR(255),
    educator_type_id INT,
    email VARCHAR(255),
    most_imp_exp TEXT,
    about_self TEXT,
    image_file_name VARCHAR(255),
    image_content_type VARCHAR(255),
    image_file_size INT,
    image_updated_at DATETIME,
    created_at DATETIME,
    updated_at DATETIME
);
