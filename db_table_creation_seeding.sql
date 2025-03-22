CREATE DATABASE OnlineLibraryDB;

use OnlineLibraryDB;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,                    # UNIQUE ID, INCREMENTS WITH EACH ENTRY PK
    email VARCHAR(255) NOT NULL UNIQUE,				 # EMAIL FOR THE MAILING SERVICE TO BE IMPLEMENTED UNIQUE 	
    name VARCHAR(255) NOT NULL             
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categories (
    category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS user_activity (
    activity_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id VARCHAR(24) NOT NULL,
    action ENUM('REQUEST_WITH_MEETING', 'SIMPLE_REQUEST', 'TOOK', 'RETURNED') NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_timestamp (timestamp)
) ENGINE=InnoDB;

INSERT INTO users (email, name) VALUES
('user1@example.com', 'User One'),
('user2@example.com', 'User Two'),
('user3@example.com', 'User Three'),
('user4@example.com', 'User Four'),
('user5@example.com', 'User Five'),
('user6@example.com', 'User Six');


INSERT INTO categories (name) VALUES
('Fiction'),
('Science'),
('History'),
('Mystery & Thriller'),
('Technology & Computing'),
('Biographies & Memoirs'),
('Fantasy'),
('Self-Help & Motivation'),
('Romance'),
('Science Fiction'),
('Business & Finance'),
('Travel Guides'),
('Poetry');

INSERT INTO user_activity (user_id, book_id, action, timestamp) VALUES
(2, '02b7e5e95ae8b62a31d017c0', 'RETURNED', '2025-03-10 11:56:10'),
(2, '02b7e5e95ae8b62a31d017c0', 'REQUEST_WITH_MEETING', '2025-03-24 10:57:20'),
(5, '02b7e5e95ae8b62a31d017c0', 'TOOK', '2025-03-13 17:37:50'),
(5, 'bad958df77f5b6bdeeb82818', 'RETURNED', '2025-02-15 19:23:12'),
(4, 'bad958df77f5b6bdeeb82818', 'SIMPLE_REQUEST', '2025-02-24 10:48:36'),
(2, '97e9ac1a2e139efea8dc16dc', 'TOOK', '2025-02-18 11:20:34'),
(4, '97e9ac1a2e139efea8dc16dc', 'REQUEST_WITH_MEETING', '2025-03-26 21:19:08'),
(6, '6ff3852f6232db1521dc9a5a', 'RETURNED', '2025-03-01 15:17:34'),
(2, '6ff3852f6232db1521dc9a5a', 'SIMPLE_REQUEST', '2025-02-08 15:28:12'),
(4, 'ba87e6f39f2d693db4d2f96c', 'RETURNED', '2025-01-15 12:19:41'),
(2, 'ba87e6f39f2d693db4d2f96c', 'RETURNED', '2025-01-10 20:01:03'),
(5, 'b4b520989b101edc40da1891', 'REQUEST_WITH_MEETING', '2025-01-20 10:45:44'),
(3, 'b4b520989b101edc40da1891', 'TOOK', '2025-02-01 15:24:03'),
(2, '5db12b8c314d8c2405e4bff7', 'RETURNED', '2025-02-02 14:10:35'),
(6, '5db12b8c314d8c2405e4bff7', 'RETURNED', '2025-01-16 13:43:02'),
(6, 'e2ed6e3b8d306ec53ad020b4', 'SIMPLE_REQUEST', '2025-03-01 17:04:42'),
(6, 'e2ed6e3b8d306ec53ad020b4', 'TOOK', '2025-03-04 19:15:18'),
(1, '9d5158c32e4f263ad5fc69db', 'SIMPLE_REQUEST', '2025-01-24 20:25:56'),
(2, '9d5158c32e4f263ad5fc69db', 'TOOK', '2025-02-21 18:04:17'),
(1, '35b18b381b4e28cb4c4ef4cb', 'REQUEST_WITH_MEETING', '2025-02-03 18:47:07'),
(3, '35b18b381b4e28cb4c4ef4cb', 'RETURNED', '2025-01-24 20:24:50'),
(4, '35b18b381b4e28cb4c4ef4cb', 'RETURNED', '2025-03-17 20:26:25'),
(5, 'cfae2dce2959e6710642d9f7', 'SIMPLE_REQUEST', '2025-01-10 20:24:33'),
(2, 'cfae2dce2959e6710642d9f7', 'SIMPLE_REQUEST', '2025-03-17 13:10:33'),
(5, 'cfae2dce2959e6710642d9f7', 'REQUEST_WITH_MEETING', '2025-01-16 21:22:07');


