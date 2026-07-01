create table A ( id int, name varchar);
insert into A values ( 7, 2);
Select *from A 

create table B (id int, name varchar);
insert into B values(6,3);
select *from B

select distinct id from A

select id from A union  select id from B
select id from A union all select  id from B

select name from A union All select name from B
