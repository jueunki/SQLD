-- 트리거 : 방아쇠 당기다 /특정테이블에 업데이트나 삭제나 내용을 넣는 작업을할때 부가적으로 수행할 쿼리문을 미리 만들어주는것
--특정테이블에 적용되고 부가적 sql문을 넣어줄때 사용한다/ 작업을 삭제할 떄 백업파일을 자동으로 만들어놓음
--NEW, OLD : 데이터를 임시로 저장하는 공간, 얘네는 임시테이블

-- -----------------
-- AFTER Trigger
-- -----------------
select * from usertbl;

create table backup_user as select * from usertbl where 1=2;
select * from backup_user;
desc backup_user;

--열추가
alter table backup_user add type varchar(20) not null;
alter table backup_user add moddate date not null;
select * from backup_user;

-- 삭제 트리거 
create or replace trigger trg_01
after
delete
on usertbl
for each row
begin
    insert into backup_user values(:old.userid,:old.name,:old.birthyear,:old.addr,:old.mobile1,
    :old.mobile2,:old.height,:old.mdate,'삭제',SYSDATE);
end;
select * from USER_TRIGGERS;
select * from backup_user;


select * from usertbl;
delete from usertbl where userid='LSG';

select * from backup_user;

-- 수정 트리거

create or replace trigger trg_02
AFTER
UPDATE
ON usertbl
for each row
begin
    insert into backup_user values(:old.userid,:old.name,:old.birthyear,:old.addr,:old.mobile1,
    :old.mobile2,:old.height,:old.mdate,'수정',SYSDATE);
end;
select * from usertbl;
update usertbl set addr='창원' where userid='KBS';
update usertbl set addr='마산' where userid='KKH';
select * from backup_user;

-- 문제
create table makeprodtbl
(
    code int primary key,
    prodname varchar(30),
    amount int
);
create table saveprodtbl
(
    code int,
    prodname varchar(30),
    amount int
);
insert into makeprodtbl values(111,'세탁기',10);
insert into makeprodtbl values(222,'냉장고',5);
insert into makeprodtbl values(333,'노트북',10);
select * from makeprodtbl;
insert into saveprodtbl values(111,'세탁기',50);
insert into saveprodtbl values(222,'냉장고',10);
insert into saveprodtbl values(333,'노트북',30);
select * from saveprodtbl;

SET serveroutput ON;


-- saveprodtbl의 동일 제품명이 있으면 amount update
-- saveprodtbl의 동일 제품명이 없으면 전체를 insert

create or replace trigger trg_03
BEFORE
INSERT 
on makeprodtbl
for each row
declare --NEW테이블의 값을 받아오기
    ncode int;
    nprodname varchar(30);
    namount int;
begin
    
    ncode:=:NEW.code;
    nprodname:=:NEW.prodname;
    namount:=:NEW.amount;
    
    --커서 시작
    declare 
        code int;
        prodname varchar(30);
        amount int;
    cursor Cur_01
    IS
    Select code,prodname,amount
    from  saveprodtbl; 
    begin
        open Cur_01;   
        loop
        FETCH Cur_01 INTO code,prodname,amount; 
        EXIT WHEN Cur_01 %NOTFOUND; 
            if(prodname=nprodname) then
                update saveprodtbl set amount=amount+namount where prodname=nprodname;
                return;   -- 트리거 종료
            end if;
        end loop;
        
        insert into saveprodtbl values(ncode,nprodname,namount);
        
        close Cur_01;
    end; --커서 끝
    
end;

drop trigger trg_03;



select * from makeprodtbl;
select * from saveprodtbl;

insert into makeprodtbl values(444,'휴대폰',10);
insert into makeprodtbl values(666,'세탁기',30);








 

