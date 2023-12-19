use LEARN;

-- String Replace Function

SELECT replace(title," ","-") FROM books;

SELECT * FROM books;

-- String Reverse Function
SELECT CONCAT(
	author_fname,
    REVERSE(author_fname)
) FROM books;

--  String characters length
SELECT CHAR_LENGTH(author_lname) FROM books;

-- String Upper and Lower Function
SELECT 
    CONCAT('I LOVE ',
            SUBSTRING(UPPER(title), 1, 10),
            '...')
FROM
    books;
    

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

-- Distinct is used to eliminate the duplicate values

SELECT DISTINCT author_lname FROM books;

SELECT DISTINCT concat(
	author_fname,
    " ",
    author_lname
) from books;

SELECT DISTINCT author_fname,author_lname from books; -- works similar to previous one


-- Order By - sorting purpose

select book_id,author_fname, author_lname from books order by author_lname;

select book_id,author_fname, author_lname from books order by author_fname DESC;

SELECT book_id,author_fname,author_lname,pages from books order by 4; -- similar to order by pages

SELECT book_id,author_fname,author_lname,pages from books order by author_fname,pages;  -- it will sort by the fname and then pages

SELECT concat(
	author_fname,
    " ",
    author_lname
) as author from books order by author;

-- LIMIT

SELECT book_id,title,pages from books ORDER BY pages limit 5;

SELECT book_id,title,pages from books ORDER BY pages limit 1,5; -- it will start from second book till next 5-1=4 books more
-- syntax -> limit x,y where x is starting and y is count we want to retrieve

-- Q. Find 3rd book with highest no. of pages
select title,pages from books order by pages limit 2,1;


-- LIKE

SELECT title,author_fname,author_lname from books where author_fname LIKE '%da%'; -- finds 'da' as substring

select title from books where title like '%:%';

select title,author_fname from books where author_fname LIKE '_____';

select title,author_fname from books where author_fname like '%a__';

select title from books where title like '%\%%'; -- to get the output containing one % then we use backslash to ignore %

select title from books where title like '%\_%';

-- Q. Select all titles with containing stories
select title from books where title like '%stories%';

-- Q. Find the longest book 
select title,pages from books order by pages desc limit 0,1;

-- Q. Print summary containing title and year, for 3 most receent books
select concat(
	title,' - ',released_year
) as summary from books order by released_year desc limit 0,3;

-- Q. Find all books with " " in author_lname
select title,author_lname from books where author_lname like '% %';

-- Q. Find 3 books with lowest stock quantity
select distinct title,stock_quantity from books order by stock_quantity limit 0,3;

-- Q. Find books soretd by author_lname and then by title
select title,author_lname from books order by author_lname,title;

-- Q. Sort by last name
select concat(
	'Favourite Author is ',author_fname,author_lname,'!'
) as yell from books order by author_lname;


-- Aggregate Functions - count

select count(distinct author_fname) from books;

select count(title) from books where title like '%the%';

-- Group By

select count(title), author_fname from books group by author_fname;

select author_lname,COUNT(*) from books group by author_lname,author_fname;

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS fullname,
    COUNT(*)
FROM
    books
GROUP BY fullname;

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS fullname,
    min(released_year) as FirstPublication
FROM
    books
GROUP BY fullname;

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS fullname,
    max(released_year) as RecentPublication
FROM
    books
GROUP BY fullname;

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS fullname,
    sum(pages)
FROM
    books
GROUP BY fullname;

SELECT COUNT(*) as Total_books from books;

select COUNT(*) as Total_Books, released_year from books group by released_year;

select COUNT(*) as Total_Books, released_year from books where stock_quantity > 0 group by released_year;

select AVG(released_year), concat(author_fname,' ',author_lname) as author from books group by author;

select concat(author_fname,' ',author_lname), pages, title from books as b1 where (select max(pages) from books) = b1.pages;

select released_year, count(*) as books, avg(pages) from books group by released_year order by released_year;


-- Char has fixed length if column has length of char be 2 then it will store char of size 2 and if we pass 1 char then it expand it to 2
-- Varchar has fixed length but it varies according to input and it will not expand it as Char
-- For Double syntax is DECIMAL(5,2) 5 indicates total number of digits and 2 indicates digits after decimal. Largest number we can store is 999.99

CREATE TABLE prod ( price double(5,2));
INSERT INTO prod (price) values (469.988);
INSERT INTO prod (price) values (3232.2); -- errror it should two digits after decimal
select * from prod;
-- Double and Float has difference 
-- If preision is not the priority but speed is then we can use DOUBLE datatype
-- Float is less precise and Double is more precise 
-- 4bytes and 8bytes storage by float and double respectively

-- DATE ('YYYY-MM-DD')
-- TIME('HH:MM:SS')
-- DATETIME ('YYYY-MM-DD HH:MM:SS')

CREATE TABLE people ( 
	name VARCHAR(10),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
 );

INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('yash', '2003-12-9', '9:00:00', '2003-12-9 9:00:00');

INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ( 'Sam', CURDATE(), CURTIME(), NOW() );

select birthdate, DAY(birthdate) from people; -- To retrieve te Day from the date

select birthdate, DAYOFWEEK(birthdate), DAYOFYEAR(birthdate) FROM people; -- To get the day in week ( DAYOFWEEK ) and to get the day from the whole year (DAYOFYEAR)

SELECT birthdate, MONTHNAME(birthdate) from people;

-- DATE_FORMAT(date,format)

SELECT DATE_FORMAT(birthdate, '%W %D %M') from people;

-- TIME_FORMAT(time, format)

select TIME_FORMAT(birthtime,'%r') from people;

-- DATE MATHEMATICS

SELECT CURDATE(), birthdate, DATEDIFF(CURDATE(), birthdate) from people;

select DATE_ADD(birthdate, INTERVAL 1 DAY) from people; 
select birthdt,DATE_ADD(birthdt, INTERVAL 10 SECOND) from people;
-- similar for DATE_SUB()

SELECT birthtime,TIMEDIFF(curtime(), birthtime) from people;

select birthdate + INTERVAL 10 YEAR from people;

-- TIMESTAMPS
-- 1. SIZE IS LESS 
-- 2. BUT SUPPORTS SOME RANGE OF DATETIME

create table captions (
	text varchar(100),
    createdAt TIMESTAMP default CURRENT_TIMESTAMP
);

create table captions2 (
	text varchar(100),
    createdAt TIMESTAMP default CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions2 (text) VALUES ('Hii');

select * from captions;

UPDATE captions2 SET text='Hello';

-- Operators

-- NOT EQUAL
SELECT title,released_year from books WHERE released_year != 2017;

-- NOT LIKE
select title from books where title not like '% %';

-- Greater Than 
select title,released_year from books where released_year > 2000;

-- Greather and equal to
select title,released_year from books where released_year >= 2000;

-- AND
SELECT 
    title, author_lname, author_fname, released_year
FROM
    books
WHERE
    author_lname = 'Eggers'
        AND released_year > 2000
		AND title not like '%Novel%';
        
SELECT
	title,pages 
FROM books as b1
WHERE
	CHAR_LENGTH(b1.title) > 30
		AND pages >= 300;
        
-- BETWEEN, NOT BETWEEN

SELECT 
	title,released_year
FROM books
WHERE released_year BETWEEN 2000 AND 2010;


SELECT 
	title,released_year
FROM books
WHERE released_year NOT BETWEEN 2000 AND 2010;

-- OPERATIONS ON DATES

SELECT birthdate,birthtime from people
WHERE birthdate > '2010-10-10';

SELECT birthdate,birthtime from people
WHERE YEAR(birthdate) < 2005;

SELECT birthdate,birthtime from people
WHERE HOUR(birthtime) > 12;

-- IN, NOT IN Operator

select title, author_lname 
from books
where author_lname IN ('Carver','Lahiri','Smith');

select title, author_lname 
from books
where author_lname NOT IN ('Carver','Lahiri','Smith');

-- MODULO

SELECT title, released_year from books
where released_year >= 2000 
	AND released_year % 2 = 0;
    
-- CASE 

SELECT title,released_year,
	CASE
		WHEN released_year >= 2000 THEN 'MODERN LIT'
        ELSE '20th CENTURY LIT'
    END AS Genre
FROM books;

select title,released_year,stock_quantity,
	CASE
		WHEN stock_quantity between 10 and 50 THEN '*'
        WHEN stock_quantity between 50 and 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

-- NULL, NOT NULL

SELECT * FROM books where stock_quantity is null;

-- UNIQUE CONTRAINT
CREATE TABLE companies (
	cmpId INT AUTO_INCREMENT,
    name varchar(20) not null,
    phoneNo VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(40) NOT NULL,
    PRIMARY KEY (cmpId)
)

INSERT INTO companies (name,phoneNo,address) VALUES ('sid work','8010409066','LSG');

-- CHECK CONSTRAINT

CREATE TABLE voting (
	name varchar(20) not null,
    age INT CHECK(age > 18)
);

INSERT INTO voting (name,age) VALUES ('sid2', 18);

-- To give custom name to the constarint we use following syntax
CREATE TABLE voting2 (
	name varchar(20) not null,
    age INT,
    CONSTRAINT age_constraint CHECK (age > 18)
);

-- Multiple columns constraint
CREATE TABLE people2 (
	name VARCHAR(20),
    address varchar(30),
    CONSTRAINT unique_both UNIQUE (name,address)
);

INSERT INTO people2 (name,address) VALUES ('sid','LSG');
INSERT INTO people2 (name,address) VALUES ('sid','LSG2');

CREATE TABLE houses (
	price int not null,
    sale_price int not null,
    CONSTRAINT not_profitable CHECK ( sale_price >= price )
);

INSERT INTO houses (price,sale_price) VALUES (100,150);
INSERT INTO houses (name,address) VALUES (150,100);

-- ALTER COMMAND FOR TABLE
ALTER TABLE people2 ADD city VARCHAR(20) NOT NULL DEFAULT 1;
ALTER TABLE people2 DROP city;

RENAME TABLE people2 to employeers;
ALTER TABLE employeers RENAME TO people2;

ALTER TABLE people2 RENAME COLUMN name TO employee;

ALTER TABLE people2 MODIFY employee varchar(100) not null;
-- To rename and change the datatype we use following command
ALTER TABLE people2 CHANGE employee name varchar(20) DEFAULT 'unknown';

ALTER TABLE houses add CONSTRAINT PositiveValue CHECK (price >= 0);

ALTER TABLE houses DROP CONSTRAINT PositiveValue;

-- Relationships
-- ONE TO MANY

CREATE TABLE CUSTOMERS (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    email varchar(20) NOT NULL
);

create table ORDERS (
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES CUSTOMERS(id)
);

INSERT INTO CUSTOMERS (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO ORDERS (order_date, amount, cust_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
-- Cross Join 
select * from CUSTOMERS,ORDERS;

-- INNER JOIN
SELECT * FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.id = ORDERS.cust_id;

SELECT
	AVG(amount) as avg,first_name,last_name from CUSTOMERS 
JOIN ORDERS 
ON CUSTOMERS.id = ORDERS.cust_id 
GROUP BY first_name,last_name
ORDER BY avg;

-- LEFT JOIN:
SELECT first_name, last_name, amount, order_date
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.cust_id;

-- LEFT JOIN AND IFNULL
SELECT first_name, last_name, IFNULL(SUM(amount),0) as sum
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.cust_id
GROUP BY first_name, last_name;

-- RIGHT JOIN
SELECT first_name, last_name, amount, order_date
FROM CUSTOMERS
RIGHT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.cust_id;

-- FOREIGN KEY ERROR WHILE DELETING THE PRIMARY KEY
DELETE FROM CUSTOMERS WHERE id = 1; 

-- So to allow to delete the primary key we use method called ON DELETE CASCADE
-- IT WILL DELETE ALL THE ROWS ASSOCIATED WITH IT AS FOREIGN KEY
CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    email varchar(20) NOT NULL
);

create table orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, cust_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
DELETE FROM customers WHERE id = 1; -- NO ERRORS
select * from orders;

-- JOINS EXERCISE
CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL
);

CREATE TABLE papers(
	title varchar(20) NOT NULL,
	grade INT NOT NULL,
    sid INT NOT NULL,
	FOREIGN KEY (sid) REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (sid, title, grade ) VALUES
(1, 'My First Book', 60),
(1, 'My Second Book', 75),
(2, 'Russian Lit', 94),
(2, 'The Art of The Essay', 98),
(4, 'Magical Realism', 89);

SELECT first_name,title,grade FROM students
JOIN papers
ON students.id = papers.sid
order by grade desc;

SELECT first_name,IFNULL(title,'MISSING'),IFNULL(grade,0) FROM students
left JOIN papers
ON students.id = papers.sid;

SELECT first_name, IFNULL(avg(grade),0) as average FROM students
LEFT JOIN papers
ON students.id = papers.sid
GROUP BY first_name
ORDER BY average desc;

SELECT first_name, IFNULL(avg(grade),0) as average, 
CASE
	WHEN IFNULL(avg(grade),0) >= 75 THEN 'passed'
    ELSE 'Failed'
END AS passing_status 
FROM students
LEFT JOIN papers
ON students.id = papers.sid
GROUP BY first_name
ORDER BY average desc;