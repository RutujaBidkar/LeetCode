select *from stud

create function demoes()
returns table
as 
return 
(select ID, Name, City,MobileNumber,Age from stud);

select *from demoes()


create function Doos( @a char(1))
returns table
as return 
(
select *from stud where gender =@a 
);

select *from Doos('F')

create function doom(@a char(1))
returns table 
as return (
select *from stud where gender =@a );

select *from doom('M')

create function doora (@a int)
returns table
as return (
select *from stud where Age <=@a );

select *from doora(18);

create function doremi(@a int)
returns table
as return (
select *from stud where Age >=@a);

select *from doremi(18)


create function kittu()
returns table
as return (
select ID, MobileNumber from stud )

select *from kittu()

