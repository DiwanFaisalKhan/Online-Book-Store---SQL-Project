-- Create Database
DROP DATABASE IF EXISTS Online_Bookstore;
CREATE DATABASE Online_Bookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID Serial PRIMARY KEY,
    Title Varchar(100),
    Author Varchar(50),
    Genre Varchar(20),
    Published_Year Int,
    Price Numeric(10, 2),
    Stock Int
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID Serial PRIMARY KEY,
    Name Varchar(50),
    Email Varchar(50),
    Phone Varchar(10),
    City Varchar(50),
    Country Varchar(100)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\SQL\SQL PROJECT\SQL PROJECT BY ME\Books.csv' 
CSV HEADER;

select * from books

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM '‪D:\SQL\SQL PROJECT\SQL PROJECT BY ME\Customers.csv' 
CSV HEADER;

select * from customers

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\SQL\SQL PROJECT\SQL PROJECT BY ME\Orders.csv' 
CSV HEADER;

select * from orders


















