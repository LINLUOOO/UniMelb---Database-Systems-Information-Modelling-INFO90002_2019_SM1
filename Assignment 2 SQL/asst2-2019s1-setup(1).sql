-- INFO90002 Assignment 2, '2019 sem1, setup script

set FOREIGN_KEY_CHECKS=false;

-- -----------------------------------------------------
-- uncomment and run these 3 SCHEMA commands if you are using your own server
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS wellness_app ;
-- CREATE SCHEMA IF NOT EXISTS wellness_app DEFAULT CHARACTER SET utf8 ;
-- USE wellness_app ;

-- ----------------------------------------------------
-- End uncomment
-- ----------------------------------------------------

-- -----------------------------------------------------
-- Table user
-- -----------------------------------------------------
DROP TABLE IF EXISTS user ;

CREATE TABLE IF NOT EXISTS user (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(128) NOT NULL,
  last_name VARCHAR(128) NOT NULL,
  DOB DATE NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
ROW_FORMAT = COMPRESSED;






-- -----------------------------------------------------
-- Table interest
-- -----------------------------------------------------
DROP TABLE IF EXISTS interest ;

CREATE TABLE IF NOT EXISTS interest (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;







-- -----------------------------------------------------
-- Table step
-- -----------------------------------------------------
DROP TABLE IF EXISTS step ;

CREATE TABLE IF NOT EXISTS step (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;











-- -----------------------------------------------------
-- Table theme
-- -----------------------------------------------------
DROP TABLE IF EXISTS theme ;

CREATE TABLE IF NOT EXISTS theme (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;








-- -----------------------------------------------------
-- Table user_follow
-- -----------------------------------------------------
DROP TABLE IF EXISTS user_follow ;

CREATE TABLE IF NOT EXISTS user_follow (
  id INT NOT NULL AUTO_INCREMENT,
  following_user_id INT NOT NULL,
  followed_user_id INT NOT NULL,
  weight INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX fk_user_user_connection_user1_idx (following_user_id ASC),
  INDEX fk_user_user_connection_user2_idx (followed_user_id ASC),
  CONSTRAINT fk_user_user_connection_user1
    FOREIGN KEY (following_user_id)
    REFERENCES user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_user_connection_user2
    FOREIGN KEY (followed_user_id)
    REFERENCES user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table user_interest
-- -----------------------------------------------------
DROP TABLE IF EXISTS user_interest ;

CREATE TABLE IF NOT EXISTS user_interest (
  user_id INT NOT NULL,
  interest_id INT NOT NULL,
  INDEX fk_user_interest_user1_idx (user_id ASC),
  INDEX fk_user_interest_interest1_idx (interest_id ASC),
  PRIMARY KEY (user_id, interest_id),
  CONSTRAINT fk_user_interest_user1
    FOREIGN KEY (user_id)
    REFERENCES user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_interest_interest1
    FOREIGN KEY (interest_id)
    REFERENCES interest (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table step_taken
-- -----------------------------------------------------
DROP TABLE IF EXISTS step_taken ;

CREATE TABLE IF NOT EXISTS step_taken (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  step_id INT NOT NULL,
  when_started TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  when_finished TIMESTAMP NULL,
  rating TINYINT NULL,
  INDEX fk_StepsTaken_User1 (user_id ASC),
  INDEX fk_steps_taken_step1_idx (step_id ASC),
  PRIMARY KEY (id),
  CONSTRAINT fk_StepsTaken_User1
    FOREIGN KEY (user_id)
    REFERENCES user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_steps_taken_step1
    FOREIGN KEY (step_id)
    REFERENCES step (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table step_theme
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS step_theme (
  theme_id INT NOT NULL,
  step_id INT NOT NULL,
  PRIMARY KEY (theme_id, step_id),
  INDEX fk_pathway_step_pathway1_idx (theme_id ASC),
  INDEX fk_pathway_step_step1_idx (step_id ASC),
  CONSTRAINT fk_pathway_step_pathway1
    FOREIGN KEY (theme_id)
    REFERENCES theme (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pathway_step_step1
    FOREIGN KEY (step_id)
    REFERENCES step (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;










INSERT INTO user VALUES(1,'Alice','Smith', '1999-01-01');
INSERT INTO user VALUES(2,'Bob','Singh', '2000-03-04');
INSERT INTO user VALUES(3,'Charlie','Nguyen', '2001-05-23');
INSERT INTO user VALUES(4,'Dan','Williams', '1999-01-11');
INSERT INTO user VALUES(5,'Eve','Brown', '1995-07-07');
INSERT INTO user VALUES(6,'Frank','Jones', '1998-02-22');
INSERT INTO user VALUES(7,'Grace','Wilson', '2001-10-02');
INSERT INTO user VALUES(8,'Heidi','Taylor', '1997-04-21');
INSERT INTO user VALUES(9,'Ian','Lee', '1997-12-30');
INSERT INTO user VALUES(10,'Judy','Tran', '1995-05-12');
INSERT INTO user VALUES(11,'Kath','Anderson', '1996-09-11');
INSERT INTO user VALUES(12,'Lee','Thomas', '1998-02-02');
INSERT INTO user VALUES(13,'Mallory','White', '2002-05-13');
INSERT INTO user VALUES(14,'Nick','Johnson', '1999-11-14');
INSERT INTO user VALUES(15,'Olivia','Martin', '2000-11-01');
INSERT INTO user VALUES(16,'Pat','Wang', '1995-01-01');
INSERT INTO user VALUES(17,'Quentin','Chen', '1996-04-12');
INSERT INTO user VALUES(18,'Robbie','Ryan', '1997-06-21');
INSERT INTO user VALUES(19,'Sam','Thompson', '2000-02-15');
INSERT INTO user VALUES(20,'Tracey','Young', '2001-03-25');

INSERT INTO user_follow VALUES(1, 1,2,0);
INSERT INTO user_follow VALUES(2, 2,1,0);
INSERT INTO user_follow VALUES(3, 3,20,0);
INSERT INTO user_follow VALUES(4, 4,14,0);
INSERT INTO user_follow VALUES(5, 5,6,0);
INSERT INTO user_follow VALUES(6, 19,3,0);
INSERT INTO user_follow VALUES(7, 19,4,0);
INSERT INTO user_follow VALUES(8, 4,20,0);
INSERT INTO user_follow VALUES(9, 15,7,0);
INSERT INTO user_follow VALUES(10, 7,8,0);
INSERT INTO user_follow VALUES(11, 7,15,0);
INSERT INTO user_follow VALUES(12, 14,12,0);
INSERT INTO user_follow VALUES(13, 14,13,0);
INSERT INTO user_follow VALUES(14, 5,7,0);
INSERT INTO user_follow VALUES(15, 5,8,0);
INSERT INTO user_follow VALUES(16, 3,2,0);
INSERT INTO user_follow VALUES(17, 3,18,0);
INSERT INTO user_follow VALUES(18, 18,17,0);
INSERT INTO user_follow VALUES(19, 16,11,0);
INSERT INTO user_follow VALUES(20, 11,10,0);











INSERT INTO interest VALUES(1, 'Rock Climbing');
INSERT INTO interest VALUES(2, 'The Simpsons');
INSERT INTO interest VALUES(3, 'Football');
INSERT INTO interest VALUES(4, 'Tennis');
INSERT INTO interest VALUES(5, 'Python');
INSERT INTO interest VALUES(6, 'SQL');
INSERT INTO interest VALUES(7, 'Data Science');
INSERT INTO interest VALUES(8, 'Science Fiction');
INSERT INTO interest VALUES(9, 'Cycling');
INSERT INTO interest VALUES(10, 'Cinema');
INSERT INTO interest VALUES(11, 'Classical Music');
INSERT INTO interest VALUES(12, 'Poetry');



INSERT INTO user_interest VALUES(1, 1);
INSERT INTO user_interest VALUES(2, 2);
INSERT INTO user_interest VALUES(3, 3);
INSERT INTO user_interest VALUES(4, 4);
INSERT INTO user_interest VALUES(5, 5);
INSERT INTO user_interest VALUES(6, 6);
INSERT INTO user_interest VALUES(7, 7);
INSERT INTO user_interest VALUES(8, 8);
INSERT INTO user_interest VALUES(9, 9);
INSERT INTO user_interest VALUES(10, 10);
INSERT INTO user_interest VALUES(11, 11);
INSERT INTO user_interest VALUES(12, 12);
INSERT INTO user_interest VALUES(9, 1);
INSERT INTO user_interest VALUES(10, 2);
INSERT INTO user_interest VALUES(11, 3);
INSERT INTO user_interest VALUES(12, 4);
INSERT INTO user_interest VALUES(13, 5);
INSERT INTO user_interest VALUES(14, 6);
INSERT INTO user_interest VALUES(15, 7);
INSERT INTO user_interest VALUES(16, 8);
INSERT INTO user_interest VALUES(17, 9);
INSERT INTO user_interest VALUES(18, 10);
INSERT INTO user_interest VALUES(19, 11);
INSERT INTO user_interest VALUES(20, 12);
INSERT INTO user_interest VALUES(7, 1);
INSERT INTO user_interest VALUES(6, 2);
INSERT INTO user_interest VALUES(5, 3);
INSERT INTO user_interest VALUES(3, 5);
INSERT INTO user_interest VALUES(2, 6);
INSERT INTO user_interest VALUES(1, 7);
INSERT INTO user_interest VALUES(20, 8);
INSERT INTO user_interest VALUES(19, 9);
INSERT INTO user_interest VALUES(10, 18);
INSERT INTO user_interest VALUES(17, 11);
INSERT INTO user_interest VALUES(16, 12);
INSERT INTO user_interest VALUES(14, 1);
INSERT INTO user_interest VALUES(15, 2);
INSERT INTO user_interest VALUES(16, 3);
INSERT INTO user_interest VALUES(17, 4);
INSERT INTO user_interest VALUES(18, 5);
INSERT INTO user_interest VALUES(19, 6);
INSERT INTO user_interest VALUES(20, 7);
INSERT INTO user_interest VALUES(1, 8);
INSERT INTO user_interest VALUES(2, 9);
INSERT INTO user_interest VALUES(3, 10);
INSERT INTO user_interest VALUES(4, 11);
INSERT INTO user_interest VALUES(5, 12);













INSERT INTO step VALUES(51, 'Body scan');
INSERT INTO step VALUES(54, 'Body and breath');
INSERT INTO step VALUES(55, 'Tuning in');
INSERT INTO step VALUES(56, 'Anchor yourself');
INSERT INTO step VALUES(57, 'Everyday mindfulness');
INSERT INTO step VALUES(67, 'Mindful movement');
INSERT INTO step VALUES(68, 'Mindful emotions');
INSERT INTO step VALUES(69, 'Mindful thoughts');
INSERT INTO step VALUES(70, 'Heartfulness');
INSERT INTO step VALUES(73, 'Being with difficulty');
INSERT INTO step VALUES(74, 'Self talk');
INSERT INTO step VALUES(75, 'Compassion for others');
INSERT INTO step VALUES(111, 'Introduction to mindfulness');
INSERT INTO step VALUES(112, 'Introduction to self compassion');
INSERT INTO step VALUES(113, 'Things that go bump in the night');
INSERT INTO step VALUES(115, 'Introduction to anxiety');
INSERT INTO step VALUES(116, 'The banshee');
INSERT INTO step VALUES(117, 'Breathing relaxation');
INSERT INTO step VALUES(122, 'Introduction to depression');
INSERT INTO step VALUES(123, 'Rumination');
INSERT INTO step VALUES(124, 'Introduction to social anxiety');
INSERT INTO step VALUES(125, 'Fortune telling');
INSERT INTO step VALUES(126, 'Unpopular mechanics');
INSERT INTO step VALUES(127, 'Navigating physical symptoms');
INSERT INTO step VALUES(128, 'Ice breaking and conversation making');
INSERT INTO step VALUES(129, 'Chameleon dreams');
INSERT INTO step VALUES(130, 'Perfectly rolled');
INSERT INTO step VALUES(131, 'Dark skies, bright stars');
INSERT INTO step VALUES(132, 'Monsters, kittens and popcorn');
INSERT INTO step VALUES(133, 'Beautiful broken things');
INSERT INTO step VALUES(134, 'Connecting with strengths');
INSERT INTO step VALUES(135, 'Three minute breathing space');
INSERT INTO step VALUES(136, 'Coping with strengths');
INSERT INTO step VALUES(137, 'Enhancing with strengths');
INSERT INTO step VALUES(138, 'Introduction to strengths');
INSERT INTO step VALUES(139, 'Strengths for work and study');
INSERT INTO step VALUES(140, 'Savouring');
INSERT INTO step VALUES(141, 'Doing and being');
INSERT INTO step VALUES(142, 'Exposure song');
INSERT INTO step VALUES(143, 'Panic');
INSERT INTO step VALUES(144, 'Negative thought spirals');
INSERT INTO step VALUES(145, 'Positive thought spirals');
INSERT INTO step VALUES(146, 'A thought is a thought');
INSERT INTO step VALUES(148, 'Triggers and warning signs');
INSERT INTO step VALUES(149, 'Wellness action plan');
INSERT INTO step VALUES(150, 'Depression and motivation');
INSERT INTO step VALUES(152, 'Night of the Bloodstones');
INSERT INTO step VALUES(155, 'What ifs');
INSERT INTO step VALUES(156, 'The problem with perfection');
    
    
    


INSERT INTO theme VALUES(1, 'Social Anxiety');
INSERT INTO theme VALUES(2, 'Your Strengths');
INSERT INTO theme VALUES(6, 'Depression');
INSERT INTO theme VALUES(7, 'Anxiety');
INSERT INTO theme VALUES(8, 'Self Compassion');
INSERT INTO theme VALUES(9, 'Mindfulness');








INSERT INTO step_theme VALUES(6, 51);
INSERT INTO step_theme VALUES(9, 51);
INSERT INTO step_theme VALUES(9, 54);
INSERT INTO step_theme VALUES(9, 55);
INSERT INTO step_theme VALUES(9, 56);
INSERT INTO step_theme VALUES(7, 57);
INSERT INTO step_theme VALUES(9, 57);
INSERT INTO step_theme VALUES(6, 67);
INSERT INTO step_theme VALUES(9, 67);
INSERT INTO step_theme VALUES(9, 68);
INSERT INTO step_theme VALUES(7, 69);
INSERT INTO step_theme VALUES(9, 69);
INSERT INTO step_theme VALUES(9, 70);
INSERT INTO step_theme VALUES(6, 73);
INSERT INTO step_theme VALUES(7, 73);
INSERT INTO step_theme VALUES(8, 73);
INSERT INTO step_theme VALUES(7, 74);
INSERT INTO step_theme VALUES(8, 74);
INSERT INTO step_theme VALUES(8, 75);
INSERT INTO step_theme VALUES(9, 111);
INSERT INTO step_theme VALUES(8, 112);
INSERT INTO step_theme VALUES(7, 113);
INSERT INTO step_theme VALUES(7, 115);
INSERT INTO step_theme VALUES(7, 116);
INSERT INTO step_theme VALUES(7, 117);
INSERT INTO step_theme VALUES(6, 122);
INSERT INTO step_theme VALUES(6, 123);
INSERT INTO step_theme VALUES(1, 124);
INSERT INTO step_theme VALUES(1, 125);
INSERT INTO step_theme VALUES(1, 126);
INSERT INTO step_theme VALUES(1, 127);
INSERT INTO step_theme VALUES(1, 128);
INSERT INTO step_theme VALUES(1, 129);
INSERT INTO step_theme VALUES(1, 130);
INSERT INTO step_theme VALUES(1, 131);
INSERT INTO step_theme VALUES(1, 132);
INSERT INTO step_theme VALUES(1, 133);
INSERT INTO step_theme VALUES(2, 134);
INSERT INTO step_theme VALUES(6, 135);
INSERT INTO step_theme VALUES(2, 136);
INSERT INTO step_theme VALUES(2, 137);
INSERT INTO step_theme VALUES(2, 138);
INSERT INTO step_theme VALUES(2, 139);
INSERT INTO step_theme VALUES(6, 141);
INSERT INTO step_theme VALUES(7, 142);
INSERT INTO step_theme VALUES(7, 143);
INSERT INTO step_theme VALUES(6, 144);
INSERT INTO step_theme VALUES(6, 146);
INSERT INTO step_theme VALUES(6, 148);
INSERT INTO step_theme VALUES(6, 149);
INSERT INTO step_theme VALUES(6, 150);
INSERT INTO step_theme VALUES(7, 152);
INSERT INTO step_theme VALUES(7, 155);
INSERT INTO step_theme VALUES(7, 156);
    
    































INSERT INTO step_taken VALUES(1, 11, 141, '2018-04-23 01:21:39', '2018-04-23 01:21:45', 5);
INSERT INTO step_taken VALUES(2, 10, 70, '2018-04-23 10:50:31', '2018-04-23 10:51:27', 1);
INSERT INTO step_taken VALUES(3, 5, 111, '2018-04-23 11:07:02', NULL, 4);
INSERT INTO step_taken VALUES(4, 9, 135, '2018-04-23 15:12:58', '2018-04-23 15:13:20', 2);
INSERT INTO step_taken VALUES(5, 9, 135, '2018-04-23 20:52:41', '2018-04-23 20:53:19', 5);
INSERT INTO step_taken VALUES(6, 9, 135, '2018-04-23 20:53:34', NULL, 3);
INSERT INTO step_taken VALUES(7, 12, 135, '2018-04-23 21:31:54', '2018-04-23 21:31:59', 3);
INSERT INTO step_taken VALUES(8, 12, 141, '2018-04-23 21:42:48', '2018-04-23 21:43:10', 4);
INSERT INTO step_taken VALUES(9, 12, 112, '2018-04-23 21:46:14', '2018-04-23 21:47:05', 4);
INSERT INTO step_taken VALUES(10, 6, 111, '2018-04-24 13:39:37', '2018-04-24 13:39:46', 4);
INSERT INTO step_taken VALUES(11, 6, 111, '2018-04-24 13:39:54', NULL, 4);
INSERT INTO step_taken VALUES(12, 12, 111, '2018-04-24 14:59:26', NULL, 4);
INSERT INTO step_taken VALUES(13, 12, 138, '2018-04-26 09:57:00', '2018-04-26 09:57:56', 5);
INSERT INTO step_taken VALUES(14, 12, 137, '2018-04-26 09:58:04', '2018-04-26 09:58:45', 5);
INSERT INTO step_taken VALUES(15, 12, 134, '2018-04-26 09:59:02', '2018-04-26 09:59:27', 5);
INSERT INTO step_taken VALUES(16, 12, 136, '2018-04-26 09:59:31', '2018-04-26 10:00:19', 2);
INSERT INTO step_taken VALUES(17, 12, 139, '2018-04-26 10:00:24', '2018-04-26 10:01:15', 1);
INSERT INTO step_taken VALUES(18, 2, 112, '2018-04-26 11:47:02', '2018-04-26 11:48:02', 1);
INSERT INTO step_taken VALUES(19, 16, 73, '2018-04-27 15:37:31', '2018-04-27 15:37:46', 2);
INSERT INTO step_taken VALUES(20, 16, 124, '2018-04-27 15:48:33', '2018-04-27 15:48:38', 4);
INSERT INTO step_taken VALUES(21, 16, 125, '2018-04-27 15:48:41', '2018-04-27 15:48:48', 4);
INSERT INTO step_taken VALUES(22, 16, 126, '2018-04-27 15:48:52', '2018-04-27 15:49:15', 5);
INSERT INTO step_taken VALUES(23, 16, 127, '2018-04-27 15:49:22', '2018-04-27 15:55:43', 4);
INSERT INTO step_taken VALUES(24, 11, 73, '2018-04-27 16:06:32', NULL, 3);
INSERT INTO step_taken VALUES(25, 5, 146, '2018-04-30 08:59:10', '2018-04-30 09:02:56', 2);
INSERT INTO step_taken VALUES(26, 5, 122, '2018-04-30 09:06:59', NULL, 3);
INSERT INTO step_taken VALUES(27, 12, 146, '2018-04-30 10:35:09', '2018-04-30 10:36:24', 4);
INSERT INTO step_taken VALUES(28, 12, 146, '2018-04-30 10:44:48', '2018-04-30 10:44:56', 4);
INSERT INTO step_taken VALUES(29, 12, 141, '2018-05-01 10:11:53', NULL, 4);
INSERT INTO step_taken VALUES(30, 12, 117, '2018-05-01 22:22:44', '2018-05-01 22:23:20', 4);
INSERT INTO step_taken VALUES(31, 4, 112, '2018-05-01 23:19:53', '2018-05-01 23:22:02', 5);
INSERT INTO step_taken VALUES(32, 4, 73, '2018-05-01 23:25:53', '2018-05-01 23:27:38', 5);
INSERT INTO step_taken VALUES(33, 12, 133, '2018-05-02 08:15:29', NULL, 4);
INSERT INTO step_taken VALUES(34, 4, 74, '2018-05-03 21:45:36', '2018-05-03 21:47:14', 3);
INSERT INTO step_taken VALUES(35, 4, 75, '2018-05-03 21:52:30', NULL, 4);
INSERT INTO step_taken VALUES(36, 4, 75, '2018-05-05 00:23:35', '2018-05-05 00:24:20', 5);
INSERT INTO step_taken VALUES(37, 11, 146, '2018-05-08 14:41:18', NULL, 4);
INSERT INTO step_taken VALUES(38, 5, 122, '2018-05-09 20:24:24', '2018-05-09 20:25:36', 5);
INSERT INTO step_taken VALUES(39, 4, 122, '2018-05-10 11:56:37', NULL, 4);
INSERT INTO step_taken VALUES(40, 1, 132, '2018-05-11 10:22:22', '2018-05-11 10:22:42', 3);
INSERT INTO step_taken VALUES(41, 17, 122, '2018-05-11 10:24:32', '2018-05-11 10:24:45', 4);
INSERT INTO step_taken VALUES(42, 17, 146, '2018-05-11 10:36:27', '2018-05-11 10:37:12', 5);
INSERT INTO step_taken VALUES(43, 17, 56, '2018-05-11 10:40:40', NULL, 5);
INSERT INTO step_taken VALUES(44, 17, 133, '2018-05-11 10:41:54', '2018-05-11 10:42:08', 5);
INSERT INTO step_taken VALUES(45, 17, 129, '2018-05-11 11:05:17', '2018-05-11 11:05:31', 4);
INSERT INTO step_taken VALUES(46, 17, 136, '2018-05-11 11:06:20', '2018-05-11 11:07:12', 5);
INSERT INTO step_taken VALUES(47, 17, 135, '2018-05-11 11:08:16', '2018-05-11 11:08:41', 4);
INSERT INTO step_taken VALUES(48, 17, 112, '2018-05-11 11:09:00', '2018-05-11 11:09:31', 5);
INSERT INTO step_taken VALUES(49, 4, 122, '2018-05-11 11:18:04', '2018-05-11 11:19:03', 4);
INSERT INTO step_taken VALUES(50, 4, 124, '2018-05-11 11:34:58', '2018-05-11 11:35:15', 5);
INSERT INTO step_taken VALUES(51, 9, 156, '2018-05-11 12:24:13', '2018-05-11 12:25:04', 3);
INSERT INTO step_taken VALUES(52, 8, 122, '2018-05-11 14:07:01', '2018-05-11 14:10:56', 3);
INSERT INTO step_taken VALUES(53, 8, 122, '2018-05-11 14:19:51', '2018-05-11 14:20:00', 1);
INSERT INTO step_taken VALUES(54, 1, 73, '2018-05-11 15:13:08', NULL, 2);
INSERT INTO step_taken VALUES(55, 2, 73, '2018-05-11 15:32:34', '2018-05-11 15:33:26', 3);
INSERT INTO step_taken VALUES(56, 17, 73, '2018-05-11 18:15:05', '2018-05-11 18:16:12', 4);
INSERT INTO step_taken VALUES(57, 17, 141, '2018-05-11 18:19:02', '2018-05-11 19:23:47', 5);
INSERT INTO step_taken VALUES(58, 17, 137, '2018-05-13 17:54:59', '2018-05-13 17:55:47', 5);
INSERT INTO step_taken VALUES(59, 2, 136, '2018-05-13 17:56:06', NULL, 4);
INSERT INTO step_taken VALUES(60, 17, 138, '2018-05-14 21:48:48', '2018-05-14 21:49:05', 5);
INSERT INTO step_taken VALUES(61, 17, 137, '2018-05-14 21:49:24', '2018-05-14 21:49:39', 4);
INSERT INTO step_taken VALUES(62, 17, 134, '2018-05-14 21:49:55', '2018-05-14 21:50:45', 5);
INSERT INTO step_taken VALUES(63, 17, 136, '2018-05-14 21:50:51', NULL, 4);
INSERT INTO step_taken VALUES(64, 2, 141, '2018-05-15 09:21:58', '2018-06-21 10:20:03', 4);
INSERT INTO step_taken VALUES(65, 5, 122, '2018-05-15 22:25:43', NULL, 3);
INSERT INTO step_taken VALUES(66, 1, 136, '2018-05-16 12:32:52', NULL, 4);
INSERT INTO step_taken VALUES(67, 17, 155, '2018-05-16 12:33:28', '2018-05-16 12:34:59', 3);
INSERT INTO step_taken VALUES(68, 17, 148, '2018-05-16 12:35:20', '2018-05-16 12:36:06', 4);
INSERT INTO step_taken VALUES(69, 17, 122, '2018-05-16 15:25:44', '2018-05-16 15:26:02', 5);
INSERT INTO step_taken VALUES(70, 2, 141, '2018-05-16 15:26:18', '2018-05-16 15:27:07', 5);
INSERT INTO step_taken VALUES(71, 1, 141, '2018-05-16 15:32:21', NULL, 5);
INSERT INTO step_taken VALUES(72, 12, 135, '2018-05-16 23:24:45', '2018-05-16 23:25:26', 1);
INSERT INTO step_taken VALUES(73, 16, 128, '2018-05-17 13:01:33', '2018-05-17 13:02:31', 5);
INSERT INTO step_taken VALUES(74, 16, 129, '2018-05-17 13:04:23', '2018-05-17 13:05:37', 2);
INSERT INTO step_taken VALUES(75, 12, 128, '2018-05-17 13:06:17', '2018-05-17 13:07:48', 4);
INSERT INTO step_taken VALUES(76, 16, 130, '2018-05-17 13:11:52', '2018-05-17 13:13:06', 3);
INSERT INTO step_taken VALUES(77, 16, 131, '2018-05-17 13:16:51', '2018-05-17 13:18:59', 4);
INSERT INTO step_taken VALUES(78, 16, 132, '2018-05-17 14:32:32', '2018-05-17 14:34:00', 4);
INSERT INTO step_taken VALUES(79, 16, 133, '2018-05-17 14:36:54', '2018-05-17 14:38:41', 5);
INSERT INTO step_taken VALUES(80, 12, 132, '2018-05-17 15:12:58', NULL, 5);
INSERT INTO step_taken VALUES(81, 17, 141, '2018-05-18 00:01:10', '2018-05-18 00:01:41', 4);
INSERT INTO step_taken VALUES(82, 8, 123, '2018-05-18 10:27:34', NULL, 4);
INSERT INTO step_taken VALUES(83, 8, 123, '2018-05-18 11:02:04', '2018-05-18 11:04:01', 5);
INSERT INTO step_taken VALUES(84, 8, 141, '2018-05-18 12:36:46', NULL, 5);
INSERT INTO step_taken VALUES(85, 8, 141, '2018-05-18 12:43:42', '2018-05-18 12:45:04', 4);
INSERT INTO step_taken VALUES(86, 8, 51, '2018-05-18 15:13:36', '2018-05-18 15:14:33', 4);
INSERT INTO step_taken VALUES(87, 16, 74, '2018-05-18 15:56:55', '2018-05-18 15:57:34', 4);
INSERT INTO step_taken VALUES(88, 16, 155, '2018-05-18 16:12:34', '2018-05-18 16:13:42', 5);
INSERT INTO step_taken VALUES(89, 17, 51, '2018-05-18 16:16:26', '2018-05-18 16:16:51', 5);
INSERT INTO step_taken VALUES(90, 17, 135, '2018-05-18 16:19:25', '2018-05-18 16:19:35', 5);
INSERT INTO step_taken VALUES(91, 17, 144, '2018-05-18 16:20:02', '2018-05-18 17:01:19', 5);
INSERT INTO step_taken VALUES(92, 8, 135, '2018-05-18 16:38:42', '2018-05-18 16:40:10', 4);
INSERT INTO step_taken VALUES(93, 8, 144, '2018-05-18 17:21:42', '2018-05-18 17:23:01', 4);
INSERT INTO step_taken VALUES(94, 8, 146, '2018-05-18 17:55:10', '2018-05-18 17:57:25', 4);
INSERT INTO step_taken VALUES(95, 8, 73, '2018-05-18 18:06:34', '2018-05-18 18:08:22', 5);
INSERT INTO step_taken VALUES(96, 8, 67, '2018-05-18 18:27:58', '2018-05-18 18:32:14', 5);
INSERT INTO step_taken VALUES(97, 4, 125, '2018-05-19 10:01:26', '2018-05-19 10:03:12', 5);
INSERT INTO step_taken VALUES(98, 8, 148, '2018-05-19 10:54:12', '2018-05-19 10:56:37', 1);
INSERT INTO step_taken VALUES(99, 8, 150, '2018-05-19 12:20:59', '2018-05-19 17:00:56', 3);
INSERT INTO step_taken VALUES(100, 12, 115, '2018-05-21 18:00:36', '2018-05-21 18:02:30', 5);





set FOREIGN_KEY_CHECKS=true;
