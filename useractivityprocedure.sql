use onlinelibrarydb;
DELIMITER $$

CREATE PROCEDURE GetUserActivity(IN uid BIGINT) #takes uid (user_id) as parameter which is BIGINT declared in the table
BEGIN
    SELECT 
        users.name,            #get relevant information from both tables before joining
        users.email,
        user_activity.book_id,
        user_activity.action,
        user_activity.timestamp
    FROM user_activity
    JOIN users ON users.user_id = user_activity.user_id
    WHERE users.user_id = uid         #match user_id with parameter user_id
    ORDER BY user_activity.timestamp DESC;  # decending order
END $$

DELIMITER ;