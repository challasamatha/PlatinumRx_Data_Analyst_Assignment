HOTEL MANAGEMENT SYSTEM TABLES
// Create Table users 

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(150),
    billing_address TEXT
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address)
VALUES ('21wrcxuy-67erfn','John Doe','9787654321','john@example.com','Street X, City Y'); 

// Create Table bookings 

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id)
VALUES ('bk-09f3e-95hj','2021-09-23 07:36:48','rm-bhf9-aerjn','21wrcxuy-67erfn'); 

// Create Table booking_commercials 

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,4),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity)
VALUES ('q34r-3q4o8-q34u','bk-09f3e-95hj','bl-0a87y-q340','2021-09-23 12:03:22','itm-a9e8-q8fu',3);


// Create Table items 

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(200),
    item_rate DECIMAL(10,2)
);

INSERT INTO items (item_id, item_name, item_rate)
VALUES ('itm-a9e8-q8fu','Tawa Paratha',18.00);