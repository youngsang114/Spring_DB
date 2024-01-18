show databases;
use example;

show tables;

Desc users;
drop table users;

create table users (
	id int auto_increment primary key,
    person varchar(255) not null,
    age int,
    city varchar(255),
    email varchar(255) not null
);

insert into users (person, age, city, email)
values
	('John', 25, 'New York', 'john@example.com'),
    ('Alice', 30, 'Los Angeles', 'alice@example.com'),
    ('Bob', 28, 'Chicago', 'bob@example.com'),
    ('Eve', 35, 'San Francisco', 'eve@example.com'),
    ('Charlie', 22, 'Houston', 'charlie@example.com');
    
select * from users;

create view example_view as
select id,person,age,email from users where age >=28;

select * from example_view;

-- 뷰를 대상으로 데이터 삽입
Insert into example_view(person,age,email) values ('Frank',40,'frank@naver.com');
-- 불가능
Insert into example_view(age,city) values (40,'miami');
-- 뷰를 대상으로 데이터 업데이트
Update example_view set person='updateName' where id=2;
-- 뷰를 대상으로 데이터 삭제
Delete from example_view where id=3;

-- 집계함수를 이용한 view
Select avg(age) as average_age
from users;

create view age_average_view as
Select avg(age) as average_age
from users;

select * from age_average_view;
-- users와 같이 [실제 데이터의] view는 수정,삭제,추가등등이 [되지만]
-- 집계함수에서 [만들어진 값에] 대해서 추가,삭제,수정등등은 [불가능 하다]!!!!

-- 불가능
DELETE FROM age_average_view;


CREATE VIEW city_population_view AS
SELECT city, COUNT(person) AS population
FROM users
GROUP BY city;

SELECT * FROM city_population_view;

-- 불가능
UPDATE city_population_view SET population = 2 WHERE city = 'New York';

-- 나이(age)의 최대값과 최소값을 계산한 뷰
CREATE VIEW age_statistics_view AS
SELECT MAX(age) AS max_age, MIN(age) AS min_age
FROM users;

SELECT * FROM age_statistics_view;