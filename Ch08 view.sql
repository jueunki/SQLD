--View : ��ȸ�ϱ����� �뵵�� ����ϸ�Ǹ� �����ֱ����� ����ϴ°� ���δ�

create or replace view view_01  -->as�����鼭 �������̺��� ����°�
as
select userid,name,mobile1||mobile2 as phone from usertbl;


select * from view_01; 
select * from USER_VIEWS; -->������ ������� ���ڴٴ� ��

--view + join
create or replace view view_02 -->�̰� �������� ����
as
select U.userid,addr,prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid;

select * from view_02;




