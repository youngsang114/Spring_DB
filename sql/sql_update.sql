show databases;
use example;

show tables;
drop table categories;
drop table products;

create table categories(
	id Int not null auto_increment,
    name varchar(255) not null,
    primary key (id)
);

Create table products(
	id Int not null auto_increment,
    name varchar(255) not null,
    category_id int not null,
    price int not null,
    registration_date timestamp not null,
    primary key (id),
    foreign key (category_id) references categories (id)
);

show tables;
DESC products;
DESC categories;

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
    
select * from categories;
select * from products;

update products set price=1000 where name='monitor';
update products set registration_date = '2024-01-18 11:00:00' where name='monitor';
-- 1000원이 넘는 물건들의 가격을 10% 할인하겠다
update products set price=price*0.9 where price>=1000;

drop table customers;
drop table orders;

Create table customers(
	customer_id Int primary key,
    customer_name varchar(255) not null
);

Insert into customers (customer_id, customer_name) 
values 
	(1,'user1'), 
	(2,'user2'),
	(3,'user3')
;

Select * from customers;



create table orders(
	order_id int primary key,
    order_customer_id int,
    order_total decimal(10,2),
    constraint fk_order_customer foreign key (order_customer_id) references customers(customer_id)    
    on update CASCADE
);

Insert into orders(order_id, order_customer_id, order_total) 
values 
	(101,1,100.00),
	(102,2,50.00),
	(103,3,750.00);
    
select * from orders;
select * from customers;

update customers set customer_id=4 where customer_id=1;

select * from customers;
select * from orders;

alter table orders Drop foreign key fk_order_customer;

alter table orders 
	ADD constraint fk_order_customer
    foreign key (order_customer_id) 
	references customers(customer_id) 
	on update set null;
    
select * from customers;
select * from orders;

update customers set customer_id =10 where customer_id=2;

select * from customers;
select * from orders;


alter table orders Drop foreign key fk_order_customer;

alter table orders 
	ADD constraint foreign key (order_customer_id) 
	references customers(customer_id) 
	on update restrict;

update customers set customer_id =40 where customer_id=3;
-- error code 1451 : restrict 제한에 걸린다! 
