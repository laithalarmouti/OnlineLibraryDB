use onlinelibrarydb;
DELIMITER $$

CREATE PROCEDURE GetMostActiveUsers()
BEGIN
    SELECT 
        users.user_id,
        users.name,
        users.email,
        COUNT(user_activity.activity_id) AS total_activities #count aall activity from users and group them 
    FROM users
    JOIN user_activity ON users.user_id = user_activity.user_id   #join the tables to link users with their activity 
    GROUP BY users.user_id
    ORDER BY total_activities DESC  #descending order
    LIMIT 5;		#only show top 5
END $$

DELIMITER ;
