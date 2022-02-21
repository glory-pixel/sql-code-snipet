SELECT  EmployeeNumber, sum(Amount) as Totalamount
FROM tblTransaction
group by EmployeeNumber
go

SELECT tblEmployee.EmployeeNumber, EmployeeFirstname, Employeelastname, sum(Amount) as totalamount
FROM tblEmployee
LEFT JOIN tblTransaction
ON tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
GROUP BY tblEmployee.EmployeeNumber, EmployeeFirstname, Employeelastname
ORDER BY EmployeeNumber
GO

SELECT * FROM tblEmployee 
WHERE EmployeeNumber = 1046

SELECT * FROM tblTransaction 
WHERE EmployeeNumber = 1046
GO

SELECT DISTINCT Department, '' as Departmenthead 
INTO tblDepartment
FROM tblEmployee

SELECT Department, count (*) as numberdept
from tblEmployee 
GROUP BY Department
ORDER BY Department
GO

ALTER table [dbo].[tblDepartment]
ALTER column Departmenthead varchar(30) null
GO

-- JOINING A THIRD TABLE 
SELECT tblDepartment.Department, Departmenthead, sum(Amount) as TotalAmount
FROM tblDepartment 
left join tblEmployee 
on  tblEmployee.Department = tblDepartment.Department
left join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
GROUP BY tblDepartment.Department, Departmenthead 
ORDER BY Department

INSERT INTO tblDepartment(Department, Departmenthead)
Values ('Accounts', 'James')
GO

SELECT  D.Departmenthead, SUM (T. Amount) as totalamount
FROM tblDepartment AS D
LEFT JOIN tblEmployee AS E
ON E.Department = D.Department
LEFT JOIN tblTransaction AS T
ON E.EmployeeNumber = T.EmployeeNumber
GROUP BY D.Departmenthead
ORDER BY D.Departmenthead
GO


SELECT E.EmployeeNumber as ENumber, E.EmployeeFirstname, E.Employeelastname, T.Employeenumber AS TNumber, sum(T.Amount) as totalamount
FROM tblEmployee as  E
LEFT JOIN tblTransaction as T
ON E.EmployeeNumber = T.EmployeeNumber
WHERE T.EmployeeNumber IS NULL
GROUP BY E.EmployeeNumber , T.EmployeeNumber, E.EmployeeFirstname, E.Employeelastname
ORDER BY E.EmployeeNumber , T.EmployeeNumber, E.EmployeeFirstname, E.Employeelastname
GO

-- using derived table
select*
FROM(
SELECT E.EmployeeNumber as ENumber, E.EmployeeFirstname, E.Employeelastname, T.Employeenumber AS TNumber, sum(T.Amount) as totalamount
FROM tblEmployee as  E
LEFT JOIN tblTransaction as T
ON E.EmployeeNumber = T.EmployeeNumber
WHERE T.EmployeeNumber IS NULL
GROUP BY E.EmployeeNumber , T.EmployeeNumber, E.EmployeeFirstname, E.Employeelastname) AS newtable
ORDER BY ENumber , TNumber, EmployeeFirstname, Employeelastname
GO

-- deleting data
begin tran
SELECT count(*) from tblTransaction
DELETE tblTransaction
FROM tblEmployee as  E
RIGHT JOIN tblTransaction as T
ON E.EmployeeNumber = T.EmployeeNumber
WHERE T.EmployeeNumber IS NULL

rollback tran

SELECT count(*) from tblTransaction
GO

--UPDATING DATA
BEGIN TRAN
--SELECT * from tblTransaction WHERE EmployeeNumber = 194
UPDATE tblTransaction
set EmployeeNumber = 194
OUTPUT INSERTED.EmployeeNumber, DELETED.EmployeeNumber
FROM tblTransaction 
WHERE EmployeeNumber IN (3, 5, 7, 9)
--SELECT * from tblTransaction WHERE EmployeeNumber = 194

ROLLBACK TRAN
