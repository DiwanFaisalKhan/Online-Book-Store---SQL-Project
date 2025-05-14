--1:Retrieve all books in the "Fiction" genre:
select * from books where genre='Fiction';

--2:Find books published after the year 1950:
select * from books where published_year>1950;

--3:List all customers from the Canada:
select * from customers where country='Canada';

-- 4:Show orders placed in November 2023:
select * from orders
where order_date between '01-11-2023' and '30-11-2023'
order by order_date

-- 5: Retrieve the total stock of books available:
select sum(stock) as total_stock_available from books

-- 6: Find the details of the most expensive book:

-- Method 1: Using Subquery with MAX Function
select * from books where price=(select max(price) from books)

-- Method 2: Using ORDER BY with LIMIT
select * from Books 
order by Price DESC 
limit 1;


--7: Show all customers who ordered more than 1 quantity of a book:

select * from orders 
where quantity>1

--8: Retrieve all orders where the total amount exceeds $20:
select * from orders 
where total_amount>20

--9: List all genres available in the Books table:

select Distinct genre from books

--10: Find the book with the lowest stock:

select * from books 
order by stock 
limit 1;

--11: Calculate the total revenue generated from all orders:

select sum(total_amount) as total_revenue from orders

-- Advance Questions : 

--1: Retrieve the total number of books sold for each genre:

select b.genre,sum(o.quantity) as total_books_sold from books b
join orders o
on b.book_id=o.book_id
group by b.genre

--2: Find the average price of books in the "Fantasy" genre:

/*Method 1: Using GROUP BY
Best Use Case: When we want to calculate the average price for multiple genres.*/

select genre,round((avg(price)),2) as average_price from books
where genre='Fantasy'
group by genre


/*Method 2:Without GROUP BY (Direct Calculation for Single Genre)
Best Use Case: It is simple and fast when we only need the average for a specific genre.*/

select avg(price) as average_price
from books
where genre='Fantasy'

--3: List customers who have placed at least 2 orders:
select o.customer_id,c.name,count(o.order_id) as order_count from customers c
join orders o
on c.customer_id=o.customer_id
group by 1,2
having count(o.order_id)>=2

-- 4:Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join books b on o.book_id = b.book_id
group by o.book_id, b.title
order by order_count desc
limit 1;

-- 5:Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books
where genre='Fantasy'
order by price desc
limit 3;

-- 6:Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity) as total_book_sold from orders o
join books b
on b.book_id=o.book_id
group by b.author


-- 7:List the cities where customers who spent over $30 are located:
select Distinct c.city,o.total_amount from orders o
join customers c
on c.customer_id=o.customer_id
where o.total_amount>30

-- 8) Find the customer who spent the most on orders:

select c.customer_id, c.name, sum(o.total_amount) as Total_Spent
from orders o
join customers c 
on o.customer_id=c.customer_id
group by 1,2
order by Total_spent Desc
limit 1;



--9) Calculate the stock remaining after fulfilling all orders:

--Method 1st: Using CTE (Good to use when we have Large datasets to get clean and maintainable code.)
with totalorders as (
    select book_id, sum(quantity) as total_ordered
    from orders
    group by book_id
)
select 
    b.book_id, 
    b.title, 
    b.stock, 
    coalesce(t.total_ordered, 0) as total_ordered, 
    b.stock - coalesce(t.total_ordered, 0) as remaining_stock
from books b
left join totalorders t on b.book_id = t.book_id
order by b.book_id;


--Method 2nd: Using LEFT JOIN with COALESCE
select 
    b.book_id, 
    b.title, 
    b.stock, 
    coalesce(sum(o.quantity), 0) as order_quantity,  
    b.stock - coalesce(sum(o.quantity), 0) as remaining_quantity 
from books b
left join orders o 
on b.book_id = o.book_id
group by b.book_id 
order by b.book_id;




