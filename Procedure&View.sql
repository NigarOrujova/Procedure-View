create database ClassProcedure
go
use ClassProcedure
go
create table Employees(
[Id] int identity primary key,
[Name] nvarchar(100),
[Surname] nvarchar(100),
[FatherName] nvarchar(100),
[Salary] decimal(18,2),
[PositionId] int
)

create table Position(
[Id] int identity primary key,
[Name] nvarchar(100)
)

create table Branch(
[Id] int identity primary key,
[Name] nvarchar(100)
)

create table Product(
[Id] int identity primary key,
[Name] nvarchar(100),
[SalePrice] decimal(18,2),
[Price] decimal(18,2)
)

create table Sale(
[Id] int identity primary key,
[ProductId] int,
[EmployeeId] int,
[BranchId] int,
[SaleDate] datetime
)

ALTER TABLE dbo.Sale WITH NOCHECK
  ADD FOREIGN KEY ([EmployeeId]) REFERENCES dbo.Employees (Id)
GO

ALTER TABLE dbo.Sale WITH NOCHECK
  ADD FOREIGN KEY ([ProductId]) REFERENCES dbo.Product (Id)
GO

ALTER TABLE dbo.Sale WITH NOCHECK
  ADD FOREIGN KEY ([ProductId]) REFERENCES dbo.Product (Id)
GO

ALTER TABLE dbo.Sale WITH NOCHECK
  ADD FOREIGN KEY (BranchId) REFERENCES dbo.Branch (Id)
GO


--  1  --
Create view product10
as
select e.Name as Adi,e.Surname as Soyadi,p.Name as productunAdi,b.Name,p.SalePrice,p.Price from Sale s
join Product p on s.ProductId=p.Id
join Employees e on s.EmployeeId=e.Id
join Branch b on s.BranchId=b.Id

Create Procedure Product11
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select e.Name as Adi,e.Surname as Soyadi,p.Name as productunAdi,b.Name,p.SalePrice,p.Price from Sale s
join Product p on s.ProductId=p.Id
join Employees e on s.EmployeeId=e.Id
join Branch b on s.BranchId=b.Id
end
go



-- 2 --
Create view showProduct
as
select sum(SalePrice) from dbo.Product p
join Sale s on s.ProductId=p.Id


Create procedure dbo.selectProduct
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select sum(SalePrice) from dbo.Product p
join Sale s on s.ProductId=p.Id
end
go

exec dbo.selectProduct 


--  3  --
create view Product2
as
select SUM(SalePrice) SalePrice  from Product p
join Sale s
on s.ProductId=p.Id
where DATEDIFF(MONTH,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
go


create procedure dbo.Product3
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select SUM(SalePrice) SalePrice  from Product p
join Sale s
on s.ProductId=p.Id
where DATEDIFF(MONTH,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
end
go


--  4  --
create view dbo.product4
as
select count(p.SalePrice) SalePrice from Sale s
join Employees e
on s.EmployeeId=e.Id 
join Product p
on s.ProductId=p.Id
group by e.Id

Create procedure dbo.Product5
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select count(p.SalePrice) SalePrice from Sale s
join Employees e
on s.EmployeeId=e.Id 
join Product p
on s.ProductId=p.Id
group by e.Id
end
go

exec dbo.Product5


--  5  --
Create view dbo.product6
as
select top 1 COUNT(s.ProductId) as eded,b.Name from Sale s
join Branch b
on s.BranchId=b.Id
where DATEDIFF(DAY,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
group by b.Name
order by eded desc


Create procedure dbo.Product7
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select top 1 COUNT(s.ProductId) as eded,b.Name from Sale s
join Branch b
on s.BranchId=b.Id
where DATEDIFF(DAY,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
group by b.Name
order by eded desc
end
go


--  6  --
create view productview
as
select top 1 COUNT(ProductId) as eded,p.Name from Product p
join Sale s on s.ProductId=p.Id
where DATEDIFF(DAY,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
group by p.Name 
order by eded desc

Create procedure dbo.ProductProcedure
as 
begin
	
		set xact_abort on;
		SET NOCOUNT ON;

select top 1 COUNT(ProductId) as eded,p.Name from Product p
join Sale s on s.ProductId=p.Id
where DATEDIFF(DAY,GETDATE(),SaleDate)=0 AND
DATEDIFF(year,GETDATE(),SaleDate)=0
group by p.Name 
order by eded desc
end
go
