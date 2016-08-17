-----------
-- задачи
-- взято с https://www.work.ua/
--------------------------------------------------------------------------------------------------------------------

--Есть 4 таблицы:

--студенты
create table stud(
id integer not null primary key,
fio varchar2(50) not null unique);

--преподаватели
create table teach(
id integer not null primary key,
fio varchar2(50) not null unique);

--лекции
create table lect(
stud integer not null references stud(id),
teach integer not null references teach(id),
subj varchar2(20) not null, -- изучаемый предмет
lectdate timestamp not null, -- начало лекции
lectdur integer not null, -- длительность лекции в минутах
room varchar2(20) not null); -- аудитория

--Если есть запись в этой таблице - значит студент был на лекции. 
--Если хотя бы один студент был на лекции, лекция была. 
--Все студенты из одной группы.


--Для продвинутого уровня:
--Таблица лабиринт
create table maze(
room1 varchar2(20) not null,
room2 varchar2(20) not null);

--если в таблице есть запись, значит между комнатой1 и комнатой2 есть проход.

/*
Все вопросы предполагают написание SQL запросов.
1. Отобрать студентов, посетивших ровно 5 уроков математики
2. Отобрать студентов, посетивших ровно 5 уроков математики 
и при этом всегда посещавших лекции только одного (любого) преподавателя
3. Найти лекции, которые по ошибке начинаются в одно время в одной и той же аудитории 
или у одного и того же преподавателя
4. Найти лекции, которые по ошибке пересекаются по времени в одной и той же аудитории 
или у одного и того же преподавателя
5. Вывести "журнал". Колонки: имя студента, "математика", "физика", "программирование", "экономика", "всего", 
"всего за посл. месяц". Строки - количество посещенных лекций соответствующего предмета или месяца.
6. Вывести "журнал пропусков". Колонки: имя студента, "математика", "физика", "программирование", "экономика", 
"всего", "всего за посл. месяц". Строки - количество пропущеных лекций.
7. Продвинутый уровень. Найти кратчайший путь в лабиринте из комнаты1 в комнату2, которые передаются как параметры
 запроса. НЕ PL/SQL! Один запрос на SQL.
*/


--------------------------------------------------------------------------------------------------------------------
-- решение
--------------------------------------------------------------------------------------------------------------------

--add date_from date_to
--
--select cast(lc.lectdate as date) d_from, cast(lc.lectdate+NUMTODSINTERVAL(lc.lectdur, 'MINUTE') as date) d_to,lc.subj,lc.teach,lc.room
--from lect lc
--group by cast(lc.lectdate as date), cast(lc.lectdate+NUMTODSINTERVAL(lc.lectdur, 'MINUTE') as date), lc.subj, lc.teach, lc.room;

alter table lect add d_from  date as (cast(lectdate as date));
alter table lect add d_to date GENERATED ALWAYS as ( cast(lectdate+NUMTODSINTERVAL(lectdur, 'MINUTE') as date)) VIRTUAL;
  
select d_from, d_to,lc.subj,lc.teach,lc.room, lc.stud
from lect lc
order by d_from, d_to, lc.subj, lc.teach, lc.room, lc.stud;

/*   	D_FROM	D_TO	SUBJ	TEACH	ROOM	STUD
1	03.07.2016 9:45:00	03.07.2016 10:30:00	математика	4	r4	4
2	03.07.2016 9:45:00	03.07.2016 10:30:00	физика	4	r6	5
3	03.08.2016 9:45:00	03.08.2016 10:30:00	математика	1	r1	1
4	03.08.2016 9:45:00	03.08.2016 10:30:00	математика	2	r1	2
5	03.08.2016 9:45:00	03.08.2016 10:30:00	математика	4	r4	4
6	03.08.2016 9:45:00	03.08.2016 10:30:00	математика	4	r4	4
7	03.08.2016 9:45:00	03.08.2016 10:30:00	математика	4	r6	5
8	03.08.2016 10:30:01	03.08.2016 11:15:01	физика	2	r2	2
9	03.08.2016 11:15:02	03.08.2016 12:00:02	программирование	3	r3	3
10	03.08.2016 12:00:03	03.08.2016 12:45:03	экономика	3	r3	1
11	03.08.2016 12:00:03	03.08.2016 12:45:03	экономика	3	r3	2
12	03.08.2016 12:00:03	03.08.2016 12:45:03	экономика	3	r3	3
13	04.08.2016 9:45:00	04.08.2016 10:30:00	математика	1	r1	1
14	04.08.2016 9:45:00	04.08.2016 10:30:00	математика	4	r5	5
15	05.08.2016 9:45:00	05.08.2016 10:30:00	математика	1	r1	1
16	05.08.2016 9:45:00	05.08.2016 10:30:00	математика	3	r1	2
17	05.08.2016 9:45:00	05.08.2016 10:30:00	математика	4	r4	4
18	05.08.2016 9:45:00	05.08.2016 10:30:00	математика	4	r5	5
19	06.08.2016 9:45:00	06.08.2016 10:30:00	математика	1	r1	1
20	06.08.2016 9:45:00	06.08.2016 10:30:00	математика	2	r1	2
21	06.08.2016 9:45:00	06.08.2016 10:30:00	математика	4	r4	4
22	06.08.2016 9:45:00	06.08.2016 10:30:00	математика	4	r5	5
23	07.08.2016 9:45:00	07.08.2016 10:30:00	математика	1	r1	1
24	07.08.2016 9:45:00	07.08.2016 10:30:00	математика	3	r1	2
25	07.08.2016 9:45:00	07.08.2016 10:30:00	математика	4	r4	4
26	07.08.2016 9:45:00	07.08.2016 10:30:00	математика	4	r5	5
27	08.08.2016 9:45:00	08.08.2016 10:30:00	математика	2	r1	2
28	10.08.2016 9:45:00	10.08.2016 10:30:00	математика	1	r10	3
29	10.08.2016 9:45:00	10.08.2016 10:30:00	физика	2	r10	3
30	11.08.2016 9:45:00	11.08.2016 10:30:00	математика	1	r10	3
31	11.08.2016 9:45:00	11.08.2016 10:30:00	физика	1	r10	3
32	12.08.2016 9:45:00	12.08.2016 10:30:00	математика	1	r11	3
33	12.08.2016 10:29:58	12.08.2016 11:14:58	математика	2	r11	3
34	12.08.2016 10:30:01	12.08.2016 11:15:01	математика	3	r11	3
35	13.08.2016 9:45:00	13.08.2016 10:30:00	математика	1	r21	3
36	13.08.2016 10:29:58	13.08.2016 11:14:58	математика	1	r31	3
37	13.08.2016 10:30:01	13.08.2016 11:15:01	математика	1	r41	3
38	03.09.2016 9:45:00	03.09.2016 10:30:00	математика	4	r4	4
39	03.09.2016 9:45:00	03.09.2016 10:30:00	физика	4	r6	5
*/
--1. Отобрать студентов, посетивших ровно 5 уроков математики
  select lc.stud, st.fio
  from ( select distinct lc.stud, d_from, d_to, lc.subj from lect lc) lc
  join stud st on st.id = lc.stud
  where subj ='математика'
  group by lc.stud, st.fio
  having count(subj)= 5;

/*   	
STUD	FIO
1	5	st5
2	1	st1
3	2	st2
*/

--2. Отобрать студентов, посетивших ровно 5 уроков математики 
--и при этом всегда посещавших лекции только одного (любого) преподавателя
  select lc.stud, st.fio
  from ( select distinct lc.stud, d_from, d_to, lc.subj, teach from lect lc)  lc
  join stud st on st.id = lc.stud
  where subj ='математика'
  group by stud, teach, st.fio
  having count(subj)= 5;

/*   	
STUD	FIO
1	5	st5
2	1	st1
*/

--3. Найти лекции, которые по ошибке начинаются в одно время в одной и той же аудитории 
--или у одного и того же преподавателя
  select d_from--, lc.room, null teach --, null as fio, 'той же аудитории' as type
  from ( select distinct d_from, lc.subj, lc.room from lect lc ) lc
  group by d_from,lc.room
  having count(*)>1
  union 
  select d_from--, null room,  lc.teach --,(select fio from teach tc where tc.id =lc.teach) as fio,'у того же преподавателя' as type
  from ( select distinct d_from, lc.subj,lc.teach from lect lc ) lc
  group by d_from, lc.teach
  having count(*)>1;

--4. Найти лекции, которые по ошибке пересекаются по времени в одной и той же аудитории 
--или у одного и того же преподавателя
select     
      lc1.d_from d_from1, lc1.d_to d_to1,  
      lc2.d_from d_from2, lc2.d_to d_to2,
      lc1.subj,lc2.subj  
      --,null t1,null t2,lc1.room r1,lc2.room r2, 'той же аудитории' type
from (select rownum as rn, lc.* from (select distinct d_from, d_to,lc.subj,lc.room from lect lc) lc) lc1
join (select rownum as rn, lc.* from (select distinct d_from, d_to,lc.subj,lc.room from lect lc) lc) lc2 
  on  lc1.room =lc2.room and lc1.subj=lc2.subj
where (lc1.d_from,lc1.d_to) overlaps (lc2.d_from,lc2.d_to)
  and lc2.rn > lc1.rn 
union 
select
      lc1.d_from d_from1, lc1.d_to d_to1,  
      lc2.d_from d_from2, lc2.d_to d_to2,
      lc1.subj,lc2.subj
      --,lc1.teach t1, lc2.teach t2,null r1, null r2, 'того же преподавателя' type
from (select rownum as rn, lc.* from (select distinct d_from, d_to,lc.subj,lc.teach from lect lc) lc) lc1
join (select rownum as rn, lc.* from (select distinct d_from, d_to,lc.subj,lc.teach from lect lc) lc) lc2 
  on lc1.teach =lc2.teach and  lc1.subj=lc2.subj
where (lc1.d_from,lc1.d_to) overlaps (lc2.d_from,lc2.d_to)
  and lc2.rn > lc1.rn;
/*
   	D_FROM1	D_TO1	D_FROM2	D_TO2	SUBJ	SUBJ
1	12.08.2016 9:45:00	12.08.2016 10:30:00	12.08.2016 10:29:58	12.08.2016 11:14:58	математика	математика
2	12.08.2016 10:30:01	12.08.2016 11:15:01	12.08.2016 10:29:58	12.08.2016 11:14:58	математика	математика
3	13.08.2016 10:29:58	13.08.2016 11:14:58	13.08.2016 9:45:00	13.08.2016 10:30:00	математика	математика
4	13.08.2016 10:30:01	13.08.2016 11:15:01	13.08.2016 10:29:58	13.08.2016 11:14:58	математика	математика
*/
  
--5. Вывести "журнал". Колонки: имя студента, "математика", "физика", "программирование", "экономика", "всего", 
--"всего за посл. месяц". Строки - количество посещенных лекций соответствующего предмета или месяца.
select 
  st.fio "имя студента",
  sum(decode(lc.subj,'математика',1)) "математика",
  sum(decode(lc.subj,'физика',1)) "физика",
  sum(decode(lc.subj,'программирование',1)) "программирование",
  sum(decode(lc.subj,'экономика',1)) "экономика",    
  sum(1) "всего",
  max(lcm.sum_cur_m)  "всего за посл. месяц"
from lect lc
join stud st on st.id = lc.stud
left join(
  select lc.stud, trunc(lc.d_from,'MM'), count(lc.subj) sum_cur_m ,  RANK() OVER (ORDER BY trunc(lc.d_from,'MM') desc) rn
  from lect lc 
  group by lc.stud, trunc(lc.d_from,'MM')
) lcm on lc.stud = lcm.stud and lcm.rn = 1
group by st.fio
order by st.fio
;
/*   	
  имя студента	математика	физика	программирование	экономика	всего	всего за посл. месяц
1	st1	5			1	6	
2	st2	5	1		1	7	
3	st3	8	2	1	1	12	
4	st4	7				7	1
5	st5	5	2			7	1
*/

--6. Вывести "журнал пропусков". Колонки: имя студента, "математика", "физика", "программирование", "экономика", 
--"всего", "всего за посл. месяц". Строки - количество пропущеных лекций.
with lcw as(
  select distinct lc.d_from, lc.subj, st.fio from lect lc
  cross join stud st
  minus
  select distinct lc.d_from, lc.subj, st.fio from lect lc
  join stud st on lc.stud = st.id
  )
select 
  lc.fio "имя студента",
  sum(decode(lc.subj,'математика',1)) "математика",
  sum(decode(lc.subj,'физика',1)) "физика",
  sum(decode(lc.subj,'программирование',1)) "программирование",
  sum(decode(lc.subj,'экономика',1)) "экономика",    
  sum(1) "всего",
  max(lcm.sum_cur_m)  "всего за посл. месяц"
from lcw  lc
left join(
  select lc.fio, trunc(lc.d_from,'MM'), count(lc.subj) sum_cur_m ,  RANK() OVER (ORDER BY trunc(lc.d_from,'MM') desc) rn
  from lcw lc 
  group by  lc.fio, trunc(lc.d_from,'MM')
) lcm on lc.fio = lcm.fio and lcm.rn = 1
group by lc.fio
order by lc.fio;
/*   	
  имя студента	математика	физика	программирование	экономика	всего	всего за посл. месяц
1	st1	11	5	1		17	2
2	st2	11	4	1		16	2
3	st3	8	3			11	2
4	st4	10	5	1	1	17	1
5	st5	11	3	1	1	16	1
*/

---------------------------

--7. Продвинутый уровень. Найти кратчайший путь в лабиринте из комнаты1 в комнату2, которые передаются как параметры
-- запроса. НЕ PL/SQL! Один запрос на SQL.

--  лабиринт
--  1--2--3
--  |  |  |
--  |  |  4
--  |  |  |
--  7--6--5

insert into MAZE (room1, room2) values ('2', '3');
insert into MAZE (room1, room2) values ('1', '2');
insert into MAZE (room1, room2) values ('2', '6');
insert into MAZE (room1, room2) values ('3', '4');
insert into MAZE (room1, room2) values ('4', '5');
insert into MAZE (room1, room2) values ('5', '6');
insert into MAZE (room1, room2) values ('6', '7');
insert into MAZE (room1, room2) values ('7', '1');
commit;

select path from
(
  select t.*, RANK() OVER (ORDER BY t.lv) rn from
  (
    select 
      level lv, --LPAD(' ', 2*level-1) || room1 || '->' || room2 link , 
      SYS_CONNECT_BY_PATH(room1, '/') || '/' || &room2 path, room2
    from --maze 
    (
      select room1, room2  from maze 
      union 
      select room2, room1 from maze  
    )
    start with room1=&room1
    connect by nocycle prior  room2=room1
  )t
    where room2=&room2
)min_path where rn= 1;
--room1=7 room2=2
/*   	
  PATH
1	/2/1/7
2	/2/6/7
*/
