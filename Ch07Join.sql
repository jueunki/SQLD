select * from usertbl;
select * from buytbl;
select * from ALL_CONSTRAINTS where TABLE_NAME='BUYTBL';

--INNER JOIN
select ���̸�
from ���̺�A     --
inner join ���̺�B
on ���ǽ�;

--����--
select *
from usertbl
inner join buytbl
on usertbl.userid=buytbl.userid;
--�̰� ����������� ��鿩��ߴ°� usertbl�̰�                                                                                     ��鿩�� �ߴ°� buytbl�̴�.

select usertbl.userid,addr,prodname,price,amount
from usertbl
inner join buytbl
on usertbl.userid=buytbl.userid;


select U.userid,addr,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid=B.userid;


select U.userid,addr,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid=B.userid
where amount>=5;

select mobile1, mobile2 from usertbl;   --mobile1 �� mobile2 ���
select mobile1||mobile2 as phone from usertbl;  --mobile1 �� mobile2�� phone�̶�� �̸����� ������
select concat(mobile1, mobile2) as phone from usertbl;  --concat ��ɾ ����� mobile1 �� mobile2�� phone�̶�� �̸����� ������


--���̹ڽ�����Ǯ��--����Ch09������
select buytbl.userid,birthyear,prodname,groupname 
from buytbl
inner join usertbl
on buytbl.userid=usertbl.userid
where usertbl.name='�ٺ�Ŵ'

select name,addr,prodname,mobile1|mobile2
from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount*price >=100;

select usertbl.userid,name,birthyear,prodname
from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid
where groupname='����';

--outer Join
--left / right
select *
from usertbl
left outer join buytbl
on usertbl.userid = buytbl.userid;

select *
from buytbl
right outer join usertbl
on usertbl.userid = buytbl.userid;

--------------------
-- ���Ƹ� �ڵ� �������� 
-- [�л�Tbl]

drop table stdTbl;
drop table clubTbl;
drop table stdclubTbl;
commit;

CREATE TABLE stdTbl(
	stdName CHAR(10) NOT NULL PRIMARY KEY,
	addr CHAR(10) NOT NULL
);
-- [���Ƹ�Tbl]
CREATE TABLE clubTbl(
	clubName CHAR(10) NOT NULL PRIMARY KEY,
	roomNo CHAR(10) NOT NULL
);
-- [�л����Ƹ�Tbl]
CREATE TABLE stdclubTbl(
	num INT PRIMARY KEY,
	stdName CHAR(10) NOT NULL,
	clubName CHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
	FOREIGN KEY(clubName)REFERENCES clubTbl(clubname)
);
INSERT INTO stdTbl VALUES('�����','�泲');
INSERT INTO stdTbl values('���ð�','����');
INSERT INTO stdTbl values('������','���');
INSERT INTO stdTbl values('������','���');
INSERT INTO stdTbl values('�ٺ�Ŵ','����');

INSERT INTO clubTbl VALUES('����','101ȣ');
INSERT INTO clubTbl VALUES('�ٵ�','102ȣ');
INSERT INTO clubTbl VALUES('�౸','103ȣ');
INSERT INTO clubTbl VALUES('����','104ȣ');

INSERT INTO stdclubTbl VALUES(1,'�����','�ٵ�');
INSERT INTO stdclubTbl VALUES(2,'�����','�౸');
INSERT INTO stdclubTbl VALUES(3,'������','�౸');
INSERT INTO stdclubTbl VALUES(4,'������','�౸');
INSERT INTO stdclubTbl VALUES(5,'������','����');
INSERT INTO stdclubTbl VALUES(6,'�ٺ�Ŵ','����');

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

---inner join
select *
from stdtbl S
inner join stdclubtbl sc
on S.stdname=SC.stdname;
inner join clubtbl C
on SC.clubname = C.clubname;

--left Outer join
select *
from stdtbl S
left outer join stdclubtbl SC
on S.stdname = SC.stdname
left outer join clubtbl C
on SC.clubname = c.clubname
;
















