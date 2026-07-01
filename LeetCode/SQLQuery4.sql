use practical
create table tableA( name varchar);
insert  into tableA values (5);
select *from tableA

create table tableB( name varchar);
insert  into tableB values (4);
select *from tableB

select distinct name from tableA
select distinct name from tableB

select *from tableA union select *from tableB

select  *from tableA union All select *from tableB

select *from tableA intersect select *from tableB

select *from tableA Except select *from tableB

select *from tableA inner join tableB on  tableA.name=tableB.name

select *from tableA left join tableB on tableA.name= tableB.name

select  *from tableA right join tableB on tableA.name= tableB.name

select *from tableA full outer join tableB on tableA.name= tableB.name

select *from tableA cross join tableB 