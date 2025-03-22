use onlinelibrarydb;


CALL GetUserActivity(3); #use any valid userid

CALL GetMostRequestedBook(); # no param required, check with mongodb with book_id for names

CALL GetMostActiveUsers(); #no param required, show the top 5 active users, can change in procedure to top 10 for example

#INSERT examples
INSERT INTO users (email, name) 
VALUES ('newuser@example.com', 'New User');

INSERT INTO user_activity (user_id, book_id, action) 
VALUES (3, '67dd7eea9322fdf169b22638', 'SIMPLE_REQUEST');

#get all users
SELECT * FROM users;

#get all categories
SELECT * FROM categories;

#get a category
SELECT * FROM categories WHERE name = 'Fiction';

#get all activities 
SELECT * FROM user_activity;

#get books taken by a users with join
SELECT 
    users.name, 
    user_activity.book_id, 
    user_activity.action, 
    user_activity.timestamp
FROM user_activity
JOIN users ON user_activity.user_id = users.user_id
WHERE user_activity.action = 'TOOK';

#update an user
UPDATE users
SET email = 'updateduser@example.com'
WHERE user_id = 3;

#delete an entry
DELETE FROM users WHERE user_id = 6;

#data manipulation
#most active users
SELECT 
    user_id, 
    COUNT(*) AS total_activities #count the occurances of a specfic id
FROM user_activity
GROUP BY user_id
ORDER BY total_activities DESC;

#most requested book
SELECT 
    book_id, 
    COUNT(*) AS total_requests #counts occurances of bookid and labels as total_requests
FROM user_activity
WHERE action IN ('SIMPLE_REQUEST', 'REQUEST_WITH_MEETING') #either simple or meeting request
GROUP BY book_id		#grouped by id to show each book
ORDER BY total_requests DESC	# descending order
