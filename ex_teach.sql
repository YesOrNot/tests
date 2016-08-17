prompt PL/SQL Developer import file
prompt Created on 3 Август 2016 г. by mstanislav
set feedback off
set define off
prompt Loading TEACH...
insert into TEACH (id, fio)
values (5, 'tc5');
insert into TEACH (id, fio)
values (1, 'tc1');
insert into TEACH (id, fio)
values (2, 'tc2');
insert into TEACH (id, fio)
values (3, 'tc3');
insert into TEACH (id, fio)
values (4, 'tc4');
commit;
prompt 5 records loaded
set feedback on
set define on
prompt Done.
