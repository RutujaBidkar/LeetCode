use practical 
select *from A
create table x (id int, Name varchar);
insert into x  values (11, 9);
select *from X


create table Y (id int, name varchar);
insert into Y values (8,8);
Select *from Y

SELECT DISTINCT name FROM X;
SELECT DISTINCT name FROM Y;
select name from X union select name from Y
select name from X UNION All select name from Y
select name from X Intersect Select name from Y
select name from x Except select name from Y





SELECT *
FROM X 
INNER JOIN Y
ON X.name = Y.name ;


select *from X RIGHT JOIN Y
ON X.name = Y.name;


SELECT *
FROM X
LEFT JOIN Y
ON X.name = Y.name;


SELECT *
FROM X
FULL OUTER JOIN Y
ON X.name = Y.name;

SELECT *
FROM X
CROSS JOIN Y;