--
select * from user_table;
--테이블생성시 PK설정
create table test_01
(
    userid char(10) primary key,
    name char (10) not null
);
create table test_02
(
    userid char(10),
    name char (10) not null, --not null도 제약조건이다
    primary key(userid)
);

-- C : not null,check   P :  primary key, R : foreign key, U : unique;
select * from ALL_CONSTRAINTS where table_name='TEST_01';
select * from ALL_CONSTRAINTS where table_name='TEST_02';

--제약조건 삭제부문
alter table test_01 drop primary key; 

--제약조건 추가작업부문
alter table test_01 add constraint PK_test_01 primary key(userid);

--여러 열을 PK로 지정
alter table test_02 drop primary key;
select * from ALL_CONSTRAINTS where table_name='TEST_02';
desc test test_02;
alter table test_02 add constraint PK_TEST02 primary key(userid,name); 
select * from ALL_CONSTRAINTS where table_name='TEST_02';

--제약조건설정된 컬럼 확인하기 //현재는 프라이머리키가 설정되어있는지 확인하는것이다.//--ALL_CONS_COLUMNS : 사전
select * from ALL_CONS_COLUMNS where CONSTRAINT_NAME='PK_TEST02';

desc usertbl;
desc buytbl;
drop TABLE C_USERTBL;
drop table C_BUYTBL;
--강사님문제
--USERTBL을 C_USERTBL 복사 한 다음 Userid열과 birthyear열을 PK로 설정하세요
--BUYTBL을 C_BUYTBL로 복사 한 다음 NUM열을 PK로 설정하세요
--C_BUYTBL에서 birthyear열을 추가합니다(C_USERTBL의 birthyear와 자료형이 일치해야합니다)
--C_BUYTBL의 userid+birthyear를 외래키로 하여 C_USERTBL의 PK와 연결하세요
delete from C_BUYTBL;
delete from C_USERTBL;
--데이터 사전을 이용하여 설정된 제약조건과 해당 열을 확인합니다.
select * from ALL_CONSTRAINTS where table_name='USERTBL';
select * from ALL_CONSTRAINTS where table_name='BUYTBL';

create table C_USERTBL as select * from usertbl;
select * from ALL_CONSTRAINTS where table_name='C_USERTBL';
alter table  C_USERTBL add constraint PK_CUSERTBL primary key(userid,birthyear);
select * from ALL_CONSTRAINTS where table_name='C_BUYTBL'; 
alter table C_BUYTBL add constraint PK_USERTBL primary key(userid,birthyear);

-- 외래키 제약조건부문
desc test_01;

create table test_03
(
    num int primary key,
    userid char(10), 
    constraint FK_03_01 foreign key(userid) references test_01(userid)
);


select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_03';
select * from ALL_CONS_COLUMNS where CONSTRAINT_NAME='FK_03_01';

--C_BUYTBL에서 birthyear열을 추가합니다(C_USERTBL의 birthyear와 자료형이 일치해야합니다)
--C_BUYTBL의 userid+birthyear를 외래키로 하여 C_USERTBL의 PK와 연결하세요

desc C_BUYTBL;
create table C_BUYTBL as select * from buytbl where 1=2;
desc C_BUYTBL;
select * from C_BUYTBL;
select * from ALL_CONSTRAINTS where TABLE_NAME='C_BUYTBL';
alter table C_BUYTBL add constraint PK_NUM primary key(num);

desc C_USERTBL;
alter table C_BUYTBL add BIRTHYEAR number(38) not null;

alter table C_BUYTBL add constraint FK_BUY_USER_01 foreign key(userid) references C_USERTBL(userid,birthyear);

select * from ALL_CONSTRAINTS where TABLE_NAME='C_BUYTBL';

-- MYBOX문제-----
--다음 테이블을 sql문을 통해 생성해보세요

create table CUSTOMERTBL
(
    code int primary key,
    prodname varchar(20),
    price int,
    count int
);
 
create table PRODUCTTBL
(
    num int primary key,
    userid varchar(20),
    name varchar(20),
    addr varchar(5),
    grade varchar(10),
    phone varchar(25),
    code int,
    amount int,
    constraint FK_CUS_PROD foreign key(code) references producttbl(code)
);

select * from ALL_CONSTRAINTS where TABLE_NAME-'CUSTOMERTBL';
select * from ALL_CONSTRAINTS where TABLE_NAME-'PRODUCTTBL';




desc test_01;
select  * from ALL_CONSTRAINTS where TABLE_NAME='TEST_03';
alter table TEST_03 drop constraint FK_03_01;
alter table TEST_03 add constraint FK_03_01 foreign key(userid) references TEST_01(userid) on delete cascade;
--//--필기 CASCADE 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블에서도 삭제와 수정이 같이 이루어진다고 되어있는데
-- 참조되는 테이블은 프라이머리키를 의미한다


-- UNIQUE제약조건(중복을 허용하지않는다,하지만 빈문자열은 허용한다(NULL,email등))
create table TEST_04
(
    no int primary key,
    email varchar(50)unique
);
select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_04';
insert into TEST_04 values(1,'aaa@naver.com');
insert into TEST_04(no) values(2);
select * from TEST_04;
insert into TEST_04 values(3,'aaa@naver.com');     
from TEST_04;


--MYBOX문제 -----
--SQL문으로 테이블 관계를 포함 생성하세요
--db는 testdb에서 진행한다
--외래키옵션은 delete cascade로 설정한다

create table stdTBL('문제풀어봐 뭔지 하나도 모르겠다'
    PK_stdname varchar(50)primary key,
    stdaddr varchar(50)
    CONSTRAINT STDTBL_PK primary key(PK_stdname)
);

create table stdclubTBL(
    number int(5),
    stdclub varchar(45) 
);

create table ciubTBL(
    ciubname varchar(50)primary key,
    roomnumber varchar(50)
);


-- ----------------------------

-- Check

select * from buytbl;
create table C_buytbl as select userid,prodname,amount from buytbl;
select * from C_buytbl;
insert into C_buytbl values('aaa','책',-1);
delete from C_buytbl where userid='aaa';

alter table C_buytbl add constraint CK_amount CHECK(amount>0 and amount<=100);
select * from ALL_CONSTRAINTS where TABLE_NAME='C_BUYTBL';
insert into C_buytbl values('aaa','책',-1);
insert into C_buytbl values('aaa','책',101);
insert into C_buytbl values('aaa','책',50);

-- default 기본값을 설정하는것

desc test_01;
alter table test_01 modify(name default '없음');
 
select * from USER_TAB_COLUMNS where TABLE_NAME='TEST_01';

insert into test_01 values('aaa',default);
insert into test_01 values('aab',default);
insert into test_01 values('aac',default);

select * from test_01;







