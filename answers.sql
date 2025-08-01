-- -----------------------------------------------------
-- SQL Script: normalization_example_ethiopia.sql
-- Description: Demonstrates 1NF and 2NF using Ethiopian context
-- Author: Zemcheal Algabrhan Gebretsadik
-- -----------------------------------------------------

-- 🔄 Drop and recreate the database
DROP DATABASE IF EXISTS normalization_db;
CREATE DATABASE normalization_db;
USE normalization_db;

-- -----------------------------------------------------
-- 🔹 PART 1: Original Table (violates 1NF)
-- -----------------------------------------------------
-- Products column contains multiple values, violating atomicity

CREATE TABLE ProductDetail_Violates1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert sample data with Ethiopian names
INSERT INTO ProductDetail_Violates1NF VALUES
(201, 'Abebe Bekele', 'Laptop, Mouse'),
(202, 'Muluwork Tadesse', 'Tablet, Keyboard, Mouse'),
(203, 'Selamawit Alemu', 'Phone');

-- -----------------------------------------------------
-- 🔹 PART 2: Table in 1NF (atomic product values)
-- -----------------------------------------------------
-- Each row now contains only one product per order

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert transformed 1NF data
INSERT INTO ProductDetail_1NF VALUES
(201, 'Abebe Bekele', 'Laptop'),
(201, 'Abebe Bekele', 'Mouse'),
(202, 'Muluwork Tadesse', 'Tablet'),
(202, 'Muluwork Tadesse', 'Keyboard'),
(202, 'Muluwork Tadesse', 'Mouse'),
(203, 'Selamawit Alemu', 'Phone');

-- -----------------------------------------------------
-- 🔹 PART 3: Original 1NF table that violates 2NF
-- -----------------------------------------------------
-- CustomerName depends only on OrderID → partial dependency

CREATE TABLE OrderDetails_Violates2NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

-- Insert data showing the violation
INSERT INTO OrderDetails_Violates2NF VALUES
(201, 'Abebe Bekele', 'Laptop', 2),
(201, 'Abebe Bekele', 'Mouse', 1),
(202, 'Muluwork Tadesse', 'Tablet', 3),
(202, 'Muluwork Tadesse', 'Keyboard', 1),
(202, 'Muluwork Tadesse', 'Mouse', 2),
(203, 'Selamawit Alemu', 'Phone', 1);

-- -----------------------------------------------------
-- 🔹 PART 4: Normalize to 2NF
-- -----------------------------------------------------
-- Split into two separate tables:
-- - Orders: OrderID → CustomerName
-- - OrderItems: (OrderID, Product) → Quantity

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Table: OrderItems
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert into Orders table
INSERT INTO Orders VALUES
(201, 'Abebe Bekele'),
(202, 'Muluwork Tadesse'),
(203, 'Selamawit Alemu');

-- Insert into OrderItems table
INSERT INTO OrderItems VALUES
(201, 'Laptop', 2),
(201, 'Mouse', 1),
(202, 'Tablet', 3),
(202, 'Keyboard', 1),
(202, 'Mouse', 2),
(203, 'Phone', 1);
