--
select * from user_table;
--���̺������ PK����
create table test_01
(
    userid char(10) primary key,
    name char (10) not null
);
create table test_02
(
    userid char(10),
    name char (10) not null, --not null�� ���������̴�
    primary key(userid)
);

-- C : not null,check   P :  primary key, R : foreign key, U : unique;
select * from ALL_CONSTRAINTS where table_name='TEST_01';
select * from ALL_CONSTRAINTS where table_name='TEST_02';

--�������� �����ι�
alter table test_01 drop primary key; 

--�������� �߰��۾��ι�
alter table test_01 add constraint PK_test_01 primary key(userid);

--���� ���� PK�� ����
alter table test_02 drop primary key;
select * from ALL_CONSTRAINTS where table_name='TEST_02';
desc test test_02;
alter table test_02 add constraint PK_TEST02 primary key(userid,name); 
select * from ALL_CONSTRAINTS where table_name='TEST_02';

--�������Ǽ����� �÷� Ȯ���ϱ� //����� �����̸Ӹ�Ű�� �����Ǿ��ִ��� Ȯ���ϴ°��̴�.//--ALL_CONS_COLUMNS : ����
select * from ALL_CONS_COLUMNS where CONSTRAINT_NAME='PK_TEST02';

desc usertbl;
desc buytbl;
drop TABLE C_USERTBL;
drop table C_BUYTBL;
--����Թ���
--USERTBL�� C_USERTBL ���� �� ���� Userid���� birthyear���� PK�� �����ϼ���
--BUYTBL�� C_BUYTBL�� ���� �� ���� NUM���� PK�� �����ϼ���
--C_BUYTBL���� birthyear���� �߰��մϴ�(C_USERTBL�� birthyear�� �ڷ����� ��ġ�ؾ��մϴ�)
--C_BUYTBL�� userid+birthyear�� �ܷ�Ű�� �Ͽ� C_USERTBL�� PK�� �����ϼ���
delete from C_BUYTBL;
delete from C_USERTBL;
--������ ������ �̿��Ͽ� ������ �������ǰ� �ش� ���� Ȯ���մϴ�.
select * from ALL_CONSTRAINTS where table_name='USERTBL';
select * from ALL_CONSTRAINTS where table_name='BUYTBL';

create table C_USERTBL as select * from usertbl;
select * from ALL_CONSTRAINTS where table_name='C_USERTBL';
alter table  C_USERTBL add constraint PK_CUSERTBL primary key(userid,birthyear);
select * from ALL_CONSTRAINTS where table_name='C_BUYTBL'; 
alter table C_BUYTBL add constraint PK_USERTBL primary key(userid,birthyear);

-- �ܷ�Ű �������Ǻι�
desc test_01;

create table test_03
(
    num int primary key,
    userid char(10), 
    constraint FK_03_01 foreign key(userid) references test_01(userid)
);


select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_03';
select * from ALL_CONS_COLUMNS where CONSTRAINT_NAME='FK_03_01';

--C_BUYTBL���� birthyear���� �߰��մϴ�(C_USERTBL�� birthyear�� �ڷ����� ��ġ�ؾ��մϴ�)
--C_BUYTBL�� userid+birthyear�� �ܷ�Ű�� �Ͽ� C_USERTBL�� PK�� �����ϼ���

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

-- MYBOX����-----
--���� ���̺��� sql���� ���� �����غ�����

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
--//--�ʱ� CASCADE �����Ǵ� ���̺��� �����͸� �����ϰų� �����ϸ� �����ϴ� ���̺����� ������ ������ ���� �̷�����ٰ� �Ǿ��ִµ�
-- �����Ǵ� ���̺��� �����̸Ӹ�Ű�� �ǹ��Ѵ�


-- UNIQUE��������(�ߺ��� ��������ʴ´�,������ ���ڿ��� ����Ѵ�(NULL,email��))
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


--MYBOX���� -----
--SQL������ ���̺� ���踦 ���� �����ϼ���
--db�� testdb���� �����Ѵ�
--�ܷ�Ű�ɼ��� delete cascade�� �����Ѵ�

create table stdTBL('����Ǯ��� ���� �ϳ��� �𸣰ڴ�'
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
insert into C_buytbl values('aaa','å',-1);
delete from C_buytbl where userid='aaa';

alter table C_buytbl add constraint CK_amount CHECK(amount>0 and amount<=100);
select * from ALL_CONSTRAINTS where TABLE_NAME='C_BUYTBL';
insert into C_buytbl values('aaa','å',-1);
insert into C_buytbl values('aaa','å',101);
insert into C_buytbl values('aaa','å',50);

-- default �⺻���� �����ϴ°�

desc test_01;
alter table test_01 modify(name default '����');
 
select * from USER_TAB_COLUMNS where TABLE_NAME='TEST_01';

insert into test_01 values('aaa',default);
insert into test_01 values('aab',default);
insert into test_01 values('aac',default);

select * from test_01;







