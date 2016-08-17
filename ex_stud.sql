prompt PL/SQL Developer import file
prompt Created on 3 Август 2016 г. by mstanislav
set feedback off
set define off
prompt Loading STUD...
insert into STUD (id, fio)
values (5, 'st5');
insert into STUD (id, fio)
values (1, 'st1');
insert into STUD (id, fio)
values (2, 'st2');
insert into STUD (id, fio)
values (3, 'st3');
insert into STUD (id, fio)
values (4, 'st4');
commit;
prompt 5 records loaded
set feedback on
set define on
prompt Done.
