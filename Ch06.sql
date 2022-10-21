drop table test;
create table test_tbl
(
    No int,
    name varchar(20),
    age int,
    gender varchar(10)
);
desc test_tbl;
commit;
insert into test_tbl values(1,'aaa',10,'M');
insert into test_tbl values(2,'bbb',15,'M');
insert into test_tbl values(3,'ccc',25,'M');
select * from test_tbl;
commit;
rollback;
select * from test_tbl;
delete from test_tbl;
commit;

insert into test_tbl values(1,'aaa',10,'M');
insert into test_tbl values(2,'bbb',15,'M');
savepoint s1;
insert into test_tbl values(3,'ccc',25,'M');
select * from test_tbl;
rollback to s1;'
select * from test_tbl;
insert into test_tbl values(3,'ccc',25,'M');
insert into test_tbl values(4,'ccc',35,'M');
select * from test_tbl;
rollback to s2;
select * from test_tbl;

create table Account_tbl
(
    AccountNum varchar(50) primary key,
    owner varchar(20),
    saved int
);
insert into Account_tbl values('1111-1111','ȫ�浿',100000);
insert into Account_tbl values('2222-2222','ȫ�浿',50000);
select * from Account_tbl;
alter table Account_tbl add constraint DK_SAVED check(saved >=0);
commit;

select * from Account_tbl;





