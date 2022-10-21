create sequence AI_seq start with 1000 increment by 1 nocycle nocache;

create table patient_tbl
(
    Patient_Code int,
    Patient_name varchar(20),
    Patient_Gender char(1)
    constraint boolean_Gender check(Patient_Gender in ('0','1')),
    Patient_Phone varchar(45),
    Patient_rrn varchar(45),
    Patient_Date varchar(45),
    constraint pk_Patient_Code primary key (Patient_Code)
);

select * from v$diag_info; 
alter session set SQL_TRACE = TRUE;
ALTER SESSION SET events '10046 trace name context forever, level 12';
alter session set SQL_TRACE = FALSE;