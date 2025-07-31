Question 1: Achieving 1NF (First Normal Form) 
-- Create normalized tables 
CREATE TABLE Orders_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    PRIMARY KEY (OrderID)
);

CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_1NF(OrderID)
);

-- Insert data 
INSERT INTO Orders_1NF VALUES (101, 'Abebe Kebede');
INSERT INTO OrderProducts_1NF VALUES (101, 'Laptop');
INSERT INTO OrderProducts_1NF VALUES (101, 'Mouse');

INSERT INTO Orders_1NF VALUES (102, 'Mekdes Hailu');
INSERT INTO OrderProducts_1NF VALUES (102, 'Tablet');
INSERT INTO OrderProducts_1NF VALUES (102, 'Keyboard');
INSERT INTO OrderProducts_1NF VALUES (102, 'Mouse');

INSERT INTO Orders_1NF VALUES (103, 'Selamawit Tesfaye');
INSERT INTO OrderProducts_1NF VALUES (103, 'Phone');
Question 2: Achieving 2NF (Second Normal Form) 
-- Create normalized tables 
CREATE TABLE Customers_2NF (
    CustomerID INT AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Orders_2NF (
    OrderID INT,
    CustomerID INT,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers_2NF(CustomerID)
);

CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Insert 
INSERT INTO Customers_2NF (CustomerName) VALUES 
('Abebe Kebede'), ('Mekdes Hailu'), ('Selamawit Tesfaye');

-- Create orders
INSERT INTO Orders_2NF VALUES (101, 1);
INSERT INTO Orders_2NF VALUES (102, 2);
INSERT INTO Orders_2NF VALUES (103, 3);

-- Add order items
INSERT INTO OrderItems_2NF VALUES (101, 'Laptop', 2);
INSERT INTO OrderItems_2NF VALUES (101, 'Mouse', 1);
INSERT INTO OrderItems_2NF VALUES (102, 'Tablet', 3);
INSERT INTO OrderItems_2NF VALUES (102, 'Keyboard', 1);
INSERT INTO OrderItems_2NF VALUES (102, 'Mouse', 2);
INSERT INTO OrderItems_2NF VALUES (103, 'Phone', 1);
