/*
Assignment 2: SQL INDIVIDUAL PROJECT (10%)
Name: Vinh Nguyen (ID 1029531)
*/

/*
1. List the full names (e.g. Alice Smith), as one column, of the users who have not taken any Steps yet. (1) 
*/
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM user
WHERE id NOT IN (SELECT DISTINCT user_id FROM step_taken);

/*
2. List all of the IDs and titles of Steps that contain the substring ‘mindful’ in their title. (1) 
*/
SELECT id, title
FROM step
WHERE title LIKE '%mindful%';

/*
3. Provide a list of the titles of all Steps completed by user with id = 17. Do not show duplicates (list each title only once). (2) 
*/
SELECT DISTINCT title
FROM
	# Step IDs completed by user with id = 17
	(SELECT DISTINCT step_id
	FROM step_taken
	WHERE user_id = 17 AND when_finished IS NOT NULL) AS step_user17

    LEFT JOIN step
    ON step_user17.step_id = step.id;
    
/*
4. Provide a list of the titles of all Steps that have been taken more than two times along with a count of how many times. (2)
*/
SELECT step.title, popular_step.step_count
FROM
	# Steps that have been taken more than two times
	(SELECT step_id, COUNT(id) AS step_count
	FROM step_taken
	GROUP BY step_id
    HAVING step_count > 2) AS popular_step
    
    LEFT JOIN step
	ON popular_step.step_id = step.id;
    
/*
 5. Which Step(s), listed with columns id, title and the count of times taken, have been taken the greatest number of times? (3) 
*/
SELECT most_popular_step.step_id, step.title, most_popular_step.step_count
FROM
	# Step IDs taken the greatest number of times
	(SELECT step_id, COUNT(id) AS step_count
	FROM step_taken
	GROUP BY step_id
	HAVING step_count =
		# Max count
		(SELECT COUNT(id) AS step_count
		FROM step_taken
		GROUP BY step_id
		ORDER BY step_count DESC
		LIMIT 1)
	) AS most_popular_step
    
    LEFT JOIN step
    ON most_popular_step.step_id = step.id;
    
/*
6. List each Step with the title column, along with a count of how many times that Step has been taken and the average
rating received by the Step (formatted to 2 decimal places). Order the result by the average rating as a number in
descending order. (3)
*/
SELECT step.title, average_rating.step_count, average_rating.avg_rating
FROM
	# how many times a Step has been taken and the average rating received by the Step
	(SELECT step_id, COUNT(id) AS step_count, FORMAT(AVG(rating), 2) AS avg_rating
	FROM step_taken
	GROUP BY step_id) AS average_rating
    
    RIGHT JOIN step
    ON average_rating.step_id = step.id
ORDER BY average_rating.avg_rating DESC;

/*
7. Provide a list of the titles of all Steps that have been taken by both Alice (id = 1) and Bob (id == 2), along with the
combined number of times they have taken the Step. (4)
*/
SELECT step.title, user_1_2.step_count
FROM
	# Step IDs and times taken by both user id 1 and user id 2
	(SELECT step_id, COUNT(id) AS step_count
	FROM
		# Steps taken by either user id 1 or user id 2
		(SELECT *
		FROM step_taken
		WHERE user_id IN (1, 2)) AS user_1_2
	GROUP BY step_id
	HAVING COUNT(DISTINCT user_id) = 2) AS user_1_2
    
    LEFT JOIN step
    ON user_1_2.step_id = step.id;

/*
8. List users older than or equal to 21 years of age, along with a count of how many other users they are following
and a count of how many other users are following them. List the user’s id, first name, last name, age, following
count and followed count, and order the results by first name ascending, then last name ascending. (4)
*/
SELECT follow_21.*, COUNT(user_follow.following_user_id) AS followed_count
FROM
	# Following count included
	(SELECT follow_21.*, COUNT(user_follow.followed_user_id) as following_count
	FROM
		# Age >= 21
		(SELECT id, first_name, last_name, TIMESTAMPDIFF(YEAR, DOB, CURRENT_TIMESTAMP) AS age
		FROM user
		WHERE TIMESTAMPDIFF(YEAR, DOB, CURRENT_TIMESTAMP) >= 21) AS follow_21
        
		LEFT JOIN user_follow
		ON follow_21.id = user_follow.following_user_id
	GROUP BY follow_21.id) AS follow_21
    
    LEFT JOIN user_follow
    ON follow_21.id = user_follow.followed_user_id
GROUP BY follow_21.id
ORDER BY follow_21.first_name ASC, follow_21.last_name ASC;

/*
9. For each (user, theme) pair such that user has taken some steps under the theme, provide a count of how many times
a user has taken a step that is categorised under the theme. The output should consist of user ID, user first name,
user last name, theme name and the count of steps taken. (5)
*/
SELECT user_theme.user_id, user.first_name, user.last_name, theme.name AS theme_name, user_theme.step_count
FROM
	# user_id|theme_id|step_count
	(SELECT step_taken.user_id, step_theme.theme_id, COUNT(step_taken.id) AS step_count
	FROM 
		step_taken
		INNER JOIN step_theme
		ON step_taken.step_id = step_theme.step_id
	GROUP BY step_taken.user_id, step_theme.theme_id) AS user_theme
    
	INNER JOIN user
    ON user_theme.user_id = user.id
    
    INNER JOIN theme
    ON user_theme.theme_id = theme.id;
    
/*
10. A) Provide a complete list of all user ID pairs such that the two users follow each other and share at least one
interest. (Hint: MySQL has a CROSS JOIN operator, which returns the Cartesian product of rows from the joined
tables) (5)
*/
SELECT pair.*
FROM
	# Users follow each other
	(SELECT uf1.following_user_id AS user_id1, uf1.followed_user_id AS user_id2
	FROM 
		user_follow AS uf1
		CROSS JOIN user_follow AS uf2
	WHERE 
		uf1.following_user_id < uf1.followed_user_id
		AND uf2.following_user_id > uf2.followed_user_id
		AND (uf1.following_user_id, uf1.followed_user_id) = (uf2.followed_user_id, uf2.following_user_id)
	) AS pair
    
    INNER JOIN user_interest AS ui1
    ON pair.user_id1 = ui1.user_id
    
    INNER JOIN user_interest AS ui2
    ON pair.user_id2 = ui2.user_id
GROUP BY pair.user_id1, pair.user_id2
HAVING SUM(ui1.interest_id = ui2.interest_id) >= 1;

