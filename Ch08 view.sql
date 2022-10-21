--View : 조회하기위한 용도로 사용하면되며 값을넣기위해 사용하는건 별로다

create or replace view view_01  -->as를쓰면서 가상테이블을 만드는것
as
select userid,name,mobile1||mobile2 as phone from usertbl;


select * from view_01; 
select * from USER_VIEWS; -->유저가 만든것을 보겠다는 뜻

--view + join
create or replace view view_02 -->이걸 마지막에 써줌
as
select U.userid,addr,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid;

select * from view_02;




