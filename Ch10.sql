-- Ŀ�� : Ư���� �� �ϳ��� ����(������)�Ѵ�. 
--Ŀ���� ������ ���¿��� �ش����� ������ ������� ���ʴ�� �ҷ��� �� �ִ�
--���� : Ŀ������-> Ŀ������-> ��ġ(�ҷ�����)-> Ŀ���ݱ�
select * from usertbl;

declare
    userid usertbl.userid%TYPE;
    birthyear usertbl.birthyear%TYPE;
    cursor CUR_01
    IS
    select userid, birthyear 
    from 
    usertbl; -->userid, birthyear�� �������̺�κ��� �޾ƿ�

begin
open CUR_01; -->Ŀ���� �����ִ� �۾�
Loop
    Fetch CUR_01 into userid,birthyear; -->Ŀ������ �����͸� ���������۾�
    exit when CUR_01 %NOTFOUND; --Ŀ���� ������� ���ᰡ�ȴ�
    DBMS_OUTPUT.PUT_LINE(userid||' '||birthyear);
end Loop;
CLOSE CUR_01; -->Ŀ���ݱ�
end;


--02 Ŀ�� + if��
declare
    userid usertbl.userid%TYPE;
    birthyear usertbl.birthyear%TYPE;
    cursor CUR_01
    IS
    select 
    userid, birthyear 
    from 
    usertbl; -->userid, birthyear�� �������̺�κ��� �޾ƿ�

begin
open CUR_01; -->Ŀ���� �����ִ� �۾�
Loop
    Fetch CUR_01 into userid,birthyear; -->Ŀ������ �����͸� ���������۾�
    exit when CUR_01 %NOTFOUND; --Ŀ���� ������� ���ᰡ�ȴ�
    if birthyear>=1970 then
        DBMS_OUTPUT.PUT_LINE(userid||' '||birthyear);
    end if;
end Loop;
CLOSE CUR_01; -->Ŀ���ݱ�
end;

-- Ŀ�� + if + ���̺� ����
drop table tmp2_tbl;
create table tmp2_tbl as select userid,birthyear from usertbl where 1=2;
select * from tmp2_tbl;
desc tmp2_tbl;
declare
    userid usertbl.userid%TYPE;
    birthyear usertbl.birthyear%TYPE;
    cursor CUR_01
    IS
    select 
    userid, birthyear 
    from 
    usertbl; -->userid, birthyear�� �������̺�κ��� �޾ƿ�

begin
open CUR_01; -->Ŀ���� �����ִ� �۾�
Loop
    Fetch CUR_01 into userid,birthyear; -->Ŀ������ �����͸� ���������۾�
    exit when CUR_01 %NOTFOUND; --Ŀ���� ������� ���ᰡ�ȴ�
    if birthyear>=1970 then
    insert into tmp2_tbl values(userid,birthyear);
    end if;
end Loop;
CLOSE CUR_01; -->Ŀ���ݱ�
end;

select * from tmp2_tbl;

select * from buytbl;

--����� ���� ����---
-- Ŀ���� ���� price*amount�� 500 ������ groupname �� prodname��
-- tmp3_tbl�� �����ϼ���
-- Ŀ���� : CUR_02
-- tmp3_tbl�� ���� buytbl�� prodname,groupname�� ���̺� ����� ó���մϴ�(����������) ������ ����� �ؿ� �ι�
select * from buytbl; -->buy���̺��ִ� ������ Ȯ���ϴ��۾��̰�
create table tmp3_tbl as select prodname,groupname from buytbl where 1=2; -->1=2��� �������� ���������
--prodname�� groupname���ִ� ������ ��������ϱ� �������� �־��ִ°Ŵ�!
--tmp3���̺��� ������ִ� �۾��̴�
select * from tmp3_tbl;
desc tmp3_tbl;
declare  
    prodname buytbl.prodname%TYPE;
    groupname buytbl.groupname%TYPE;
    price buytbl.price%TYPE;
    amount buytbl.amount%TYPE; --> ��������� ��Ŭ���� �� �� ó�� �����������ִ°�! int name �̷��Ŷ� �����۾�!
    cursor CUR_02
    IS
    select
    prodname, groupname, price, amount --> �Լ������� ã���Ŷ�� �������ִ� �۾��̴�
    from
    buytbl;  -->buytbl����! 
begin
open CUR_02;
Loop -->�����鼭 ã���۾��� �����ִ� ������ �Ѵ�
    Fetch CUR_02 into prodname,groupname,price,amount; -->Fetch�� ���� ���� ���������ϴ� ���ҷ� �κй���ó���� ����Ѵ�. 
    exit when CUR_02 %NOTFOUND; -->CUR_02���� ���̻� ã������ ������ ���⼭ �����ڴٴ� ��!
    if price*amount <=500 then --> �����س��� price�� amount�� 500�� ���ų� �����ΰ��� �������ִ� �۾��̴�
    insert into tmp3_tbl values(prodname,groupname); -->tmp3_tbl�� prodname�� groupname�� ��(values)�� �����־��ش�(insert)�� �ǹ��̴�
    end if;
  end Loop; -->if���� Loop������ ������ �۾��� �� ���ش�.
CLOSE CUR_02; -->Ŀ��02�� �ݾ��ش�
end; -->����

select * from tmp3_tbl; -->���� ����Ѵ�.

-----
select * from tmp3_tbl;
desc tmp3_tbl;
declare  
    prodname buytbl.prodname%TYPE;
    groupname buytbl.groupname%TYPE;
    price buytbl.price%TYPE;
    amount buytbl.amount%TYPE; --> ��������� ��Ŭ���� �� �� ó�� �����������ִ°�! int name �̷��Ŷ� �����۾�!
    cursor CUR_02
is
select prodname,groupname from buytbl;

begin 
    open CUR_02;
    
    Loop
        Fetch CUR_02 into prodname,groupname;
        EXIT WHEN CUR_02 %NOTFOUND;
        if price*amount<=500 then
        
        insert into tmp3_tbl values(groupname,prodname);
        end if;
    end Loop;
    close CUR_02;
    end;
select * from tmp3_tbl;


