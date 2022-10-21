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

-- �� �߰�
alter table tmp_tbl add(col4 int);
desc tmp_tbl;

--�� ����
alter table tmp_tbl modify(col1 varchar(20));
desc tmp_tbl;
--�� ����(�̸�)
alter table tmp_tbl rename column col1 to column1;
desc tmp_tbl;
--�� ����
alter table tmp_tbl drop column col2;
desc tmp_tbl;



--��� ���̺� Ȯ��
select * from all_tables;
select * from all_tables where TABLE_NAME='USERTBL';

-- ���� ���̺� Ȯ��
select * from user_tables;

-- ------------------
-- DDL
-- ------------------
select * from usertbl;
select * from usertbl where name='���ȣ';
select * from usertbl where userid='KKH';
-->���� : where�� ���� �������� �������� �����̸Ӹ� ����Ű��, �ܷ�Ű ���������� �ִ°� �����ϴ°� ����.

--������ + ������
select * from usertbl where Birthyear>=1970; 
select * from usertbl where Birthyear>=1970; and height>=180; -->and��� ���ǿ����ڿ� 
select * from usertbl where height>=170 and height<=180; -->�����ѿ��� �����ڸ� ����ҋ��� ��Ʈ���� ����Ҽ��ִ�
--Between .. and
select * from usertbl where height between 170 and 180; --> �̷��� ��Ʈ�����ε� ����Ҽ��ִ� ������ ��������

--IN
select * from usertbl where addr in('����','���');

-- LIKE
select * from usertbl where name like '��%'; -->ù���ڰ� '��'�λ���� �̴°� �ۼ�Ʈ ��ġ�� ���� �ڿ������� ù���� �̱�
select * from usertbl where name like '%��'; -->�����ڰ� '��;�� ����� �̴°� �ۼ�Ʈ ��ġ�� ���� �տ������� ù���� �̱�
select * from usertbl where userid like '%j%;  --> j�� �����Ѱ� �ۼ�Ʈ��ġ�� �翷���� �ִ°�

-- -----06/Ch01�߰����� �ι�----
-- 1������
select * from buytbl where amount<=5;
-- 2������
select userid,prodname buytbl where price between 50 and 500;
-- 3������
select * from buytbl where amount>=10 or price >=100;
--4������
select * from buytbl where userid like 'K%';
--5������
select * from buytbl where groupname in ('����','����');
--6������
select * from buytbl where prodname='å' or userid like '%W';

-- ----------------------------
-- �������� ����
-- ���ȣ���� ū Ű�� ������ ���� ����ϴ� �ι�
-- ----------------------------
select * from usertbl where height > (select height from usertbl where name='���ȣ'); -->��ȣ�� ���ָ�Ǵ°� ��������

-- �̽±⺸�� ���̰� �� ����(�׸��� ����⵵ ���ڰ� �� ����)����� ���
select * from usertbl where birthyear < (select birthyear from usertbl where name='�̽±�');
--> ���ǻ���
select height from usertbl where addr in ('���'); 
select * from usertbl where hight > (select height from usertbl where addr in ('���')); -->�����°���� �ϳ��̻��ϰ�쿡 ���������� �ٲ㺸���۾�

-- any -->166�̵� 172���̴� �����Ѵٴ� �ǹ�
select * from usertbl where hight > any(select height from usertbl where addr in ('���'));

-- all -->�ϳ��̻󳪿ö� �ִϳ� ���� ����ؼ� ����������Ѵ�.
select * from usertbl where hight > all(select height from usertbl where addr in ('���'));

-- -----06/ch01--31page �߰������ι�----
-- 1������
select * from buytbl where price>={select price from buytbl where amount=10);   

-- 2������
select * from buytbl where amount > any(select amount from buytbl where userid like 'K%');

-- 3������
select * from buytbl where price > ALL(select price from buytbl where amount =5);


-- --------------
-- ���� ����
-- --------------
-- ����
select * from usertbl order by userid asc; -->���������� �ϰ������ ���°�asc����Ŀ���°�
select * from usertbl order by userid desc; -->���������� �ϰ������ ���°�desc�����۾����°�
select * from usertbl order by height ASC;
select * from usertbl order by height ASC,name desc; -->Ű�� �������� ����������,�̸��� �������� ���������ϴ°�


-- Distinct
select distinct addr from usertbl;

-- rownum -->�ڵ����� ���� �ѹ��� �ο�ѹ�����Ѵ� 
--rownum�� �̿��ؼ� ����Ʈ�� �Ŵ��۾�
-- �ϴ� �ּ�ó�� �س��µ� �� �� �ȵǸ� commit;���ְ� �����ϸ�Ǵ°Ͱ���.
select * from usertbl where rownum<=2;

select * from (select rownum as rownumber,usertbl.*from usertbl) where rownumber=2;

select * from (select rownum as RN,usertbl.* from usertbl)where RN>=2 and RN<=4; -->����Ʈ�� ������� ��������۾� (�̸����� �������̺��� �����۾��� �ٸ�����) �ο츦 ������ ���̺��� �������̺�� ����ϰڴٴ��ǹ�
-->Ư�����࿡�� ����������� ����������� ������ ���ڴٰ� �� �� ����Ѵ�

select * from (select rownum as RN,usertbl.* from usertbl) where RN>=2;                             --��ȣ�ȿ��ִ� �������̺��� ���Ҿȿ� ���� �����̴�.
select * from (select rownum as RN,usertbl.* from usertbl) where RN>=2 and RN<=5;
select * from (select rownum as RN,usertbl.* from usertbl) where RN=(select max(rownum)as RN from usertbl);

-- ������RN��
select max(rownum)as from usertbl; -->�ƽ��� �ִ밪�� �����ִ�....�ǵ� 


--drop table c_buytbl1;�̰� ���̺�����ߴ��� �߾ȵǼ�
--drop table c_buytbl2;�̰͵�
-- ���̺� ����
select * from buytbl;

--���� 1(���� + ��)
create table c_buytbl1 as select * from buytbl;
select * from c_buytbl1;

--���� 2 (����)
create table c_buytbl2 as select * from buytbl where 4=2;
select * from c_buytbl2; --> ���Ⱚ�ֱ�
desc c_buytbl2;

--���ֱ�
insert into c_buytbl2 select * from buytbl;

-- -----����
select * from buytbl order by userid;
select * from buytbl order by price desc;
select * from buytbl order by amount,prodname desc;
select distinct prodname from buytbl order by prodname;
select  distinct userid from buytbl;
select * from buytbl where amount>=3 order by prodname desc;
create table CurserTbl as select * from usertbl where addr in ('����','���');
select * from CuserTbl;



-- -------------------------
-- Group By
-- -------------------------
--
select * from buytbl;

select userid,amount from buytbl;-- --------------------------
select userid,sum(amount) from buytbl group by userid; -->sum�� �̿��ؼ� �������̵�鳢�� ������.
select userid,sum(amount) as �ѱ��ŷ� from buytbl group by userid;
select userid,sum(price) as �Ѿ� from buytbl group by userid; -->�������̵��� �Ѿ��� ���ϴºκ�.
select userid,avg(price) as ��� from buytbl group by userid;
select userid,trunc(avg(price*1.0),5) as ��� from buytbl group by userid;

--���� ����+���� �Լ� (����ūŰ,��������Ű)
--����ϴ°ųĸ� 
select max(height) from usertbl; --����ūŰ �����Լ� �����ϰ�
select min(height) from usertbl; --��������Ű �����Լ� �����ϰ�
--���������� �ϴ°Ŵϱ� ���� �ֵ� ��ȣ���ְ�
(select max(height) from usertbl);
(select min(height) from usertbl); --�̷��� �ΰ��� ���ְ�
--�Ǿտ� select * from usertbl where height = �� �ٿ��ָ� �ؿ�����
select * from usertbl where height = (select max(height) from usertbl); 
select * from usertbl where height = (select min(height) from usertbl); --�̷��� ����°ž� ���� ������ο� �ִ°� ����� �̷��Ը� ���ָ�ȴ�.

--Count()
select count(*) from buytbl;
select count(userid) from buytbl;

select count(groupname) from buytbl;
select * from buytbl;

-- -----����-----------
--1������ ��
select userid,sum(amount) from buytbl group by userid;

--2������ ��
select avg(height) from usertbl;

--3������ ��
select distinct userid,amount from buytbl 
where 
amount = (select max(amount) from buytbl) 
or
amount = (select min(amount) from buytbl);
--4������ ��
select count(grupname) from buytbl;

-- -------------------------------------
-- HAVING        �׷캰�� Ư���� ������ �����س����ִµ� 
-- -------------------------------------

--select userid,sum(price*amount) from buytbl group by userid; --sum�� �� ���ϴ°� ������ ���ž�
select userid,sum(price*amount) from buytbl group by userid having sum(price*amount)>=100;
select userid,sum(price*amount) from buytbl group by userid having sum(price*amount)>=100
order by sum(price*amount) desc;
--�׷���̿��� ���� ��迭�� where���� ����Ҽ����� HAVING���� ����� �����ϴ�!! 


select groupname,sum(price*amount) from buytbl group by rollup(groupname);  

select num,groupname,sum(price*amount) from buytbl group by rollup(groupname,num);  

-- ------�߰�����---
--1������
select prodname,sum(price*amount)from buytbl group by prodname; 

--2������  
select prodname,sum(price*amount)from buytbl group by prodname having sum(price*amount)>=1000; 

--3������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
select distinct userid,prodname,price from buytbl
where
price = (select max(price) from buytbl);
or
price = (select min(price) from buytbl);

--4������
select * from buytbl where groupname!='null'; -->���������ڴ� != Ȥ�� <> �̰� ����ȴ� �ΰ���
--5������
select num,prodname,sum(amount) from buytbl group by rollup (prodname,num); -->rollup�� ���հ踦 ���ϴ� ������̴�

select num,prodname,sum(amount) from buytbl group by rollup (prodname,num) having NUM=...�������ʱ��Ұ�;







