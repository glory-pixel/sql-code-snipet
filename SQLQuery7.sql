--CONSTRAINTS 
--UNIQUE CONSTRAINTS

ALTER TABLE tblEmployee
ADD CONSTRAINT  UnqGovernmentID UNIQUE (EmployeeGovernmentID);

SELECT EmployeeGovernmentID, COUNT (EmployeeGovernmentID) as Mycount from tblEmployee
GROUP BY EmployeeGovernmentID
having count (EmployeeGovernmentID) >1

select * from tblEmployee where EmployeeGovernmentID IN ('HN513777D', 'TX593671R')
GO

--Default constraints 
alter table tblTransaction
add DateOfEntry datetime

alter table tblTransaction
add constraint defDateOfEntry DEFAULT GETDATE() for DateOfEntry;

delete from tblTransaction where EmployeeNumber < 3

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values (1, '2014-01-01', 1)
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values (2, '2014-01-02', 1, '2013-01-01')

SELECT *  from tblTransaction where EmployeeNumber < 3

GO






create table tblTransaction2
(Amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
DateOfEntry datetime null constraint tblTransaction2_defDateOfEntry DEFAULT GETDATE())

INSERT INTO tblTransaction2 (Amount, DateOfTransaction, EmployeeNumber)
VALUES  (1, '2014-01-01', 1)
INSERT INTO tblTransaction2 (Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
VALUES (2, '2014-01-02', 1, '2013-01-01')

select * from tblTransaction2 where EmployeeNumber < 3

drop table tblTransaction2


alter table tblTransaction2
drop column DateOfEntry

alter table tblTransaction2
drop constraint defDateOfEntry

--CHECK CONSTRAINTS

alter table tblTransaction
add constraint chkAmount check (Amount>-1000 and Amount < 1000)

insert into tblTransaction
values (101, '2014-01-01', 1)

alter table tblEmployee with nocheck
add constraint chkMiddleName check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName or EmployeeMiddleName is null)

alter table tblEmployee
drop constraint chkMiddleName

begin tran
  insert into tblEmployee
  values (2003, 'A', 'NULL', 'C', 'D', '2014-01-01', 'Accounts')
  select * from tblEmployee where EmployeeNumber = 2003
rollback tran

alter table tblEmployee with nocheck
add constraint chkDateOfBirth check (DateOfBirth between '1900-01-01' and getdate())

begin tran
  insert into tblEmployee
  values (2003, 'A', 'B', 'C', 'D', '2115-01-01', 'Accounts')
select * from tblEmployee where EmployeeNumber = 2003
rollback tran

create table tblEmployee2
(EmployeeMiddleName varchar(50) null, constraint CK_EmployeeMiddleName check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName or EmployeeMiddleName is null))
drop table tblEmployee2

alter table tblEmployee
drop chkDateOfBirth
alter table tblEmployee
drop chkMiddleName
alter table tblTransaction
drop chkAmount



--Primary Key – In Practice

alter table tblEmployee
add constraint PK_tblEmployee PRIMARY KEY (EmployeeNumber)


 
insert into tblEmployee (EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
values (2004, 'FistName', 'MiddleName', 'LastName', 'AB12345FI', '2014-01-01', 'Accounts')

delete from tblEmployee
where EmployeeNumber = 2004

alter table tblEmployee 
drop constraint PK_tblEmployee

create table tblEmployee2
(EmployeeNumber int CONSTRAINT PK_tblEmployee2 PRIMARY KEY IDENTITY (1,1),
EmployeeName nvarchar(20))

insert into tblEmployee2
values ('My Name'),
('My Name')

select * from tblEmployee2


create table tblEmployee3
(EmployeeNumber int CONSTRAINT PK_tblEmployee3 PRIMARY KEY IDENTITY(1,1),
EmployeeName nvarchar(20))
insert into tblEmployee3
values ('My Name'),
('My Name')

select * from tblEmployee3

delete from tblEmployee3

truncate table tblEmployee2

insert into tblEmployee3(EmployeeNumber, EmployeeName)
values (3, 'My Name'), (4, 'My Name')

SET IDENTITY_INSERT tblEmployee3 ON

insert into tblEmployee3(EmployeeNumber, EmployeeName)
values (38, 'My Name'), (39, 'My Name')

SET IDENTITY_INSERT tblEmployee3 OFF

drop table tblEmployee3

select @@IDENTITY
select SCOPE_IDENTITY()

select IDENT_CURRENT('dbo.tblEmployee3')


--Creating views
select 1
go
create view ViewByDepartment as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber
go


create view ViewSummary as 
select D.Department, T.EmployeeNumber as EmpNum, sum(T.Amount) as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.Department, T.EmployeeNumber
--order by D.Department, T.EmployeeNumber
go
select * from ViewByDepartment
select * from ViewSummary


--Altering and dropping views
USE [70-461]
GO

--if exists(select * from sys.views where name = 'ViewByDepartment')
if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department

left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber

GO
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber

GO
