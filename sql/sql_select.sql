show databases;
use example;
show tables;
drop table products;
drop table categories;

create table categories(
	id Int not null auto_increment,
    name varchar(255) not null,
    primary key (id)
);


Create table products(
	id Int not null auto_increment,
    name varchar(50) not null,
    category_id int not null,
    price int not null,
    registration_date timestamp not null,
    primary key (id),
    foreign key (category_id) references categories (id)
);

show tables;
DESC categories;
DESC products;

Insert into categories(name) values
	('Category 1'),
	('Category 2'),
	('Category 3'),
	('Category 4'),
	('Category 5'),
	('Category 6'),
	('Category 7'),
	('Category 8'),
	('Category 9'),
	('Category 10');
 
select * from categories; 
-- select (`열`명)
select id from categories;

Insert into products (name, category_id, price, registration_date) values
	('apple', 1,1000,'2023-09-20 10:00:00'),
	('banana', 2,800,'2023-09-20 11:30:00'),
	('keyboard', 3,1200,'2023-09-20 12:45:00'),
	('monitor', 3,1500,'2023-09-20 14:20:00'),
	('small monitor', 2,750,'2023-09-20 15:10:00'),
	('big monitor', 4,2000,'2023-09-20 16:40:00'),
	('headphone', 3,1350,'2023-09-20 18:00:00'),
	('pizza', 1,950,'2023-09-20 19:30:00'),
	('chicken', 1,1800,'2023-09-20 21:15:00'),
	('glasses', 2,1000,'2023-09-20 22:45:00');

Select * from products;

select name,price from products;

select * from products Where category_id=2;
select name,price from products Where category_id=2;

select name,price from products Where category_id !=2;

select * from categories where name="Category 3";

select * from products where category_id IS NULL;

select * from products where price > 1000 and category_id =3;
select * from categories where id>=5 and id<8;

-- DISTINCT 로 중복을 없앨 수 있다

select category_id from products;
SELECT DISTINCT category_id from products;


-- Order by를 이용한 정렬 방법

select id from categories;
select id from categories order by id DESC;
select id from categories order by id ASC;

Select * from products order by price ASC;

Select * from products where category_id >2 order by price ASC;

-- Alias : as를 이용한 별칭 만들기 
select count(*) as number_of_data from products;

-- 연산 및 집계 함수

select count(*) from products; 
select count(price) from products;

select count(*) as more_than_1000 from products where price >=1000;

select SUM(price) from products;
select AVG(price) from products;
select MAX(price) from products;
select MIN(price) from products;

select MIN(distinct price) from products;
-- price의 중복을 제거한 평균 값
select AVG(distinct price) from products;

-- like를 이용한 패턴 검색
-- _ : 임의의 문자 (한 글자 의미)
-- % : 임의의 문자열을 (여러 글자 의미)

select name from products where name like '_onitor';
select name from products where name like '%monitor%';

-- group by & having

create table mytable(
	user_id Int not null,
    product_id int not null,
    price int not null,
    amount int not null
);

DESC mytable;

Insert Into mytable (user_id, product_id, price,amount) values
(1,1,100,1),
(1,2,200,2),
(2,1,500,1),
(2,2,100,2),
(3,1,100,1),
(3,2,200,1),
(4,1,500,1),
(4,2,100,1);

select * from mytable;

select user_id, sum(price*amount) as total_price
from mytable
group by user_id;

select user_id, sum(price*amount) as total_price
from mytable
group by user_id
having total_price>500;

select user_id, sum(price*amount) as total_price
from mytable
where user_id =2
group by user_id
having total_price>500;

-- having은 grouping된 조건식을 쓰고, where은 grouping되지 않은 조건식을 쓴다

select category_id, AVG(price) from products group by category_id;
select category_id, AVG(price)  from products group by category_id having AVG(price)>1200; 

-- 서브 쿼리 (쿼리 안에 쿼리)

-- 각 사용자가 가장 많이 구매한 상품 아이디 찾기

select * from mytable;

select user_id, product_id
from mytable
where (user_id, amount) in(
	select user_id, max(amount)
    from mytable
    group by user_id
);

select user_id, max(amount)
from mytable
group by user_id;
