## Online_bookstore_SQL_Project_3

#### 🎯 Project Goal:
The goal of this project is to design and query a relational database for an online bookstore using SQL. The project focuses on data modeling, table creation, and performing various SQL operations including joins, filtering, aggregation, grouping, and advanced analytical queries to gain meaningful business insights from the data.


**CREATE TABLE**
```sql
DROP DATABASE IF EXISTS books;
CREATE TABLE books(
	Book_ID	SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(100),
	Published_Year INT,	
	Price NUMERIC(10,2),
	Stock INT
);
```
```sql
DROP DATABASE IF EXISTS customers;
CREATE TABLE customers(
	Customer_ID	SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(100)
);
```
```sql
DROP DATABASE IF EXISTS orders;
CREATE TABLE orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID	INT REFERENCES customers(customer_ID),
	Book_ID	INT REFERENCES books(book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);
```
```sql
SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;
```
#### 📊Question asked.

Basic Questions :
 1) Retrieve all books in the "Fiction" genre:
 2) Find books published after the year 1950:
 3) List all customers from the Canada:
 4) Show orders placed in November 2023:
 5) Retrieve the total stock of books available:
 6) Find the details of the most expensive book:
 7) Show all customers who ordered more than 1 quantity of a book:
 8) Retrieve all orders where the total amount exceeds $20:
 9) List all genres available in the Books table:
 10) Find the book with the lowest stock:
 11) Calculate the total revenue generated from all orders:

 Advance Questions : 
 1) Retrieve the total number of books sold for each genre:
 2) Find the average price of books in the "Fantasy" genre:
 3) List customers who have placed at least 2 orders:
 4) Find the most frequently ordered book:
 5) Show the top 3 most expensive books of 'Fantasy' Genre :
 6) Retrieve the total quantity of books sold by each author:
 7) List the cities where customers who spent over $30 are located:
 8) Find the customer who spent the most on orders:
 9) Calculate the stock remaining after fulfilling all orders:

#### 📚 BASIC SOLUTION.
 1) Retrieve all books in the "Fiction" genre:
 ```sql
 SELECT * 
 FROM books
 WHERE genre = 'Fiction';
 ```
 2) Find books published after the year 1950:
 ```sql
 SELECT * 
 FROM books
 WHERE published_year > 1950
 ORDER BY published_year ASC;
 ```
 3) List all customers from the Canada:
 ```sql
 SELECT * 
 FROM customers
 WHERE country = 'Canada'
 ```
 4) Show orders placed in November 2023:
 ```sql
 SELECT * 
 FROM orders
 WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'
 ORDER BY order_date ASC;
 ```
 5) Retrieve the total stock of books available:
 ```sql
 SELECT SUM(stock) as "Total Books Stock Available"
 FROM books
 ```
 6) Find the details of the most expensive book:
 ```sql
 SELECT title , price
 FROM books
 ORDER BY price DESC
 LIMIT 1;
 ```
 7) Show all customers who ordered more than 1 quantity of a book:
 ```sql
 SELECT name, quantity
 FROM orders as o
 JOIN customers as c
 ON o.customer_id = c.customer_id
 WHERE quantity > 1;
 ```
 8) Retrieve all orders where the total amount exceeds $20:
 ```sql
 SELECT name , total_amount
 FROM orders as o 
 JOIN customers as c
 ON o.customer_id = c.customer_id
 WHERE total_amount > '20'
 ORDER BY total_amount desc;
 ```
 9) List all genres available in the Books table:
 ```sql
 SELECT DISTINCT(genre)
 FROM books;
 ```
 10) Find the book with the lowest stock:
 ```sql
 SELECT title ,stock
 FROM books
 ORDER BY stock
 LIMIT 1;
 ```
 11) Calculate the total revenue generated from all orders:
```sql
SELECT SUM(total_amount) as "Revenue"
FROM orders;
```
#### 📚 ADVANCE SOLUTION.
 1) Retrieve the total number of books sold for each genre:
 ```sql
 SELECT b.genre , SUM(o.quantity) AS "Total Book Sold"
 FROM books as b
 JOIN orders o
 ON b.book_id = o.book_id
 GROUP BY b.genre
 ORDER BY "Total Book Sold" DESC;
 ```
 2) Find the average price of books in the "Fantasy" genre:
 ```sql
 SELECT b.genre, AVG(total_amount)
 FROM books as b
 JOIN orders o
 ON b.book_id = o.book_id
 GROUP BY b.genre
 HAVING b.genre = 'Fantasy'
 ```
 3) List customers who have placed at least 2 orders:
 ```sql
 SELECT o.customer_id, c.name, COUNT(o.order_id) AS "Order_Count"
 FROM orders as o
 JOIN customers as c
 ON o.customer_id = c.customer_id
 GROUP BY o.customer_id,c.name
 HAVING COUNT(o.order_id) >= 2;
 ```
 4) Find the most frequently ordered book:
 ```sql
 SELECT b.title , o.quantity
 FROM books as b
 JOIN orders as o
 ON b.book_id = o.book_id
 ORDER BY o.quantity DESC
 LIMIT 5;
 ```
 5) Show the top 3 most expensive books of 'Fantasy' Genre :
 ```sql
 SELECT title,genre,price
 FROM books
 WHERE genre = 'Fantasy'
 ORDER BY price DESC
 LIMIT 3;
 ```
 6) Retrieve the total quantity of books sold by each author:
 ```sql
 SELECT b.author,sum(o.quantity) as "total quantity of books sold"
 FROM books as b
 JOIN orders as o
 ON b.book_id = o.book_id
 GROUP BY b.author
 ORDER BY "total quantity of books sold" DESC;
 ```
 7) List the cities where customers who spent over $30 are located:
 ```sql
 SELECT c.city , o.total_amount
 FROM customers as c
 JOIN orders as o
 ON c.customer_id = o.customer_id
 WHERE  o.total_amount > 30
 ORDER BY  o.total_amount DESC;
 ```
 8) Find the customer who spent the most on orders:
 ```sql
 SELECT c.customer_id,c.name,sum(o.total_amount) AS "Total Sales"
 FROM customers as c
 JOIN orders as o
 ON c.customer_id = o.customer_id
 GROUP BY c.customer_id,c.name
 ORDER BY "Total Sales" DESC 
 LIMIT 1;
 ```
 9) Calculate the stock remaining after fulfilling all orders:
```sql
 SELECT b.book_id,b.title,b.stock, COALESCE(SUM(o.quantity),0) AS "order_quantity" , 
		b.stock-COALESCE(SUM(o.quantity),0) AS "Remaining Quantity"
 FROM books as b
 LEFT JOIN orders as o
 ON b.book_id = o.book_id
 GROUP BY b.book_id
 ORDER BY b.book_id;
```






















