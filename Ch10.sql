-- 커서 : 특정한 행 하나를 지정(포인터)한다. 
--커서가 놓여진 상태에서 해당행의 유저나 내용들을 차례대로 불러올 수 있다
--순서 : 커서선언-> 커서열기-> 패치(불러오기)-> 커서닫기
select * from usertbl;

declare
    userid usertbl.userid%TYPE;
    birthyear usertbl.birthyear%TYPE;
    cursor CUR_01
    IS
    select userid, birthyear 
    from 
    usertbl; -->userid, birthyear를 유저테이블로부터 받아옴

begin
open CUR_01; -->커서를 열어주는 작업
Loop
    Fetch CUR_01 into userid,birthyear; -->커서에서 데이터를 가져오는작업
    exit when CUR_01 %NOTFOUND; --커서가 없을경우 종료가된다
    DBMS_OUTPUT.PUT_LINE(userid||' '||birthyear);
end Loop;
CLOSE CUR_01; -->커서닫기
end;


--02 커서 + if문
declare
    userid usertbl.userid%TYPE;
    birthyear usertbl.birthyear%TYPE;
    cursor CUR_01
    IS
    select 
    userid, birthyear 
    from 
    usertbl; -->userid, birthyear를 유저테이블로부터 받아옴

begin
open CUR_01; -->커서를 열어주는 작업
Loop
    Fetch CUR_01 into userid,birthyear; -->커서에서 데이터를 가져오는작업
    exit when CUR_01 %NOTFOUND; --커서가 없을경우 종료가된다
    if birthyear>=1970 then
        DBMS_OUTPUT.PUT_LINE(userid||' '||birthyear);
    end if;
end Loop;
CLOSE CUR_01; -->커서닫기
end;

-- 커서 + if + 테이블 저장
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
    usertbl; -->userid, birthyear를 유저테이블로부터 받아옴

begin
open CUR_01; -->커서를 열어주는 작업
Loop
    Fetch CUR_01 into userid,birthyear; -->커서에서 데이터를 가져오는작업
    exit when CUR_01 %NOTFOUND; --커서가 없을경우 종료가된다
    if birthyear>=1970 then
    insert into tmp2_tbl values(userid,birthyear);
    end if;
end Loop;
CLOSE CUR_01; -->커서닫기
end;

select * from tmp2_tbl;

select * from buytbl;

--강사님 문제 제출---
-- 커서를 만들어서 price*amount가 500 이하인 groupname 과 prodname을
-- tmp3_tbl에 저장하세요
-- 커서명 : CUR_02
-- tmp3_tbl의 열을 buytbl의 prodname,groupname을 테이블 복사로 처리합니다(구조만복사) 구조만 복사는 밑에 두번
select * from buytbl; -->buy테이블에있는 값들을 확인하는작업이고
create table tmp3_tbl as select prodname,groupname from buytbl where 1=2; -->1=2라는 거짓값을 적어놓으면
--prodname과 groupname에있는 구조만 가지고오니까 거짓값을 넣어주는거다!
--tmp3테이블을 만들어주는 작업이다
select * from tmp3_tbl;
desc tmp3_tbl;
declare  
    prodname buytbl.prodname%TYPE;
    groupname buytbl.groupname%TYPE;
    price buytbl.price%TYPE;
    amount buytbl.amount%TYPE; --> 여기까지가 이클립스 할 때 처럼 변수선언해주는거! int name 이런거랑 같은작업!
    cursor CUR_02
    IS
    select
    prodname, groupname, price, amount --> 함수값들을 찾을거라고 선언해주는 작업이다
    from
    buytbl;  -->buytbl에서! 
begin
open CUR_02;
Loop -->돌리면서 찾는작업을 도와주는 역할을 한다
    Fetch CUR_02 into prodname,groupname,price,amount; -->Fetch는 행의 수를 한정제한하는 역할로 부분범위처리시 사용한다. 
    exit when CUR_02 %NOTFOUND; -->CUR_02에서 더이상 찾을것이 없을때 여기서 나가겠다는 뜻!
    if price*amount <=500 then --> 선언해놓은 price와 amount에 500과 같거나 이하인값을 설정해주는 작업이다
    insert into tmp3_tbl values(prodname,groupname); -->tmp3_tbl에 prodname과 groupname의 값(values)을 끼워넣어준다(insert)는 의미이다
    end if;
  end Loop; -->if문과 Loop문에서 나가는 작업을 꼭 해준다.
CLOSE CUR_02; -->커서02도 닫아준다
end; -->종료

select * from tmp3_tbl; -->값을 출력한다.

-----
select * from tmp3_tbl;
desc tmp3_tbl;
declare  
    prodname buytbl.prodname%TYPE;
    groupname buytbl.groupname%TYPE;
    price buytbl.price%TYPE;
    amount buytbl.amount%TYPE; --> 여기까지가 이클립스 할 때 처럼 변수선언해주는거! int name 이런거랑 같은작업!
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


