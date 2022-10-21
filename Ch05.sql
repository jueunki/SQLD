--index ���� �������� �������� ������ ��������

drop table test_01 cascade constraints; --�ܷ�Ű �����ϰ� �����ϴ� ��ɾ�
drop table test_02;

create table test_01
(
    col1 int primary key,
    col2 int 
);
select * from ALL_CONSTRAINTS where TABLE_NAME='TEST_01';
select * from USER_INDEXES where TABLE_NAME='TEST_01';
select * from ALL_IND_COLUMNS where TABLE_NAME='TEST_01';-- �����̸Ӹ� Ű�� �������� �ε����� �ϳ� ����µ� �����̸Ӹ�Ű�� �⺻������ �ε����� ������ �Ѵ�
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

--���� 
drop table C_usertbl;
drop table C_buytbl;
create table C_usertbl as select * from usertbl;
create table C_buytbl as select * from buytbl;

--C_usertbl �� userid ���� PK�� ����
alter table C_usertbl add constraint PK_USERID primary key(userid);
select * from ALL_CONSTRAINTS where TABLE_NAME='C_USERTBL';


--C_buytbl �� userid ���� FK�� ���� (delete�� cascade����)
alter table C_buytbl add constraint FK_BUY_USER foreugn key(userid)
references C_usertbl(userid)
on delete cascade;
commit;

rollback;
--C_buytbl �� userid ���� INDEX ���� (index�� : FK_buy_user)
cerate index FK_buy_user on C_buytbl(userid);


--������ ������ �̿��ؼ� �� ���̺��� index Ȯ��




