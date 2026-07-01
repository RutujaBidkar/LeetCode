use practical 
create table XY (id int, name varchar );
insert into XY values( 6, 2);
select *from XY;

create table YZ (id int , name varchar);
insert into YZ values( 6, 2);
select *from YZ

create table XZ (id int, name varchar);
insert into XZ values(7, 4);
select *from XZ

SELECT 
XY.id,
XY.name AS T1_value,
YZ.name AS T2_value,
XZ.name AS T3_value
FROM XY
INNER JOIN YZ
ON XY.id = YZ.id
INNER JOIN XZ
ON YZ.id = XZ.id;

SELECT 
XY.name,
YZ.name,
XZ.name
FROM XY
INNER JOIN YZ ON XY.name = YZ.name
INNER JOIN XZ ON XY.name = XZ.name;

SELECT 
XY.name AS T1_name,
YZ.name AS T2_name,
XZ.name AS T3_name
FROM XY
LEFT JOIN YZ
ON XY.name = YZ.name
LEFT JOIN XZ
ON XY.name = XZ.name;


SELECT 
XY.name AS T1_name,
YZ.name AS T2_name,
XZ.name AS T3_name
FROM XY
RIGHT JOIN YZ
ON XY.name = YZ.name
RIGHT JOIN XZ
ON YZ.name = XZ.name;

SELECT 
COALESCE(XY.name,YZ.name,XZ.name) AS Name,
XY.name AS T1_name,
YZ.name AS T2_name,
XZ.name AS T3_name
FROM XY
FULL OUTER JOIN YZ
ON XY.name = YZ.name
FULL OUTER JOIN XZ
ON COALESCE(XY.name,YZ.name) = XZ.name;

SELECT 
XY.name AS T1_name,
YZ.name AS T2_name,
XZ.name AS T3_name
FROM XY
CROSS JOIN YZ
CROSS JOIN XZ;