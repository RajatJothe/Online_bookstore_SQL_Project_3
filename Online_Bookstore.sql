-- CREATE TABLE

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

DROP DATABASE IF EXISTS customers;
CREATE TABLE customers(
	Customer_ID	SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(100)
);

DROP DATABASE IF EXISTS orders;
CREATE TABLE orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID	INT REFERENCES customers(customer_ID),
	Book_ID	INT REFERENCES books(book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);


SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- BASIC QUESTIONS
-- 1) Retrieve all books in the "Fiction" genre:

SELECT * 
FROM books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:

SELECT * 
FROM books
WHERE published_year > 1950
ORDER BY published_year ASC;

-- 3) List all customers from the Canada:

SELECT * 
FROM customers
WHERE country = 'Canada'

-- 4) Show orders placed in November 2023:

SELECT * 
FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'
ORDER BY order_date ASC;

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) as "Total Books Stock Available"
FROM books

-- 6) Find the details of the most expensive book:

SELECT title , price
FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT name, quantity
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT name , total_amount
FROM orders as o 
JOIN customers as c
ON o.customer_id = c.customer_id
WHERE total_amount > '20'
ORDER BY total_amount desc;

-- 9) List all genres available in the Books table:

SELECT DISTINCT(genre)
FROM books;

-- 10) Find the book with the lowest stock:

SELECT title ,stock
FROM books
ORDER BY stock
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) as "Revenue"
FROM orders;

--ADVANCE QUESTIONS.
-- 1) Retrieve the total number of books sold for each genre:

SELECT b.genre , SUM(o.quantity) AS "Total Book Sold"
FROM books as b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY "Total Book Sold" DESC;

-- 2) Find the average price of books sold in the "Fantasy" genre:

SELECT b.genre, AVG(total_amount)
FROM books as b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.genre
HAVING b.genre = 'Fantasy'

-- 3) List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.order_id) AS "Order_Count"
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
GROUP BY o.customer_id,c.name
HAVING COUNT(o.order_id) >= 2;

-- 4) Find the most frequently ordered book:

SELECT b.title , o.quantity
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
ORDER BY o.quantity DESC
LIMIT 5;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT title,genre,price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author,sum(o.quantity) as "total quantity of books sold"
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY "total quantity of books sold" DESC;


-- 7) List the cities where customers who spent over $30 are located:

SELECT c.city , o.total_amount
FROM customers as c
JOIN orders as o
ON c.customer_id = o.customer_id
WHERE  o.total_amount > 30
ORDER BY  o.total_amount DESC;

-- 8) Find the customer who spent the most on orders:

SELECT c.customer_id,c.name,sum(o.total_amount) AS "Total Sales"
FROM customers as c
JOIN orders as o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY "Total Sales" DESC 
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id,b.title,b.stock, COALESCE(SUM(o.quantity),0) AS "order_quantity" , 
		b.stock-COALESCE(SUM(o.quantity),0) AS "Remaining Quantity"
FROM books as b
LEFT JOIN orders as o
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;


































































