--�ܺ��򰡹������� ���������ʽ��ϴ� �˰�Ѿ�� ��������

--------------------------
-- PL/SQL
--------------------------
SET serveroutput ON; -->�� �Լ��� ����ϸ� dbms_output.put_line �̶�� �Լ��� ����Ҽ��ִ�(���)

begin     --> �������� ���� ���� ����
dbms_output.put_line('Hello world);
end;      --> �������� ���� ���� ��


-- ���� ����
declare
    var1 int:=10; -->�ڷ��� int:=10;����
    var2 int:=20;
begin
    dbms_output.put_line(var1+var2);
    -- ���� ����!
end;

--���� �����ϰ�, �ʱⰪ�� ���̺��� ������ �ʱ�ȭ�ϴ¹��
desc usertbl;

declare 
    uid usertbl.userid%TYPE:='abc';
begin
    dbms_output.put_line(uid);
end;

-- �б⹮(IF)

declare
    score int :=80;
begin
    if score >=90 then  -->if ~ then�� ���ǽ��� ���̶�� �Ѵ�
        dbms_output.put_line('���ھ�'||score);
    elsif score >=80 then                           -->elsif�� ersid�̴� ?...���
        dbms_output.put_line('���ھ�'||score);
    elsif score >=70 then
        dbms_output.put_line('���ھ�'||score);
    else 
        dbms_output.put_line('���ھ�'||score);
    end if; -->if���ǽ��� ��
end;

-- �б⹮ + ���̺�κ��� �� ��������
desc booktbl;

declare
    var1 usertbl.userid%TYPE;
    var2 usertbl.name%TYPE;
begin
    select userid,name into var1,var2 from usertbl where userid = 'JYP';
    dbms_output.put_line('id :' ||var1||' name : ' || var2);
end;

select * from buytbl;

--

declare --����
    var1 buytbl.userid%TYPE;
    var2 buytbl.amount%TYPE;
begin  --����
    select userid,amount into var1,var2 from buytbl where userid='JYP';
    dbms_output.put_line('id :' ||var1||' amount : ' || var2);

end;

select * from buytbl;

--�ݺ���(whlie)

Declare
    i int:=1; -->�ʱⰪ�����ϰ�
begin
    while(i<=10)    -->����
    Loop
        DBMS_OUTPUT.PUT_LINE('i�� : '||i); -->�� �Բ� ���´�
        i:=i+1;
    end Loop;
end;

select * from buytbl;
-- �ݺ��� for
declare
    i int:=1;
begin
    for i in 1..10 -->1����10���� for�� �־��ְڴٴ� ��
    Loop
    DBMS_OUTPUT.PUT_LINE('i�� : '||i); -->�� �Բ� ���´�
    end Loop;
end;
--�ؿ��� �������
create table tmp1_tbl
(
    no1 int,
    no2 int,
    no3 int
)


declare
    i int := 1;
begin
    for i in 1..10
    loop
        insert into tmp1_tbl(no1) values(i);
    end loop;
end;
select * from tmp1_tbl;
delete from tmp1_tbl;

--����- tmp1_ tbl �� 4���� �����մϴ�. no1,no2,no3�� ���� 4 1 4 �ֱ�
-- tmp2_tbl �� ���� 2�ܺ��� 9�ܱ��� �����غ���

--����1
declare
    i int:=4;
    y int:=1;
begin
    for y in 1..9
    Loop
    insert into tmp1_tbl(no1,no2,no3) values (i,y,i*y);
    end Loop;
end;

select * from tmp1_tbl;

--�����Ǯ��
declare
    dan int :=4;
    i int :=1;
    val int;
begin
    for i in 1..9
    Loop
        val:=dan*i;
        insert into tmp1_tbl values(dan,i,val);
    end Loop;
end;

select * from tmp1_tbl;

--����2
delete from tmp1_tbl;
declare
    i int:=2;
    y int:=1;
begin
    for i in 2..9
    Loop
        for y in 1..9
        Loop
        insert into tmp1_tbl(no1,no2,no3) values(i,y,i*y);
        end Loop;
        end Loop;
end;

select * from tmp1_tbl;
--����� Ǯ��
declare
    dan int :=2;
    i int :=1;
    val int;
begin
    for dan in 2..9
    Loop
        for i in 1..9
        Loop
            val:=dan*i;
            insert into tmp1_tbl values(dan,i,val);
        end Loop;
    end Loop;
end;

select * from tmp1_tbl;
















