Show databases;
use example;

-- Create

create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    email varchar(100) unique,
    birthdate date,
    registration_date timestamp default current_timestamp
); 
desc users;
select * from users;

-- Insert

insert into users values (1, 'user1','user1@naver.com','1995-03-01','2023-09-17');
insert into users (username,email,birthdate) values ('user2','user2@naver.com','2000-01-12');
insert into users (email,birthdate) values ('user3@naver.com','2000-01-12'); # not null인 username이 없으니까 오류가 난다 

show tables;
Drop table products;
Drop table categories;

create table categories (
	id Int Not null auto_increment,
    name varchar(255) not null,
    primary key (id)
);

Desc categories;

create table products(
	id Int not null auto_increment,
    name varchar(255) not null,
    category_id int not null,
    primary key (id),
    foreign key (category_id) references categories(id)
);

Desc products;

-- Insert into FK

Insert into categories values (1,'devices');
Insert into categories (name) values ('clothes');

Select * from categories;

Insert into products (name,category_id) values ('mp3',1);
Insert into products (name,category_id) values ('smartphone',1);
Insert into products (name,category_id) values ('coat',2);
Insert into products (name,category_id) values ('cap',2);

select * from products;

--
