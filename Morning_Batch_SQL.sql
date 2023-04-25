use sakila;

select * from sakila.actor limit 10; -- this is to sample the top 10 rows and understand the table


-- single line comment

/* i am 
multi line
comment 
*/

/*
•	Filter results with WHERE
•	Sort results with ORDER BY
•	Transform results with STRING functions
•	Change result headings with alias
•	SQL WHERE with DATE functions
•	Aggregate results with GROUP BY and Numeric functions
•	Unique values with DISTINCT
•	Merge rows with GROUP BY and STRING functions
•	Rank results with RANK and ROW NUMBER
*/
select * from actor;

-- Filter results with WHERE

select first_name,last_name from actor
where first_name = 'penelope';

select first_name,last_name from actor
where first_name <> 'penelope';  

select first_name,last_name from actor
where first_name != 'penelope';


select actor_id,first_name,last_name from actor
where actor_id>5 and actor_id<20;

select actor_id,first_name,last_name from actor
where actor_id>5 or actor_id<20;

select actor_id,first_name,last_name from actor
where actor_id>5 or actor_id<5;

select actor_id,first_name,last_name from actor
where actor_id>5 and actor_id<20;

select actor_id,first_name,last_name from actor
where actor_id between 6 and 19;


select actor_id,first_name,last_name from actor
where first_name='penelope' and actor_id<20;

select actor_id,first_name,last_name from actor
where first_name='penelope' or first_name='nick';

select actor_id,first_name,last_name from actor
where first_name='penelope' or first_name='ed' or actor_id<20;

select actor_id,first_name,last_name from actor
where first_name='penelope' or first_name='ed' or first_name = 'nick';

select actor_id,first_name,last_name from actor
where first_name='penelope' and first_name='ed' and  first_name = 'nick';

select actor_id,first_name,last_name from actor
where first_name in ('penelope','ed','nick');


select actor_id,first_name,last_name from actor
where first_name not in ('penelope','ed','nick');


select actor_id,first_name,last_name from actor
where (first_name='penelope' or first_name='ed') and actor_id<20;

select actor_id,first_name,last_name from actor
where first_name in ('penelope','ed') and actor_id<20;

-- Like and Wildcards

select actor_id, first_name, last_name
from actor
where first_name like 'john%';

select actor_id, first_name, last_name
from actor
where first_name like 'ma%'; -- Starts with MA

select actor_id, first_name, last_name
from actor
where first_name like '%ma'; -- Ends with MA

select actor_id, first_name, last_name
from actor
where first_name like '%ma%'; -- Contains MA

select actor_id, first_name, last_name
from actor
where first_name like '%m%a%';-- Contains MA

-- write a query to get list of all the name whose last name starts with SC

select * from address;

-- write a query to get list of addresss from district "Buenos aires" and contains EL or AL in the address

select * from address
where district = 'Buenos Aires' and (address like '%EL%' or address like '%AL%');

-- Sorting results using  order by

select actor_id, first_name, last_name
from actor
WHERE first_name = 'PENELOPE'
order by last_name;

select actor_id, first_name, last_name
from actor
WHERE first_name = 'PENELOPE'
order by last_name asc;

select actor_id, first_name, last_name
from actor
WHERE first_name = 'PENELOPE'
order by last_name desc;


-- Transform results with string functions

select first_name , length(first_name) from actor
order by length(first_name) desc;


select first_name,last_name from actor;

select first_name,last_name, concat(first_name,' ',last_name) from actor;

select first_name,last_name, length(concat(first_name,' ',last_name)) from actor
order by length(concat(first_name,' ',last_name)) desc;


select first_name,last_name, lower(concat(first_name,' ',last_name)) from actor;

select first_name,last_name, upper(concat(first_name,' ',last_name)) from actor;

select first_name,last_name, concat(left(first_name,3),'_', right(last_name,3))
 from actor;
 
 select first_name, substring(first_name,2,4) from actor;

-- P E N E L O P E 
-- 1 2 3 4 5 6 7 8   -- index positions in SQL

-- write a query to capitalize only the first letter of the first name

select first_name, concat(left(first_name,1), lower(substring(first_name,2,length(first_name)))) as cap_name from actor;

-- change result headings with alias

select first_name,last_name, concat(first_name,' ',last_name) as full_name,
length(concat(first_name,' ',last_name)) len_Full_name from actor
-- where full_name like 'Ma%';
order by full_name;

select first_name,last_name, concat(first_name,' ',last_name) as full_name,
length(concat(first_name,' ',last_name)) len_Full_name from actor
where concat(first_name,' ',last_name) like 'Ma%';
-- order by full_name;

-- SQL Where with Date Functions

select *,year(last_update) as Year, Month(last_update) as month, day(last_update) as day,
time (last_update) as time, date(last_update) as date, (datediff(current_date,last_update)/365)
 from actor;

select current_date;

select * from actor 
where year(last_update) = '2006' ;

select 5+6;

select date_add(current_date(), interval 10 day);
select date_add(current_date(), interval 10 month);

select date_add(current_time(), interval 15 minute);


-- ----- Aggregate results with Group by and Numeric Functions

select * from address;

select count(*), count(address), count(address2), count(district) from address;


select district , count(address) as abc from address
group by district;


select district , count(address) as abc from address
-- where count(address) >= 5
group by district 
having abc>=5 ;

use sakila;
select min(rental_duration),max(rental_duration), sum(rental_duration),avg(rental_duration) from film;

select title,sum(rental_duration) as Rental_duration from film
where rental_duration>= (select avg(rental_duration) from film)
group by title;
-- having rental_duration>=avg(rental_duration)

-- unique values with Distinct

select distinct district from address;

select district from address
group by district;

select count(district) from sakila.address; -- 603 records

select count(distinct district) from address; -- 378 records

-- Rank Results with Rank & Row number

select title, rental_duration, rank() over (order by rental_duration desc) as rnk from film
order by rental_duration desc;

select title, rental_duration, dense_rank() over (order by rental_duration desc) as rnk from film
order by rental_duration desc;

select title, rental_duration, row_number() over (order by rental_duration desc) as rnk from sakila.film
order by rental_duration desc;

select title, rental_duration,rating, row_number() over (partition by rating order by rental_duration desc) as rnk from film
order by rental_duration desc;

--

select title, (rental_duration* rental_rate) Rental_Amt,rating, 
row_number() over (partition by rating order by (rental_duration* rental_rate) desc) as rnk from film
order by Rental_Amt desc;

-- Write a query to get only even ranks
-- write a query to get duplicate records in a table


/* Session 3 – Merge Data from multiple tables

•	Speed up queries by limiting report size
•	Merge data from multiple tables with JOIN – Inner, Outer, Left and Right
•	Combine rows with UNION
•	Return data from multiple tables with IN
•	Selecting data using SUBQUERIES
•	Create SQL tables to store data
•	Create SQL tables to store data
*/

select * from customer ;
select * from address;


select c.first_name,c.last_name,a.address,a.district from customer c
inner join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

select c.first_name,c.last_name,a.address,a.district from customer c
left join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

select 'right join' as join_type,c.first_name,c.last_name,a.address,a.district from customer c
right join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

select c.first_name,c.last_name,a.address,a.district from customer c
full join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

-- write a full join query without using full join keyword


-- appending rows with union


select 'actor' as tbl, Date(last_update) from actor  -- 200 rows
union all
select 'address' as tbl, Date(last_update) from address; -- 603 rows

select 'actor' as tbl, Date(last_update) from actor  -- 200 rows
union
select 'address' as tbl, Date(last_update) from address; -- 603 rows


use sakila;
select actor_id,first_name,last_name from actor
where first_name = 'Christian'
union all
select actor_id,first_name,last_name from actor
where last_name = 'AKROYD';

select actor_id,first_name,last_name from actor
where first_name = 'Christian'
union
select actor_id,first_name,last_name from actor
where last_name = 'AKROYD';


select 'right join' as join_type,c.first_name,c.last_name,a.address,a.district from customer c
right join address a on c.address_id=a.address_id
where a.district='Buenos Aires'
union
select 'right join' as join_type,c.first_name,c.last_name,a.address,a.district from customer c
left join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

select c.first_name,c.last_name,a.address,a.district from customer c
join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

-- Return data from mutliple tables with IN --- 

select * from rental
where customer_id IN (select customer_id from customer where first_name = 'jennifer');


select r.* from rental r
left join customer c on r.customer_id = c.customer_id 
where first_name = 'Jennifer';


select * from (
SELECT title, rating, (rental_duration*rental_rate) AS rental_amount ,
ROW_NUMBER() OVER (PARTITION BY rating ORDER BY (rental_duration*rental_rate) desc) as Rnk
FROM film )temp
where rnk  % 2 != 0;

create table sandbox.customer_test
select c.first_name,c.last_name,a.address,a.district from customer c
join address a on c.address_id=a.address_id
where a.district='Buenos Aires';

select * from sandbox.customer_test;

create table sandbox.Sales_test(
Employees varchar(50) not null,
fiscal_year int,
sales decimal(14,2) not null,
primary key(Employees,fiscal_year)-- primary key(Employees,fiscal_year)
);

select * from sandbox.Sales_test;

Insert into sandbox.Sales_test (Employees,Fiscal_year,sales)
values ('Mike',2019,300),
('Rob',2020,400),
('Cheryl',2019,500),
('Adrian',2021,600);

select * from sandbox.Sales_test;

Insert into sandbox.Sales_test (Employees,Fiscal_year,sales)
values ('dunn',2021,600);

-- Case Statement - Case expression goes through conditions and returns a value when the first condition
-- is met ( if - then - else statement). So once a condition is tru it will stop reading and return 
-- the result. 
/*
Case
	when condition1 then result1
    when condition2 then result2
    .
    .
    when conditionN then resultN
    Else result
End */
    

select  *,
case
	when rating ='G' Then 'General'
    when rating in ('PG','PG-13','R') then 'Guided'
    else 'Adults'
END    
 from film;
 
select  rating,
case
	when rating ='G' Then 'General'
    when rating in ('PG','PG-13','R') then 'Guided'
    else 'Adults'
END    as category
 from film
 group by 1,2;

-- use film table .. 
/*
replacement cost above 20 then premium
replacement cost less than equal to 20 and greate than 10 then budget movie
else cheap movie
*/

select title, replacement_cost, 
case
when replacement_cost>20 Then 'Premium'
when replacement_cost<=20 and replacement_cost>10 Then 'Budget'
else 'cheap' 
End as category
from film;


select title, replacement_cost, avg(replacement_cost) ,
case
when replacement_cost>(select avg(replacement_cost) from film) Then 'Premium'
when replacement_cost<= (select avg(replacement_cost) from film) Then 'Budget'
else 'others' 
End as category
from film
group by 1,2

select avg(replacement_cost) from film;



-- find the full name and email address of all customer that have rented an action movie
-- tables use film_category,category, rental,inventory,customer

create table sandbox.action_movie_cx
select concat(first_name," ",Last_name) Full_name, email from customer
where customer_id in (
select customer_id from rental where inventory_id in (
select inventory_id from inventory where film_id in (
select film_id from film_category FC join category C on FC.category_id = c.category_id
where c.name = 'Action')));


select * from sandbox.action_movie_cx;

-- Find the name of each film, its category and aggregate(count) number of film that 
-- fall within each category

-- Tables to use - film,category, film category
use sakila;
Select a.title,c.name,`count`.count_of_category from film a
join film_category b using(film_id)
join category c using(category_id)
join (select count(*) as count_of_category, category_id from film_category fc group by  category_id) `count` using (category_id);

-- find average payement made by each customer

select customer_id, first_name, last_name,avg(amount) from customer join payment using(customer_id) group by 1,2,3;


-- find all payments that exceed the average for each customer along with the total count of payments exceeding the 
-- average


select customer_id, concat(first_name," ",last_name) as Name, count(amount)
from customer
join payment p1 using(customer_id) 
where amount > (select avg(amount) from payment p2 where p2.customer_id = p1.customer_id)
group by 1;


-- Create a new column classifying existing columns as either or high value transaction based on the amount of payemnt
--
-- amount >=0 and amount < 5 "low"
-- amount >=5 "high"

select payment_id, amount,
case 
	when amount >=0 and amount < 5 then 'low'
	when amount >=5 then 'high'
End as category
from payment;

/* ---------------------------------- Case Study ----------------------------------------------
1. What are the top selling products and categories from Northwind by month and year? 
2. Which countries have the highest shipping in terms of sales?
3. Who are the top 3 Customers and their Contact Titles per country based on purchases
4. Create the reporting hiererchy of Employees
5. Employee and Manager performance in terms of sales
*/

-- 1. What are the top selling products and categories from Northwind by month and year? 

-- Tables used : products, categories, orders, order details

use northwind;
select year(a.OrderDate),month(a.OrderDate),c.ProductName,d.CategoryName, sum(b.UnitPrice*b.Quantity) as sales
from orders a
left join `order details` b on a.orderid=b.orderid
left join products c on b.ProductID = c.ProductID
left join categories d on d.CategoryID=c.CategoryID
group by 1,2,3,4
order by sales desc

-- in each year what are the top 3 products 

use northwind;
select * from (
select year(a.OrderDate),c.ProductName,d.CategoryName, sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as rnk
from orders a
left join `order details` b on a.orderid=b.orderid
left join products c on b.ProductID = c.ProductID
left join categories d on d.CategoryID=c.CategoryID
group by 1,2,3
order by sales desc) temp
where rnk <=3;

-- 2. Which countries have the highest shipping in terms of sales?

-- Tables used : 

select year(a.OrderDate),month(a.OrderDate),a.ShipCountry,a.ShipCity,sum(b.UnitPrice*b.Quantity) as sales
from orders a
left join `order details` b on a.orderid=b.orderid
group by 1,2,3,4
order by sales desc;


select * from (
select year(a.OrderDate),a.ShipCountry,a.ShipCity,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as rnk
from orders a
left join `order details` b on a.orderid=b.orderid
group by 1,2,3
order by sales desc) temp
where rnk<=3;


-- 3. Who are the top 3 Customers and their Contact Titles per country based on purchases

-- Tables used : Orders, Order details, customers


select 
ContactName,CompanyName,ContactTitle,sum(b.UnitPrice*b.Quantity) as sales
from orders a
left join `order details` b on a.orderid = b.orderid
left join customers c on a.CustomerID = c.CustomerID
group by 1,2,3
order by sales desc;

select 
year(a.OrderDate),CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from orders a
left join `order details` b on a.orderid = b.orderid
left join customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc;


-- Get top 3 ranks

select yr,CompanyName,sales,top_rnk  from (
select 
year(a.OrderDate) as Yr,CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from orders a
left join `order details` b on a.orderid = b.orderid
left join customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc) Temp
where top_rnk <= 3;


-- Get bottom companies 3 ranks

select yr,CompanyName,sales,bottom_rnk  from (
select 
year(a.OrderDate) as Yr,CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from orders a
left join `order details` b on a.orderid = b.orderid
left join customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc) Temp
where bottom_rnk <= 3;


-- 4. Create the reporting hiererchy of Employees

use northwind;

drop table sandbox.employee_hierarchy;

create table sandbox.employee_hierarchy
select a.employeeid as empid,a.firstname as empname, b.employeeid as supid, b.firstname as supname 
from employees a
left join employees b on a.reportsto = b.employeeid;

select * from sandbox.employee_hierarchy;

select ifnull(null, "Hello");

-- 5. Employee and Manager performance in terms of sales

-- tables to use : orders, order details, employee hierarchy table


create table sandbox.order_employee_manager_sales
select year(OrderDate) yr, month(OrderDate) mth,ifnull(c.supname,"CEO") supname,ifnull(c.empname,"CEO") empname,
sum(b.UnitPrice*b.Quantity) as sales
from orders a
left join `order details` b on a.orderid = b.orderid
left join sandbox.employee_hierarchy c on c.empid = a.employeeid
group by 1,2,3,4
order by sales desc;


select * from sandbox.order_employee_manager_sales
where empname = 'Janeett';

set sql_safe_updates = 0;

delete from sandbox.order_employee_manager_sales
where empname = 'Margaret';

update sandbox.order_employee_manager_sales
set empname = 'Janeett' where empname = 'Janet';


use sakila;
select *,
avg(amount) over (order by amount rows between 2 preceding and 2 following) as rolling_avg
 from payment;

select *, 
avg(a.UnitPrice) over (order by a.UnitPrice rows between 2 preceding and 2 following) as rolling_avg
from northwind.`order details` a;


-- 
CREATE TABLE sandbox.Students
(
	Id INT PRIMARY KEY,
	StudentName VARCHAR (50),
	StudentGender VARCHAR (50),
	StudentAge INT
);

INSERT INTO sandbox.Students VALUES 
(1,'Sally', 'Female', 14 ),
(2,'Edward', 'Male', 12 ),
(3,'Jon', 'Male', 13 ),
(4,'Liana', 'Female', 10 ),
(5,'Ben', 'Male', 11 ),
 (6,'Elice', 'Female', 12 ),
(7,'Nick', 'Male', 9 ),
 (8,'Josh', 'Male', 12 ),
 (9,'Liza', 'Female', 10 ),
(10,'Wick', 'Male', 15 );

select studentname, studentgender,studentage,
sum(studentage) over (order by id) as runningtotal,  
round((select stddev(studentage) from sandbox.Students),2) as std_dev,
round((select avg(studentage) from sandbox.Students),2) as avg_age,
ntile(4) over (order by StudentAge desc) as quartile
 from sandbox.Students
 group by 1,2,3;
 
 -- Top customer 
 -- Pareto law also known as 80-20 rule 
 -- sales Team 100 people 
 -- roughly 80% of revenue will be delivered 20% of your sales rep... 
 
 -- $100M > $80M of rev will be generated by 20 sales rep and the rest 20M of revenue will be generated by rest of the sales rep
 
 
 -- in a 10 member team roughly 80% of the work will be done by 2 people and the rest 20% of the work will be done by 8 people
 
 
 -- - Stored Procedure : A stored procedure is prepared SQL code that you can save, so the code can be reused over and over again
 -- A procedure always contains a name, parameter list and sql statements
 -- we can invoke the procedure by calling the procedure name, or by other procedure etc.alter
 -- A procedure is called a recursive stored procedure when it calls itself
 
 -- Syntax 
 
 /*
 
 Delimiter //
 
create procedure procedure_name(parameter)
Begin
	-- write SQL code here -- 
End //
 
 */
 
 use sandbox;
 drop procedure if exists getactordata;
 delimiter $$ 
 
 create procedure getactordata()
 Begin
	select * from sakila.actor;
end $$

call getactordata();

 drop procedure if exists getfilm_actor;
  delimiter &&
 create procedure getfilm_actor()
 Begin 
	select * from sakila.film_actor;
  end &&;
  
  
 call getfilm_actor();
 
 
 drop procedure if exists top_rank;
 
 delimiter //
 create procedure top_rank(IN rank_number int)
 begin
select yr,CompanyName,sales,top_rnk  from (
select 
year(a.OrderDate) as Yr,CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from northwind.orders a
left join northwind.`order details` b on a.orderid = b.orderid
left join northwind.customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc) Temp
where top_rnk <= rank_number;
end 
//

call top_rank(3);
 
 
 use sandbox;
drop procedure if exists showtableactor;

delimiter $$
create procedure showtableactor(in x int)
begin
select * from sakila.actor limit x;
end $$

call showtableactor (10);

drop procedure getaddress;
Delimiter //
create procedure getaddress(In District_Name  varchar(255))
Begin
	Select * from sakila.address
    where district = District_Name;
End //

call getaddress('Buenos Aires');
 
 
 
 
 use sakila;
 drop procedure film_stock_details;
 
 Delimiter $$
 create procedure film_stock_details (In p_film_id Int, In p_store_id Int, Out p_film_count INT)
 Begin
 Select inventory_id from inventory
 where film_id = p_film_id
 and store_id = p_store_id;
 
 select count(*) from inventory
 where film_id = p_film_id
 and store_id = p_store_id;
 
 END$$
 
  call film_stock_details (58,1,@p_film_count);
  
  
  drop procedure if exists getaddresscount
  
  Delimiter //
  create procedure Getfilmcount(In District_Name varchar(255), out Total Int)
  Begin
	Select count(address) from address
    where district = District_Name;
End//


Call Getfilmcount('Buenos Aires',@total)
  
  
  /* --------------------------------------- Views -------------------------------------------------------
  
  In SQL a view is a virtual table based on the result set of an SQL statement
  A view contains rows and columns, just like a real table. The fields in  view are fields from one or more table in a database
  You can add SQL statements and function to a view and present the data as id that data were coming from one single table 
  To Create a view you can use Create View Statement
  
  Syntax :
  
  Create view view_name as 
  select coulumn1, column2...
  from table a 
  left join table2 on a.column1 = b.column1
  where condition = ?
  group by 1,2,3
  Order by 1,2
  
  */
  
  
  use northwind;
  drop table if exists sandbox.ship_country;
  create table sandbox.ship_country
  select a.shipcountry,c.productname, sum(b.unitprice*quantity) as sales
  from orders a
  left join `order details` b on a.orderid = b.orderid
  left join products c on b.productid = c.productid
  group by 1,2
  order by sales desc;
  
  select * from sandbox.ship_country;
  
  
  drop view if exists sandbox.vw_ship_country;
  create view sandbox.vw_ship_country as
   select a.shipcountry,c.productname, sum(b.unitprice*quantity) as sales
  from orders a
  left join `order details` b on a.orderid = b.orderid
  left join products c on b.productid = c.productid
  group by 1,2
  order by sales desc;
  
  
  select * from sandbox.vw_ship_country;
  
  
  
  -- Global data table
  
  -- Amazon > 
  
  -- Global > NorthAmerica, EMEA, APJ, LATAM 
  
  create view sandbox.vw_APJ_data as
  select * from global_table
  where region = 'APJ'
  
  
  /*-------------------------- Common Table Expression ------------------------------------
  
  A Common Table Expression is named temporary result set that exists only within the execution scope of a single sql statement
  e.g., Select, Insert, update or delete
  
  Similar to a derived table, a CTE is not stored as an object and last onluy during the execution of a query. 
  Unlike a derived table, a CTE can be self referencing (a recurcive CTE) or can be referenced multiple times in the same query.
  In addition a CTE provides better readability and performance in comparison with a derived table.
  
The structure of a CTE includes the name and optional column list , a query that define the CTE
After the CTE is defined, you can use it as a view, in a select, insert, update, delete or create view statements.
  
  The following illustrated the basic syntax of a CTE:
  
  With CTE_Name (column_list) as (
									Query
								)
		select * from CTE_Name;
        
Notice that the number of columns in the query must be the same as the number of columns in the colunmn_list

*/
  
  use Sandbox;
with customer_in_USA as (

select customername, state from customers
where country = 'USA'

)
select customerName from customer_in_USA
where state = 'CA' order by customerName

-- Return the top 5 sales rep in 2003

-- orders, orderdetails customers

with topsales2003 as (
Select SalesRepEmployeeNumber as employeeNumber, Sum(quantityordered*Priceeach) Sales
from orders
Inner join orderdetails using (orderNumber)
Inner join customers using (customerNumber)
Where year(shippedDate) = 2003 and status = 'Shipped'
group by salesrepemployeenumber
order by sales desc
limit 5
)
select employeenumber, firstname, lastname, sales from employees
join topsales2003 using(employeenumber);


  select yr,CompanyName,sales,bottom_rnk  from (
select 
year(a.OrderDate) as Yr,CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from orders a
left join `order details` b on a.orderid = b.orderid
left join customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc) Temp

With Rank_example as (
  select 
year(a.OrderDate) as Yr,CompanyName,sum(b.UnitPrice*b.Quantity) as sales,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) desc) as top_rnk,
row_number() over (partition by year(a.OrderDate) order by sum(b.UnitPrice*b.Quantity) asc) as bottom_rnk
from Northwind.orders a
left join Northwind.`order details` b on a.orderid = b.orderid
left join Northwind.customers c on a.CustomerID = c.CustomerID
group by 1,2
order by sales desc)
select yr,CompanyName,sales,top_rnk  from Rank_example where top_rnk <= 5


  with salesrep as (
  select employeeNumber, concat(firstName,' ',lastName) as SalesrepName
  from employees
  where jobtitle = 'Sales Rep'
  ),
  customer_salesrep as(
  select customername, salesrepName
  from customers
  inner join salesrep on  employeeNumber  = salesrepemployeenumber
  )
  select * from customer_salesrep
  
  
  /* Create Stored Function, call function , alter fuction and delete function -------------------
  
  
  A stored function is a special king stored program that returns a single value.
  Typically, you can use strored function to encapsulate common formulas, or business rules that are reubsable among sql statements..
  
  Different from stored procedure, you can use a stored function in a sql statements whenever an expression is used
  This helps improve the readability and maintainability of the precedural code
  
  TO create a stored function you use create Function statement.
  
  
  Delimiter $$
  
  Create function function_name(
  param1,
  param2,
  )
  Returns datatype
  [Not] Deterministic
  Begin
  -- Statements
  End$$
  Delimiter;
  
  
  In this Syntax:
  
  First , specify the name of the stored function that you want to create after Create Function Keywords.
  Second, list all parameters of the stored function inside teh parentheses followed by the function name.
  Third, Specify the datatype of the return value in the returns statement, which can be any valid MYSQL data types.
  Fourth, specify if a function is deterministic or not using the determistic keyword.
		Determinitic function always return the same result for the same input parameters whereas
        a Non - deterministic function retuns different result for the same input parameters.
        Read SQL query 
Fifth, write the code in the body of the stored function in the begin end block. Inside the body section,
you need to specify at least one return statement. The return statement returns the value to the calling program.
Whenever the return statement is reached, the execution of the stored function is terminated immediately..
*/

-- Write a function to take a input credit value of the customer from the user and returns which segment the customer belongs to 
-- Platinum, gold or silver. 


-- Credit value > 50000 then Platinum, between 10000 and 500000 then Gold and if <10000 then silver
  
  use sandbox;
  
  drop function if exists sandbox.CustomerLevel
  
  Delimiter $$
  Create Function CustomerLevel (
  credit Decimal(10,2)
  )
  RETURNS varchar(20)
  DETERMINISTIC
  Begin
  Declare customerlevel varchar(20);
  
  If credit >50000 Then set customerlevel= 'PLATINUM';
  elseif (credit <=50000 and credit >=10000) Then set customerlevel= 'GOLD';
  elseif credit <10000 then set customerlevel ='SILVER';
  End IF;
  
  Return (customerlevel);
  End $$
  
  
  select CustomerName,CustomerLevel(creditLimit) as CustomerLevel from customers;
  
drop function if exists inventory_in_stock;

Delimiter $$
create function inventory_in_stock (p_inventory_id INT) 
Returns tinyint(1)
Reads SQL data
Begin
Declare v_rentals INT;
Declare v_out Int;

select count(*) into v_rentals
from sakila.rental
where inventory_id = p_inventory_id;

If v_rentals = 0 Then
return True;
END If;

select count(rental_id) into v_out
from sakila.inventory left join sakila.rental using(inventory_id)
where inventory.inventory_id = p_inventory_id
and rental.return_date is null;

if v_out > 0 then 
return False;
Else 
Return True;
End If;
END 
$$
  
  
  
  
select inventory_in_stock(58)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 











