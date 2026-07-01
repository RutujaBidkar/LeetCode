create database project
create table customer (cust_id int, Name varchar(50), city Varchar(50), Product varchar(50)); 
select *from customer
insert into customer values( 101, 'shruti','chennai','laptop');
insert into customer values( 105, 'kriti','Delhi','oppo');
insert into customer values( 106, 'sonam','Gujarat','Redmi');
insert into customer values( 102, 'sakshi','Bengaluru','Desktop');
insert into customer values( 103, 'siddhi','Mumbai','Iphone');
insert into customer values( 104, 'ridda','pune','Samsung');

SELECT *
FROM customer
INNER JOIN dellivery
ON customer.cust_id = dellivery.order_id;

select *from customer left join dellivery on customer.cust_id= dellivery.order_id;

select *from customer right join dellivery on customer.cust_id = dellivery.order_id

SELECT *
FROM customer
CROSS JOIN dellivery;
