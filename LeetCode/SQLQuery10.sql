create table Inventory ( product varchar(50), stock int);
Insert into Inventory values ( 'Iphone', 100);
select *from Inventory
Insert into Inventory values ( 'Oppo', 100);

create proc sale 
@sale as int 
as 
begin
update Inventory set stock= stock -@sale 
end 
sale '5'

create proc sale1
@sale1 as int, @p as varchar(50)
As
Begin 
update Inventory set stock = stock-@sale1 where product=@p
end

Sale1 54,'Mi'
alter table Inventory add sale int
select *from Inventory
update Inventory set sale =0
update inventory set stock=100

CREATE PROCEDURE stockMarket
    @sale INT,
    @p VARCHAR(50)
AS
BEGIN
    UPDATE Inventory
    SET stock = stock - @sale
    WHERE product = @p;

    UPDATE Inventory
    SET sale = sale + @sale
    WHERE product = @p;
END;
stockMarket 20,'Mi'
stockMarket 50,'samsung'

select *from Inventory