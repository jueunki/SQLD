-- Ʈ���� : ��Ƽ� ���� /Ư�����̺� ������Ʈ�� ������ ������ �ִ� �۾����Ҷ� �ΰ������� ������ �������� �̸� ������ִ°�
--Ư�����̺� ����ǰ� �ΰ��� sql���� �־��ٶ� ����Ѵ�/ �۾��� ������ �� ��������� �ڵ����� ��������
--NEW, OLD : �����͸� �ӽ÷� �����ϴ� ����, ��״� �ӽ����̺�

-- -----------------
-- AFTER Trigger
-- -----------------
select * from usertbl;

create table backup_user as select * from usertbl where 1=2;
select * from backup_user;
desc backup_user;

--���߰�
alter table backup_user add type varchar(20) not null;
alter table backup_user add moddate date not null;
select * from backup_user;

-- ���� Ʈ���� 
create or replace trigger trg_01
after
delete
on usertbl
for each row
begin
    insert into backup_user values(:old.userid,:old.name,:old.birthyear,:old.addr,:old.mobile1,
    :old.mobile2,:old.height,:old.mdate,'����',SYSDATE);
end;
select * from USER_TRIGGERS;
select * from backup_user;


select * from usertbl;
delete from usertbl where userid='LSG';

select * from backup_user;

-- ���� Ʈ����

create or replace trigger trg_02
AFTER
UPDATE
ON usertbl
for each row
begin
    insert into backup_user values(:old.userid,:old.name,:old.birthyear,:old.addr,:old.mobile1,
    :old.mobile2,:old.height,:old.mdate,'����',SYSDATE);
end;
select * from usertbl;
update usertbl set addr='â��' where userid='KBS';
update usertbl set addr='����' where userid='KKH';
select * from backup_user;

-- ����
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
insert into makeprodtbl values(111,'��Ź��',10);
insert into makeprodtbl values(222,'�����',5);
insert into makeprodtbl values(333,'��Ʈ��',10);
select * from makeprodtbl;
insert into saveprodtbl values(111,'��Ź��',50);
insert into saveprodtbl values(222,'�����',10);
insert into saveprodtbl values(333,'��Ʈ��',30);
select * from saveprodtbl;

SET serveroutput ON;


-- saveprodtbl�� ���� ��ǰ���� ������ amount update
-- saveprodtbl�� ���� ��ǰ���� ������ ��ü�� insert

create or replace trigger trg_03
BEFORE
INSERT 
on makeprodtbl
for each row
declare --NEW���̺��� ���� �޾ƿ���
    ncode int;
    nprodname varchar(30);
    namount int;
begin
    
    ncode:=:NEW.code;
    nprodname:=:NEW.prodname;
    namount:=:NEW.amount;
    
    --Ŀ�� ����
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
                return;   -- Ʈ���� ����
            end if;
        end loop;
        
        insert into saveprodtbl values(ncode,nprodname,namount);
        
        close Cur_01;
    end; --Ŀ�� ��
    
end;

drop trigger trg_03;



select * from makeprodtbl;
select * from saveprodtbl;

insert into makeprodtbl values(444,'�޴���',10);
insert into makeprodtbl values(666,'��Ź��',30);








 

