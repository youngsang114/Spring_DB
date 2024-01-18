show databases;
use example;

show tables;
desc categories;
select * from categories;
-- categoires 만들때 index가 id 였으므로alter
-- id가 인덱스(클러스터형 인덱스) 역할을 한다

-- 클러스터 인덱스 확인
Show index from categories;

-- 중복이 허용되는 INDEX 생성 -> 보조 인덱스
create index idx_category_name on categories (name);

/*
-- 2개의 열을 합쳐서 인덱스로 만들고 싶다면
-- CREATE INDEX 인덱스명 on 테이블명(열1,열2)
*/

select * from categories;
Insert into categories(name) values ('category 7');

-- 종복된 데이터 (행)가 있을 때 Index 생성 안됨!!!
Create unique index idx_category_name2 on categories(name);

Delete from categories where name ='category 7';

Drop index idx_category_name2 on categories;
Show index from categories;

-- 인덱스 적용 여부 확인
Explain Select * from categories where name='category 7';
Drop index idx_category_name on categories;
Explain Select * from categories where name='category 7';

-- 인덱스는 데이터 수가 많아졌을 때 빛을 바란다!