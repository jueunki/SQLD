--------------------------
-- ���ν��� : PL/SQL�� ���� ���������
--------------------------
--�ڵ带 �ҷ��ͼ� ���� �����ϱ⶧���� �Լ��� ����� ���·� ���ν������ �淮ȭ�� �Լ��� ����Ҽ��ִ�
--�Լ����� ������ ���� �淮ȭ�� �Լ��̴�.
--���������Լ��� ���ԵǾ��ִ� 


------------------------
--���ν��� �⺻
------------------------
create or replace procedure proc01 -->������ �̰ɷ��ϰ� ������ �������ϰڴٴ� �ǹ�
is     -->������� ���������ϴºκ�
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------';
begin
    DBMS_OUTPUT.PUT_LINE(msg1);
    DBMS_OUTPUT.PUT_LINE(msg2);   -->������� ���ν����� ����� �۾��̰�
end; 

select * from USER_PROCEDURES;--���ν��� ��ȸ 

exec proc01; --��������� ���ν��� �����ϴ� �۾��̴�.

-----------------------
--���ν��� + if
-----------------------
create or replace procedure PROC_02
is --��������
    score int:=90;
    result varchar(45);
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------'; 
begin --�����й� ����
    DBMS_OUTPUT.PUT_LINE(msg1);
    if(score>=90) then
        result:='A';
    elsif(score>=80) then
        result:='B';
    elsif(score>=70) then
        result:='C';
    elsif(score>=60) then
        result:='D';
    else
        result:='F';
    end if;
    DBMS_OUTPUT.PUT_LINE(result);
    DBMS_OUTPUT.PUT_LINE(msg2);
end; --�������� ��

exec PROC_02;

---------------------
---�Ű����� �߰�
---------------------
create or replace procedure PROC_03(s in int)    --IN �Ű����� out ���ϰ�
is --��������
    score int:=s;
    result varchar(45);
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------'; 
begin --�����й� ����
    DBMS_OUTPUT.PUT_LINE(msg1);
    if(score>=90) then
        result:='A';
    elsif(score>=80) then
        result:='B';
    elsif(score>=70) then
        result:='C';
    elsif(score>=60) then
        result:='D';
    else
        result:='F';
    end if;
    DBMS_OUTPUT.PUT_LINE(result);
    DBMS_OUTPUT.PUT_LINE(msg2);
end; --�������� ��

exec PROC_03(80);
exec PROC_03(70);


------------------------
-- ���ν��� + �ݺ���
------------------------
create or replace procedure PROC_04
(
    s in int, -->�Ű�����
    e in int  -->�Ű�����
)
is
    i int :=s;
   --���κ���
begin
    while(i<=e)
    Loop
        DBMS_OUTPUT.PUT_LINE(i);
       i:=i+1;
      end Loop;
end;

exec PROC_04(5,10); -->5���� 5���� 10������ ���� ����Ѵ�
exec PROC_04(9,15); -->9 " 9 " 15 " " " 

---����� ���⹮��--
-- PROC_05 �����մϴ�
-- �ϳ��� ���� ����(N)�� �޾� 1���� N������ ���� ����ϼ���
-- ���� exec PROC_05(8)������ 1���� 8������ ���� ��µǾ���մϴ�.
-- table�� �ϳ� �����ؼ� 1���� N������ ���� �����մϴ�
-- create table result_tbl
-- (
--    startVal int,
--    endVal int,
--    Result int
-- );
-- exec PROC_05(8)�� �Է������� startVal���� 1 endVal���� 8Result���� 1���� 8 ������ ���� ���� �׸��� �����
create table result_tbl
(
    startVal int,
    endVal int,
    ResultVsl int
);

create or replace procedure PROC_05
(
   s in int, --���۰�
   e in int  --����
)
is 
        --���κ���
    i int:=s; --���۰��� �޾ƿ�
    sum1 int :=0; -->�ʱⰪ�� 0���� �����Ѵ�.
begin 
    while(i<=e)
    Loop
        sum1:=sum1+i; -->������Ű�� �۾�
            i:=i+1; -->i���� ������Ű�� �۾�
        end Loop; -->�ݺ���!        
        insert into result_tbl values(s,e,sum1);
        DBMS_OUTPUT.PUT_LINE(s||'���� '||e||'�� �� : '||sum1);
end;

select * from result_tbl;
exec PROC_05(10,20);
select * from result_tbl;
exec PROC_05(55,110);
select * from result_tbl;
--------------------------------
-- ��ȯ���� ������ ���ν���
--------------------------------
create or replace procedure PROC_06
(
   s in int, --���۰� in�� �����°��̴�
   e in int,  --����
   r out int --���ϰ� -->out�� �����ϴ°�!
)
is 
        --���κ���
    i int:=s; --���۰��� �޾ƿ�
    sum1 int :=0; -->�ʱⰪ�� 0���� �����Ѵ�.
begin 
    while(i<=e)
    Loop
        sum1:=sum1+i; -->������Ű�� �۾�
            i:=i+1; -->i���� ������Ű�� �۾�
        end Loop; -->�ݺ���!        
        insert into result_tbl values(s,e,sum1);
        DBMS_OUTPUT.PUT_LINE(s||'���� '||e||'�� �� : '||sum1);
        r:=sum1;
end;
declare
    val int;
begin
    proc_06(10,20,val); -->proc_06�� �����ϸ鼭 10,20�� �Ű������� �����ϰ� ������ ���ϰ��� val�� �����ϰڴٴ¶�.
    DBMS_OUTPUT.PUT_LINE('val : '||val); -->�� ����� ����ϴ� �κ�.
end;
-----------------------
--����ó��
-----------------------
create or replace procedure PROC_07
(
    num int, -->���������� ��
    div int  -->������ ��
)
is
begin
    DBMS_OUTPUT.PUT_LINE(num/div); -->������ ������� ����Ѵ�
    EXCEPTION
        WHEN ZERO_DIVIDE then --ZERO_DIVIDE�� �����ڵ��̴�
    DBMS_OUTPUT.PUT_LINE('������� �߻�!'); -->�ؿ� ���� ���� �־����� ��������߻��Ѵٰ� �������� �۾�
        
end;

exec proc_07(10,4);
exec proc_07(10,0); -->�̰� �ٸ����� �Ϻη� �־ ������ �㶧 ��������߻��Ѵٰ� ������ �����Բ� ������� ����
--����
--https://m.blog.naver.com/PostView.naver?is

---------------------
--��翹�ܿ� ���� ó���ϴ¹��
---------------------
create or replace procedure PROC_07
(
    num int, -->���������� ��
    div int  -->������ ��
)
is
begin
    DBMS_OUTPUT.PUT_LINE(num/div); -->������ ������� ����Ѵ�
    -- -- ---
    EXCEPTION
        WHEN OTHERS then --ZERO_DIVIDE�� �����ڵ��̴�
        DBMS_OUTPUT.PUT_LINE('������� �߻�!');
        
end;








