show databases;
use example;

drop table customers;
drop table orders;
show tables;

create table customers(
	customer_id int primary key,
    customer_name varchar(255) not null
);

Insert into customers (customer_id, customer_name)
values 
	(1,'고객1'),
	(2,'고객2'),
	(3,'고객3'),
	(4,'고객4'),
	(5,'고객5'),
	(6,'고객6')
    ;
select * from customers;

Delete from customers;
select * from customers;    

Delete from customers where customer_id=1;
Delete from customers where customer_name='고객2';
delete from customers where customer_name like '고객%' and customer_id<5;

select * from customers;  

create table orders(
	order_id int primary key,
    order_customer_id int,
    order_total decimal(10,2),
    constraint fk_order_customer 
    foreign key (order_customer_id) references customers(customer_id)    
    on delete CASCADE
);


Insert into orders(order_id, order_customer_id, order_total) 
values 
	(101,1,100.00),
	(102,2,50.00),
	(103,3,750.00),
	(104,4,175.00),
	(105,5,275.00);
    
Desc orders;
Desc customers;
Select * from orders;
Select * from customers;

Delete from customers where customer_id=3;

Select * from orders;
Select * from customers;

ALTER TABLE orders DROP FOREIGN KEY fk_order_customer;

ALTER TABLE orders
    ADD CONSTRAINT fk_order_customer
    FOREIGN KEY (order_customer_id) REFERENCES customers(customer_id)
    ON DELETE RESTRICT;

DELETE FROM customers WHERE customer_id = 4;
