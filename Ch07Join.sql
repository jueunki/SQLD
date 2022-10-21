select * from usertbl;
select * from buytbl;
select * from ALL_CONSTRAINTS where TABLE_NAME='BUYTBL';

--INNER JOIN
select 열이름
from 테이블A     --
inner join 테이블B
on 조건식;

--↓↓↓--
select *
from usertbl
inner join buytbl
on usertbl.userid=buytbl.userid;
--이거 실행시켰을때 ↓↓여기뜨는게 usertbl이고                                                                                     ↓↓여기 뜨는게 buytbl이다.

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

select mobile1, mobile2 from usertbl;   --mobile1 과 mobile2 출력
select mobile1||mobile2 as phone from usertbl;  --mobile1 과 mobile2를 phone이라는 이름으로 묶어줌
select concat(mobile1, mobile2) as phone from usertbl;  --concat 명령어를 사용해 mobile1 과 mobile2를 phone이라는 이름으로 묶어줌


--마이박스문제풀이--조인Ch09에있음
select buytbl.userid,birthyear,prodname,groupname 
from buytbl
inner join usertbl
on buytbl.userid=usertbl.userid
where usertbl.name='바비킴'

select name,addr,prodname,mobile1|mobile2
from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount*price >=100;

select usertbl.userid,name,birthyear,prodname
from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid
where groupname='전자';

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
-- 동아리 코드 가져오기 
-- [학생Tbl]

drop table stdTbl;
drop table clubTbl;
drop table stdclubTbl;
commit;

CREATE TABLE stdTbl(
	stdName CHAR(10) NOT NULL PRIMARY KEY,
	addr CHAR(10) NOT NULL
);
-- [동아리Tbl]
CREATE TABLE clubTbl(
	clubName CHAR(10) NOT NULL PRIMARY KEY,
	roomNo CHAR(10) NOT NULL
);
-- [학생동아리Tbl]
CREATE TABLE stdclubTbl(
	num INT PRIMARY KEY,
	stdName CHAR(10) NOT NULL,
	clubName CHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
	FOREIGN KEY(clubName)REFERENCES clubTbl(clubname)
);
INSERT INTO stdTbl VALUES('김범수','경남');
INSERT INTO stdTbl values('성시경','서울');
INSERT INTO stdTbl values('조용필','경기');
INSERT INTO stdTbl values('은지원','경북');
INSERT INTO stdTbl values('바비킴','서울');

INSERT INTO clubTbl VALUES('수영','101호');
INSERT INTO clubTbl VALUES('바둑','102호');
INSERT INTO clubTbl VALUES('축구','103호');
INSERT INTO clubTbl VALUES('봉사','104호');

INSERT INTO stdclubTbl VALUES(1,'김범수','바둑');
INSERT INTO stdclubTbl VALUES(2,'김범수','축구');
INSERT INTO stdclubTbl VALUES(3,'조용필','축구');
INSERT INTO stdclubTbl VALUES(4,'은지원','축구');
INSERT INTO stdclubTbl VALUES(5,'은지원','봉사');
INSERT INTO stdclubTbl VALUES(6,'바비킴','봉사');

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
















