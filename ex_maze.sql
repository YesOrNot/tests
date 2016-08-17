prompt PL/SQL Developer import file
prompt Created on 3 Август 2016 г. by mstanislav
set feedback off
set define off
prompt Loading MAZE...
insert into MAZE (room1, room2)
values ('2', '3');
insert into MAZE (room1, room2)
values ('1', '2');
insert into MAZE (room1, room2)
values ('2', '6');
insert into MAZE (room1, room2)
values ('3', '4');
insert into MAZE (room1, room2)
values ('4', '5');
insert into MAZE (room1, room2)
values ('5', '6');
insert into MAZE (room1, room2)
values ('6', '7');
insert into MAZE (room1, room2)
values ('7', '1');
commit;
prompt 8 records loaded
set feedback on
set define on
prompt Done.
