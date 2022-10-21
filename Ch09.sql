--외부평가문제에는 출제되지않습니다 알고넘어가면 좋은정도

--------------------------
-- PL/SQL
--------------------------
SET serveroutput ON; -->이 함수를 사용하면 dbms_output.put_line 이라는 함수를 사용할수있다(기능)

begin     --> 절차지향 문법 적용 시작
dbms_output.put_line('Hello world);
end;      --> 절차지행 문법 적용 끝


-- 변수 선언
declare
    var1 int:=10; -->자료형 int:=10;설정
    var2 int:=20;
begin
    dbms_output.put_line(var1+var2);
    -- 문법 시작!
end;

--변수 선언하고, 초기값을 테이블의 값으로 초기화하는방법
desc usertbl;

declare 
    uid usertbl.userid%TYPE:='abc';
begin
    dbms_output.put_line(uid);
end;

-- 분기문(IF)

declare
    score int :=80;
begin
    if score >=90 then  -->if ~ then이 조건식의 끝이라고 한다
        dbms_output.put_line('스코어'||score);
    elsif score >=80 then                           -->elsif는 ersid이다 ?...라심
        dbms_output.put_line('스코어'||score);
    elsif score >=70 then
        dbms_output.put_line('스코어'||score);
    else 
        dbms_output.put_line('스코어'||score);
    end if; -->if조건식의 끝
end;

-- 분기문 + 테이블로부터 값 가져오기
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

declare --선언
    var1 buytbl.userid%TYPE;
    var2 buytbl.amount%TYPE;
begin  --적용
    select userid,amount into var1,var2 from buytbl where userid='JYP';
    dbms_output.put_line('id :' ||var1||' amount : ' || var2);

end;

select * from buytbl;

--반복문(whlie)

Declare
    i int:=1; -->초기값지정하고
begin
    while(i<=10)    -->들어가면
    Loop
        DBMS_OUTPUT.PUT_LINE('i값 : '||i); -->와 함께 나온다
        i:=i+1;
    end Loop;
end;

select * from buytbl;
-- 반복문 for
declare
    i int:=1;
begin
    for i in 1..10 -->1부터10까지 for에 넣어주겠다는 뜻
    Loop
    DBMS_OUTPUT.PUT_LINE('i값 : '||i); -->와 함께 나온다
    end Loop;
end;
--밑에서 응용시작
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

--문제- tmp1_ tbl 에 4단을 저장합니다. no1,no2,no3에 각각 4 1 4 넣기
-- tmp2_tbl 을 만들어서 2단부터 9단까지 저장해보기

--문제1
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

--강사님풀이
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

--문제2
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
--강사님 풀이
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
















