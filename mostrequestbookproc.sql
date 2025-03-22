use onlinelibrarydb;
DELIMITER $$

CREATE PROCEDURE GetMostRequestedBook()
BEGIN
    SELECT 
        book_id,  
        COUNT(book_id) AS total_requests #count requests where (simple_request or request_with_meeting) from user_activity
    FROM user_activity
    WHERE action = 'SIMPLE_REQUEST' OR action = 'REQUEST_WITH_MEETING'
    GROUP BY book_id
    ORDER BY total_requests DESC  #descending, 
    LIMIT 5;						#show 5 most requestded
END $$

DELIMITER ;
