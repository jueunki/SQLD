--------------------------
-- 프로시저 : PL/SQL을 통해 만들어진다
--------------------------
--코드를 불러와서 쓰기 불편하기때문에 함수와 비슷한 형태로 프로시저라는 경량화된 함수를 사용할수있다
--함수보다 성능이 좋은 경량화된 함수이다.
--절차지향함수가 포함되어있다 


------------------------
--프로시저 기본
------------------------
create or replace procedure proc01 -->있으면 이걸로하고 없으면 지정을하겠다는 의미
is     -->여기부터 변수지정하는부분
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------';
begin
    DBMS_OUTPUT.PUT_LINE(msg1);
    DBMS_OUTPUT.PUT_LINE(msg2);   -->여기까지 프로시저를 만드는 작업이고
end; 

select * from USER_PROCEDURES;--프로시저 조회 

exec proc01; --여기까지가 프로시저 실행하는 작업이다.

-----------------------
--프로시저 + if
-----------------------
create or replace procedure PROC_02
is --변수선언
    score int:=90;
    result varchar(45);
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------'; 
begin --절차분법 시작
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
end; --절차문법 끝

exec PROC_02;

---------------------
---매개변수 추가
---------------------
create or replace procedure PROC_03(s in int)    --IN 매개변수 out 리턴값
is --변수선언
    score int:=s;
    result varchar(45);
    msg1 varchar(100) :='TEST START!!!------';
    msg2 varchar(100) :='TEST END!!!------'; 
begin --절차분법 시작
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
end; --절차문법 끝

exec PROC_03(80);
exec PROC_03(70);


------------------------
-- 프로시저 + 반복문
------------------------
create or replace procedure PROC_04
(
    s in int, -->매개변수
    e in int  -->매개변수
)
is
    i int :=s;
   --내부변수
begin
    while(i<=e)
    Loop
        DBMS_OUTPUT.PUT_LINE(i);
       i:=i+1;
      end Loop;
end;

exec PROC_04(5,10); -->5포함 5부터 10까지의 수를 출력한다
exec PROC_04(9,15); -->9 " 9 " 15 " " " 

---강사님 제출문제--
-- PROC_05 생성합니다
-- 하나의 값을 인자(N)로 받아 1부터 N까지의 합을 출력하세요
-- 실행 exec PROC_05(8)했을때 1부터 8까지의 합이 출력되어야합니다.
-- table을 하나 생성해서 1부터 N까지의 합을 저장합니다
-- create table result_tbl
-- (
--    startVal int,
--    endVal int,
--    Result int
-- );
-- exec PROC_05(8)을 입력했을때 startVal에는 1 endVal에는 8Result에는 1부터 8 까지의 합이 저장 그리고 합출력
create table result_tbl
(
    startVal int,
    endVal int,
    ResultVsl int
);

create or replace procedure PROC_05
(
   s in int, --시작값
   e in int  --끝값
)
is 
        --내부변수
    i int:=s; --시작값을 받아옴
    sum1 int :=0; -->초기값을 0으로 지정한다.
begin 
    while(i<=e)
    Loop
        sum1:=sum1+i; -->누적시키는 작업
            i:=i+1; -->i값을 증가시키는 작업
        end Loop; -->반복끝!        
        insert into result_tbl values(s,e,sum1);
        DBMS_OUTPUT.PUT_LINE(s||'부터 '||e||'의 합 : '||sum1);
end;

select * from result_tbl;
exec PROC_05(10,20);
select * from result_tbl;
exec PROC_05(55,110);
select * from result_tbl;
--------------------------------
-- 반환값을 가지는 프로시저
--------------------------------
create or replace procedure PROC_06
(
   s in int, --시작값 in은 들어오는값이다
   e in int,  --끝값
   r out int --리턴값 -->out이 리턴하는거!
)
is 
        --내부변수
    i int:=s; --시작값을 받아옴
    sum1 int :=0; -->초기값을 0으로 지정한다.
begin 
    while(i<=e)
    Loop
        sum1:=sum1+i; -->누적시키는 작업
            i:=i+1; -->i값을 증가시키는 작업
        end Loop; -->반복끝!        
        insert into result_tbl values(s,e,sum1);
        DBMS_OUTPUT.PUT_LINE(s||'부터 '||e||'의 합 : '||sum1);
        r:=sum1;
end;
declare
    val int;
begin
    proc_06(10,20,val); -->proc_06을 실행하면서 10,20을 매개변수로 전달하고 나오는 리턴값을 val에 저장하겠다는뜻.
    DBMS_OUTPUT.PUT_LINE('val : '||val); -->그 결과를 출력하는 부분.
end;
-----------------------
--예외처리
-----------------------
create or replace procedure PROC_07
(
    num int, -->나누어지는 수
    div int  -->나누는 수
)
is
begin
    DBMS_OUTPUT.PUT_LINE(num/div); -->나누는 결과물을 출력한다
    EXCEPTION
        WHEN ZERO_DIVIDE then --ZERO_DIVIDE는 예외코드이다
    DBMS_OUTPUT.PUT_LINE('산술오류 발생!'); -->밑에 보고 값을 넣었을때 산술오류발생한다고 문구띄우는 작업
        
end;

exec proc_07(10,4);
exec proc_07(10,0); -->이건 다른값을 일부러 넣어서 오류가 뜰때 산술오류발생한다고 문구가 나오게끔 적어놓은 숫자
--참조
--https://m.blog.naver.com/PostView.naver?is

---------------------
--모든예외에 대한 처리하는방법
---------------------
create or replace procedure PROC_07
(
    num int, -->나누어지는 수
    div int  -->나누는 수
)
is
begin
    DBMS_OUTPUT.PUT_LINE(num/div); -->나누는 결과물을 출력한다
    -- -- ---
    EXCEPTION
        WHEN OTHERS then --ZERO_DIVIDE는 예외코드이다
        DBMS_OUTPUT.PUT_LINE('산술오류 발생!');
        
end;








