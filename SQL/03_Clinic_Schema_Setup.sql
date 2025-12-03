CLINIC MANAGEMENT SYSTEM TABLES 
// Create Table clinics 

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-0100002', 'ABC Health', 'amet', 'ipsum', 'dolor'),
('cnc-0100003', 'Wellness Point', 'lorem', 'elit', 'dolor');



// Create Table customer 

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

INSERT INTO customer (uid, name, mobile) VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('bk-09f3e-95hk', 'Alice Singh', '98XXXXXXXX'),
('bk-09f3e-95hl', 'Ravi Kumar', '99XXXXXXXX');



// Create Table clinic_sales 

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(12,2),
    datetime DATETIME,
    sales_channel VARCHAR(100),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'bk-09f3e-95hk', 'cnc-0100002', 15000, '2021-09-10 11:15:10', 'online'),
('ord-00100-00102', 'bk-09f3e-95hl', 'cnc-0100003', 18000, '2021-09-15 09:25:55', 'walkin');



// create Table expenses 

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(12,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'maintenance', 1200, '2021-09-10 10:00:00'),
('exp-0100-00102', 'cnc-0100003', 'electricity', 900, '2021-09-15 08:30:00');


