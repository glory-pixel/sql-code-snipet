CREATE TABLE [dbo].[tblEmployee](
	[EmployeeNumber] [int] NOT NULL,
	[EmployeeFirstname] [varchar](50) NOT NULL,
	[EmployeeMiddleName] [varchar](50) NULL,
	[Employeelastname] [varchar](50) NOT NULL,
	[EmployeeGovernmentID] [char](10) NULL,
	[DateofBirth] [date] NOT NULL
) 
GO

ALTER TABLE tblEmployee
ADD Department VARCHAR(50);

INSERT INTO tblEmployee
VALUES ( 132, 'Dylan',	'A',	'Word',	'WK580890I',	'19940913',	'customer relations')
GO

SELECT * FROM tblEmployee
WHERE [Employeelastname] LIKE '[%]%'
GO


SELECT * FROM tblEmployee
WHERE not(EmployeeNumber >= 200 and EmployeeNumber <= 209)
GO


SELECT * FROM tblEmployee 
WHERE DateofBirth between '19760101' and   '19861231'

go

SELECT YEAR (DateofBirth) AS Yearofdateofbirth, count(*) as Numberborn
FROM tblEmployee
WHERE 1=1
GROUP BY YEAR (DateofBirth)
ORDER BY YEAR (DateofBirth)
GO

SELECT * FROM tblEmployee 
WHERE YEAR (DateofBirth)  = 1971
GO


--GETTING THRE FIRST LETTER OF EMPLOYEELASTNAME
SELECT left (EmployeelastName, 1) as initial, COUNT (*) as countofinitial
FROM tblEmployee
GROUP BY  left (EmployeelastName,1)
ORDER BY  count (*) desc --left (EmployeelastName, 2)
go


-- getting yhe top 5 rows

SELECT TOP (5) left (EmployeelastName, 1) as initial, COUNT (*) as countofinitial
FROM tblEmployee
GROUP BY  left (EmployeelastName,1)
ORDER BY  count (*) desc --left (EmployeelastName, 2)
GO

--getting countofinitial fro 50 and above 

SELECT left (EmployeelastName, 1) as initial, COUNT (*) as countofinitial
FROM tblEmployee
GROUP BY  left (EmployeelastName,1)
HAVING COUNT (*) >= 50
ORDER BY  count (*) desc --left (EmployeelastName, 2)
GO

--UPDATING EMPTY SPACE WITH NULL

Update tblEmployee
Set EmployeeMiddleName = NULL
Where EmployeeMiddleName = ''
SELECT (EmployeeMiddleName) from tblEmployee
GO

--getting the month of the date

SELECT DATENAME(month, DateofBirth) AS monthname, COUNT (*) AS numberemployee,
COUNT (EmployeeMiddleName ) as numberofmiddlenames,
COUNT (*) -COUNT (EmployeeMiddleName ) AS Nomiddlename,
FORMAT (MIN (DateofBirth),'dd-MM-yyyy') AS earliestdateofbirth,
FORMAT (MAX (DateofBirth), 'D') AS latestdateofbirth
FROM tblEmployee
GROUP BY DATENAME(month,DateofBirth) , DATEPART(month,DateofBirth) 
ORDER BY DATEPART(month,DateofBirth) 