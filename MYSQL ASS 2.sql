CREATE TABLE member1 (
    member_id INT(5),
    member_name VARCHAR(30),
    member_address VARCHAR(50),
    acc_open_date DATE,
    membership_type VARCHAR(20),
    fee_paid INT(4),
    max_books_allowed INT(2),
    penalty_amount INT(7)
);
desc member1;
CREATE TABLE books (
    book_no INT,
    book_name VARCHAR(30),
    author_name VARCHAR(30),
    cost INT,
    category VARCHAR(10)
);
desc books;
CREATE TABLE issue (
    lib_issue_id INT,
    book_no INT,
    member_id INT,
    issue_date DATE,
    return_date DATE
);
desc issue;
SELECT * FROM member1,books,issue;

drop table member1;
CREATE TABLE member1 (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(50),
    acc_open_date DATE,
    membership_type VARCHAR(20) CHECK (membership_type IN ('lifetime' , 'annual', 'half yearly', 'quarterly')),
    fee_paid INT,
    max_books_allowed INT,
    penalty_amount INT
);
desc member1;

alter table member1 modify column member_name varchar(30);
desc member1;

alter table issue add reference1 varchar(30);
desc issue;
select * from issue;

alter table issue drop column reference1 ;
desc issue;

alter table issue rename lib_issue;

insert into member1 value(1,"Richa Sharma","Pune",STR_TO_DATE('10-DEC-05', '%d-%M-%y'),"lifetime",25000,5,50);
insert into member1 value(2,"Garima Sen","Pune",curdate(),"annual",1000,3,null);
insert into member1 value(3,"Rohit Sharma","Pune",STR_TO_DATE('05-DEC-15', '%d-%M-%y'),"lifetime",25000,5,50);
insert into member1 value(4,"Virat Kholi","Pune",STR_TO_DATE('09-SEP-01', '%d-%M-%y'),"lifetime",25000,5,50);
insert into member1 value(5,"Rishab Pant","Pune",STR_TO_DATE('23-JUN-08', '%d-%M-%y'),"lifetime",25000,5,50);
select * from member1;

alter table member1 modify column member_name varchar(20);
desc member1;

alter table member1 add constraint max_books_allowed_new check(max_books_allowed<100);
alter table member1 add constraint penalty_amount_new check(penalty_amount<1000);
desc member1;

drop table books;
CREATE TABLE books (
    book_no INT primary key,
    book_name VARCHAR(30) not null,
    author_name VARCHAR(30),
    cost INT,
    category VARCHAR(10) check(category in ("science","fiction","database","rdbms","others"))
);
desc books;

insert into books value(101,"Let us C","Denis Ritchie",450,"system");
insert into books value(102,"Oracle-Complete Ref","Loni",550,"database");
insert into books value(103,"Matering SQL","Loni",250,"database");
insert into books value(104,"PL SQL-Ref","Scott Urman",750,"database");
select * from books;

insert into books value(105,"National Geographic","Adis Scott",1000,"science");
select * from books;

update books set cost=300,category='rdbms' where book_no =103;
select * from books;

alter table lib_issue rename issue;

drop table issue;
CREATE TABLE issue (
    lib_issue_id INT primary key,
    book_no INT references books(book_no),
    member_id INT references member1(member_id),
    issue_date DATE,
    return_date DATE,
    check(issue_date<return_date)
);

insert into issue value(7001,101,1,STR_TO_DATE('10-DEC-06','%d-%M-%y'),null);
insert into issue value(7002,102,2,STR_TO_DATE('25-DEC-06','%d-%M-%y'),null);
insert into issue value(7003,104,1,STR_TO_DATE('15-JAN-06','%d-%M-%y'),null);
insert into issue value(7004,101,1,STR_TO_DATE('04-JUL-06','%d-%M-%y'),null);
insert into issue value(7005,104,2,STR_TO_DATE('15-NOV-06','%d-%M-%y'),null);
insert into issue value(7006,101,3,STR_TO_DATE('18-FEB-06','%d-%M-%y'),null);
select * from issue;

DELETE from member1 where member_id=1;
select * from member1;

update issue set return_date=STR_TO_DATE('29-JUL-06','%d-%M-%y') where lib_issue_id=7004;
update issue set return_date=STR_TO_DATE('30-NOV-06','%d-%M-%y') where lib_issue_id=7005;
select * from issue;

update member1 set penalty_amount=100 where member_name='Garima Sen';
set sql_safe_updates=0;
select* from member1;

delete from issue where member_id=1 and issue_date=STR_TO_DATE('10-DEC-06','%d-%M-%y');
select * from issue;

delete from books where category not in ('rdbms','database');
select * from books;

------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM books where author_name='Loni' and cost<600;
SELECT book_name FROM books where author_name='Loni' and cost<600;

select * from issue where return_date<=current_date();

update issue set return_date= str_to_date('31-DEC-06','%d-%M-%y') where (lib_issue_id not in(7005,7006));
select * from issue;

select * from issue where (return_date)-(issue_date) >30; 

select * from books where cost between 500 and 700 and category='Database';

select * from books where category in ('Science', 'Database', 'Fiction', 'Management');

select * from member1 where penalty_amount is not null order by member_name desc;

select * from books order by category asc , cost desc;

select * from books where book_name like '%SQL%' ;

select * from member1 where member_name like 'R%'or member_name like'G%' and member_name like'%i%'; 

select initcap (book_name) and upper(author_name) from books order by book_name desc;
SELECT CONCAT(UCASE(LEFT(book_name, 1)), SUBSTRING(book_name, 2)) AS book_name, UPPER(author_name) AS author_name FROM books ORDER BY book_name DESC; 

select * from issue where book_no=101;

SELECT book_no, book_name, author_name, cost, SUBSTR(category, 1, 1) AS category FROM books; 

SELECT * FROM member1 WHERE YEAR(acc_open_date) =06;
 
select lib_issue_id, issue_date, return_Date,(return_date-issue_date) as no_of_days from issue;

select * from member1 order by acc_open_date;

select sum(max_books_allowed) from member1 where member_id=1;

select sum(penalty_amount) from member1;

select count(member_name) from member1;

select count(lib_issue_id) from issue;

select avg(fee_paid) from member1;

select monthname(return_date-issue_date) from issue;

select length(member_name) from member1;

select  substr(membership_type,1,5) from member1;

select monthname(last_day(issue_date)) from issue;

SELECT category, COUNT(book_no) AS 'Count of Books' FROM books GROUP BY category; 
 
SELECT book_no, COUNT(issue_date) AS 'No Of Times Book Issued' FROM issue GROUP BY book_no ORDER BY COUNT(issue_date) DESC;

SELECT min(penalty_amount),max(penalty_amount),sum(penalty_amount) as total,avg(penalty_amount) from member1;

SELECT member_id, COUNT(book_no) AS 'No Of Books' FROM issue GROUP BY member_id HAVING COUNT(book_no) > 2; 

SELECT member_id, book_no, COUNT(book_no) AS 'No Of Times Same Book Issued' FROM issue GROUP BY member_id, book_no ORDER BY COUNT(book_no) DESC;

SELECT MONTHNAME(issue_date) AS 'Month', COUNT(book_no) AS 'No Of Books Issued' FROM issue GROUP BY MONTHNAME(issue_date) ORDER BY COUNT(book_no) DESC; 
