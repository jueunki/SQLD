

insert into tmp values(1,'aaa');
insert into tmp values(2,'bbb');
select * from tmp;

create sequence tmp_seq start with 3
increment by 1
maxvalue 1000
cycle
nocache;

select * from user_sequences;
insert into tmp values(tmp_seq.NEXRVAL,'ccc');
insert into tmp values(tmp_seq.NEXRVAL,'ddd');
insert into tmp values(tmp_seq.NEXRVAL,'eee');
insert into tmp values(tmp_seq.NEXRVAL,'eee');
insert into tmp values(tmp_seq.NEXRVAL,'eee');

select * from tmp;