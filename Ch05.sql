--index 목차 페이지가 많아지면 성능이 떨어진다

drop table test_01 cascade constraints; --외래키 무시하고 삭제하는 명령어
drop table test_02;

create table test_01
(
    col1 int primary key,
    col2 int 
);
select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_01';
select * from USER_INDEXES where TABLE_NAME='TEST_01';
select * from ALL_IND_COLUMNS where TABLE_NAME='TEST_01';-- 프라이머리 키를 기준으로 인덱스가 하나 생기는데 프라이머리키는 기본적으로 인덱스를 생성을 한다
create table test_02
(
    col1 int unique,
    col2 int
);
select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_02';
select * from USER_INDEXES where TABLE_NAME='TEST_02';
select * from ALL_IND_COLUMNS where TABLE_NAME='TEST_02';

drop table test_03;

create table test_03
(
    col1 int primary key,
    col2 int
    constraint FK_03_01 foreign key(col2) references test_01(col1)
);
select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_03';
select * from USER_INDEXES where TABLE_NAME='TEST_03';
select * from ALL_IND_COLUMNS where TABLE_NAME='TEST_03';

create index_FK_03_IDX_ON test_03(col2); 

select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_03';
select * from USER_INDEXES where TABLE_NAME='TEST_03';
select * from ALL_IND_COLUMNS where TABLE_NAME='TEST_03';

--문제 
drop table C_usertbl;
drop table C_buytbl;
create table C_usertbl as select * from usertbl;
create table C_buytbl as select * from buytbl;

--C_usertbl 의 userid 열을 PK로 지정
alter table C_usertbl add constraint PK_USERID primary key(userid);
select * from ALL_CONSTRAINTS where TABLE_NAME='C_USERTBL';


--C_buytbl 의 userid 열을 FK로 지종 (delete시 cascade설정)
alter table C_buytbl add constraint FK_BUY_USER foreugn key(userid)
references C_usertbl(userid)
on delete cascade;
commit;

rollback;
--C_buytbl 의 userid 열을 INDEX 설정 (index명 : FK_buy_user)
cerate index FK_buy_user on C_buytbl(userid);


--데이터 사전울 이용해서 각 테이블의 index 확인




