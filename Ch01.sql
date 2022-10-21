-- ------------------
-- DDL
-- ------------------
drop table tmp_tbl;
create table tmp_tbl

(
    coll int primary key,
    col2 int,
    col3 int
);
desc tmp_tbl;

-- 열 추가
alter table tmp_tbl add(col4 int);
desc tmp_tbl;

--열 변경
alter table tmp_tbl modify(col1 varchar(20));
desc tmp_tbl;
--열 변경(이름)
alter table tmp_tbl rename column col1 to column1;
desc tmp_tbl;
--열 삭제
alter table tmp_tbl drop column col2;
desc tmp_tbl;



--모든 테이블 확인
select * from all_tables;
select * from all_tables where TABLE_NAME='USERTBL';

-- 유저 테이블 확인
select * from user_tables;

-- ------------------
-- DDL
-- ------------------
select * from usertbl;
select * from usertbl where name='김경호';
select * from usertbl where userid='KKH';
-->꿀팁 : where을 쓸때 조건절을 잡을때는 프라이머리 제약키나, 외래키 제약조건이 있는걸 선택하는게 좋다.

--조건절 + 연산자
select * from usertbl where Birthyear>=1970; 
select * from usertbl where Birthyear>=1970; and height>=180; -->and라는 조건연산자와 
select * from usertbl where height>=170 and height<=180; -->동일한열의 연산자를 사용할떄는 비트윈을 사용할수있다
--Between .. and
select * from usertbl where height between 170 and 180; --> 이렇게 비트윈으로도 사용할수있다 동일함 위에꺼랑

--IN
select * from usertbl where addr in('서울','경기');

-- LIKE
select * from usertbl where name like '김%'; -->첫문자가 '김'인사람만 뽑는것 퍼센트 위치가 글자 뒤에있으면 첫문자 뽑기
select * from usertbl where name like '%우'; -->끝문자가 '우;인 사람만 뽑는것 퍼센트 위치가 글자 앞에있으면 첫문자 뽑기
select * from usertbl where userid like '%j%;  --> j를 포함한것 퍼센트위치가 양옆으로 있는것

-- -----06/Ch01중간문제 부문----
-- 1번문제
select * from buytbl where amount<=5;
-- 2번문제
select userid,prodname buytbl where price between 50 and 500;
-- 3번문제
select * from buytbl where amount>=10 or price >=100;
--4번문제
select * from buytbl where userid like 'K%';
--5번문제
select * from buytbl where groupname in ('서적','전자');
--6번문제
select * from buytbl where prodname='책' or userid like '%W';

-- ----------------------------
-- 서브쿼리 배우기
-- 김경호보다 큰 키를 가지는 행을 출력하는 부문
-- ----------------------------
select * from usertbl where height > (select height from usertbl where name='김경호'); -->괄호만 쳐주면되는게 서브쿼리

-- 이승기보다 나이가 더 많은(그리고 출생년도 숫자가 더 작은)사람만 출력
select * from usertbl where birthyear < (select birthyear from usertbl where name='이승기');
--> 주의사항
select height from usertbl where addr in ('경기'); 
select * from usertbl where hight > (select height from usertbl where addr in ('경기')); -->나오는결과가 하나이상일경우에 서브쿼리로 바꿔보는작업

-- any -->166이든 172값이던 만족한다는 의미
select * from usertbl where hight > any(select height from usertbl where addr in ('경기'));

-- all -->하나이상나올때 애니나 올을 사용해서 정리해줘야한다.
select * from usertbl where hight > all(select height from usertbl where addr in ('경기'));

-- -----06/ch01--31page 중간문제부문----
-- 1번문제
select * from buytbl where price>={select price from buytbl where amount=10);   

-- 2번문제
select * from buytbl where amount > any(select amount from buytbl where userid like 'K%');

-- 3번문제
select * from buytbl where price > ALL(select price from buytbl where amount =5);


-- --------------
-- 정렬 배우기
-- --------------
-- 정렬
select * from usertbl order by userid asc; -->오름차순을 하고싶을때 쓰는것asc점점커지는것
select * from usertbl order by userid desc; -->내림차순을 하고싶을때 쓰는것desc점점작아지는것
select * from usertbl order by height ASC;
select * from usertbl order by height ASC,name desc; -->키를 기준으로 오름차순후,이름을 기준으로 내림차순하는것


-- Distinct
select distinct addr from usertbl;

-- rownum -->자동으로 들어가는 넘버를 로우넘버라고한다 
--rownum를 이용해서 리미트를 거는작업
-- 일단 주석처리 해놨는데 뭐 잘 안되면 commit;해주고 실행하면되는것같다.
select * from usertbl where rownum<=2;

select * from (select rownum as rownumber,usertbl.*from usertbl) where rownumber=2;

select * from (select rownum as RN,usertbl.* from usertbl)where RN>=2 and RN<=4; -->셀렉트된 결과물이 따라오는작업 (이름없는 가상테이블을 만든작업과 다름없다) 로우를 포함한 테이블을 가상테이블로 사용하겠다는의미
-->특정한행에서 어느정도에서 어느정도까지 빼내어 오겠다고 할 때 사용한다

select * from (select rownum as RN,usertbl.* from usertbl) where RN>=2;                             --괄호안에있는 가상테이블은 프롬안에 들어가는 형태이다.
select * from (select rownum as RN,usertbl.* from usertbl) where RN>=2 and RN<=5;
select * from (select rownum as RN,usertbl.* from usertbl) where RN=(select max(rownum)as RN from usertbl);

-- 마지막RN값
select max(rownum)as from usertbl; -->맥스는 최대값을 꺼내주는....건데 


--drop table c_buytbl1;이건 테이블삭제했던거 잘안되서
--drop table c_buytbl2;이것도
-- 테이블 복사
select * from buytbl;

--복사 1(구조 + 값)
create table c_buytbl1 as select * from buytbl;
select * from c_buytbl1;

--복사 2 (구조)
create table c_buytbl2 as select * from buytbl where 4=2;
select * from c_buytbl2; --> 여기값넣기
desc c_buytbl2;

--값넣기
insert into c_buytbl2 select * from buytbl;

-- -----문제
select * from buytbl order by userid;
select * from buytbl order by price desc;
select * from buytbl order by amount,prodname desc;
select distinct prodname from buytbl order by prodname;
select  distinct userid from buytbl;
select * from buytbl where amount>=3 order by prodname desc;
create table CurserTbl as select * from usertbl where addr in ('서울','경기');
select * from CuserTbl;



-- -------------------------
-- Group By
-- -------------------------
--
select * from buytbl;

select userid,amount from buytbl;-- --------------------------
select userid,sum(amount) from buytbl group by userid; -->sum을 이용해서 유저아이디들끼리 묶었다.
select userid,sum(amount) as 총구매량 from buytbl group by userid;
select userid,sum(price) as 총액 from buytbl group by userid; -->유저아이디간의 총액을 구하는부분.
select userid,avg(price) as 평균 from buytbl group by userid;
select userid,trunc(avg(price*1.0),5) as 평균 from buytbl group by userid;

--서브 쿼리+집계 함수 (가장큰키,가장작은키)
--어떻게하는거냐면 
select max(height) from usertbl; --가장큰키 집계함수 생성하고
select min(height) from usertbl; --가장작은키 집계함수 생성하고
--서브쿼리로 하는거니깐 위에 애들 괄호쳐주고
(select max(height) from usertbl);
(select min(height) from usertbl); --이렇게 두개다 해주고
--맨앞에 select * from usertbl where height = 을 붙여주면 밑에보면
select * from usertbl where height = (select max(height) from usertbl); 
select * from usertbl where height = (select min(height) from usertbl); --이렇게 만드는거야 위에 설명라인에 있는건 경과고 이렇게만 써주면된다.

--Count()
select count(*) from buytbl;
select count(userid) from buytbl;

select count(groupname) from buytbl;
select * from buytbl;

-- -----문제-----------
--1번문제 답
select userid,sum(amount) from buytbl group by userid;

--2번문제 답
select avg(height) from usertbl;

--3번문제 답
select distinct userid,amount from buytbl 
where 
amount = (select max(amount) from buytbl) 
or
amount = (select min(amount) from buytbl);
--4번문제 답
select count(grupname) from buytbl;

-- -------------------------------------
-- HAVING        그룹별로 특정한 값들을 구현해낼수있는데 
-- -------------------------------------

--select userid,sum(price*amount) from buytbl group by userid; --sum은 합 구하는거 예전에 배운거야
select userid,sum(price*amount) from buytbl group by userid having sum(price*amount)>=100;
select userid,sum(price*amount) from buytbl group by userid having sum(price*amount)>=100
order by sum(price*amount) desc;
--그룹바이에서 나온 통계열은 where절로 사용할수없고 HAVING절로 사용이 가능하다!! 


select groupname,sum(price*amount) from buytbl group by rollup(groupname);  

select num,groupname,sum(price*amount) from buytbl group by rollup(groupname,num);  

-- ------중간문제---
--1번문제
select prodname,sum(price*amount)from buytbl group by prodname; 

--2번문제  
select prodname,sum(price*amount)from buytbl group by prodname having sum(price*amount)>=1000; 

--3번문제                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
select distinct userid,prodname,price from buytbl
where
price = (select max(price) from buytbl);
or
price = (select min(price) from buytbl);

--4번문제
select * from buytbl where groupname!='null'; -->부정연산자는 != 혹은 <> 이거 쓰면된다 두개임
--5번문제
select num,prodname,sum(amount) from buytbl group by rollup (prodname,num); -->rollup은 총합계를 구하는 연산식이다

select num,prodname,sum(amount) from buytbl group by rollup (prodname,num) having NUM=...나머지필기할것;







