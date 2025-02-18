-- Script generated by DB Designer for iPad
-- 2022 Jun 12 - 14:56 

-- MS SQL Syntax


IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'HR_OLTP')
BEGIN
  EXEC( 'CREATE SCHEMA HR_OLTP' );
END

CREATE TABLE [HR_OLTP].[Emp](
    [Emp_Nbr] int identity (1,1) NOT NULL,
    [Emp_Fname] varchar(50) NOT NULL,
    [Emp_Lname] varchar(50) NOT NULL,
    [Dept_Nbr] int NULL,
    [Job_Nbr] int NULL,
    [Mgr_Nbr] int NULL,
    [Salary] int NULL,

  CONSTRAINT PK_Emp PRIMARY KEY (Emp_Nbr)
)

ALTER TABLE [HR_OLTP].[Emp]
  ADD CONSTRAINT DF_Emp$Emp_Nbr DEFAULT (-1)
    FOR [Emp_Nbr]

CREATE TABLE [HR_OLTP].[Dept](
    [Dept_Nbr] int identity (1,1) NOT NULL,
    [Dept_Name] varchar(50) NOT NULL,

  CONSTRAINT PK_Dept PRIMARY KEY (Dept_Nbr)
)

ALTER TABLE [HR_OLTP].[Dept]
  ADD CONSTRAINT DF_Dept$Dept_Nbr DEFAULT (-1)
    FOR [Dept_Nbr]

CREATE TABLE [HR_OLTP].[Job](
    [Job_Nbr] int identity (1,1) NOT NULL,
    [Job_Title] varchar(50) NOT NULL,
    [Min_Sal] int NULL,
    [Max_Sal] int NULL,

  CONSTRAINT PK_Job PRIMARY KEY (Job_Nbr)
)

ALTER TABLE [HR_OLTP].[Job]
  ADD CONSTRAINT DF_Job$Job_Nbr DEFAULT (-1)
    FOR [Job_Nbr]

ALTER TABLE [HR_OLTP].[Job]
  ADD CONSTRAINT UQ_Job$Job_Title UNIQUE (Job_Title)

ALTER TABLE [HR_OLTP].[Job]
  ADD CONSTRAINT DF_Job$Min_Sal DEFAULT (0)
    FOR [Min_Sal]

ALTER TABLE [HR_OLTP].[Job]
  ADD CONSTRAINT DF_Job$Max_Sal DEFAULT (0)
    FOR [Max_Sal]

CREATE TABLE [HR_OLTP].[Job_Hist](
    [Emp_Nbr] int NOT NULL,
    [Job_Nbr] int NOT NULL,
    [Dept_Nbr] int NULL,
    [Start_Date] date NULL,
    [End_Date] date NULL,

  CONSTRAINT PK_Job_Hist PRIMARY KEY (Job_Nbr)
)

ALTER TABLE [HR_OLTP].[Job_Hist]
  ADD CONSTRAINT DF_Job_Hist$End_Date DEFAULT (2999-12-31)
    FOR [End_Date]

ALTER TABLE [HR_OLTP].[Emp]
  ADD CONSTRAINT FK1_Dept$Dept_Nbr$_$Emp$Dept_Nbr FOREIGN KEY ([Dept_Nbr])
    REFERENCES [HR_OLTP].[Dept] ([Dept_Nbr])

ALTER TABLE [HR_OLTP].[Emp]
  ADD CONSTRAINT FK2_Job$Job_Nbr$_$Emp$Job_Nbr FOREIGN KEY ([Job_Nbr])
    REFERENCES [HR_OLTP].[Job] ([Job_Nbr])

ALTER TABLE [HR_OLTP].[Job_Hist]
  ADD CONSTRAINT FK1_Emp$Emp_Nbr$_$Job_Hist$Emp_Nbr FOREIGN KEY ([Emp_Nbr])
    REFERENCES [HR_OLTP].[Emp] ([Emp_Nbr])

ALTER TABLE [HR_OLTP].[Job_Hist]
  ADD CONSTRAINT FK2_Job$Job_Nbr$_$Job_Hist$Job_Nbr FOREIGN KEY ([Job_Nbr])
    REFERENCES [HR_OLTP].[Job] ([Job_Nbr])

ALTER TABLE [HR_OLTP].[Job_Hist]
  ADD CONSTRAINT FK3_Dept$Dept_Nbr$_$Job_Hist$Dept_Nbr FOREIGN KEY ([Dept_Nbr])
    REFERENCES [HR_OLTP].[Dept] ([Dept_Nbr])

----

--MySQL sample database -? 

--Video for the MERGE-INSERT-UPDATE sql:


https://www.youtube.com/watch?v=50NBCorAXS4


CREATE DATABASE `MERGE_POC` DEFAULT CHARACTER SET utf8mb4;


USE `MERGE_POC`;


-- 

-- Table structure for table `source` 

--


DROP TABLE IF EXISTS `source`;


CREATE TABLE `source` ( 

`Id` int, 

??`EmpName` char(100), 

??`EmpAddress` char(100), 

??`Location` char(100), 

??`Salary` int 

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 

/*!40101 SET character_set_client = @saved_cs_client */;


-- 

-- Dumping data for table `source` 

-- 

-- ORDER BY:??`ID`


set autocommit=0;


INSERT INTO `source` VALUES (101,?Ramu','Hyderabad','AP?,8500); 

INSERT INTO `source` VALUES (102,'Srinu','Chennai','TN?,344); 

INSERT INTO `source` VALUES (103,'Gopi','Bangalore','KN',233);


select * from source;



DROP TABLE IF EXISTS `destination`;


CREATE TABLE `destination` ( 

`EmpId` int, 

??`EmpName` char(100), 

??`EmpAddress` char(100), 

??`Location` char(100), 

??`Salary` int, 

?`StartDate` DATETIME, 

`EndDate` DATETIME, 

`Active_indicator` char(10), 

`InsertedDateTime` DATETIME, 

`UpdatedDateTime`??DATETIME, 

`Action` char(100) 

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 

/*!40101 SET character_set_client = @saved_cs_client */;


-- 

-- Dumping data for table `destination` 

-- 

-- ORDER BY:??`EmpId`


INSERT INTO destination 

( EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action) 

SELECT 

??EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action 

FROM 

??( 

MERGE INTO destination Dst 

USING source src 

ON (Src.Id = Dst.EmpId) AND Dst.Active_indicator = ?Y?? 

WHEN MATCHED AND 

Dst.EmpName <> Src.EmpName OR 

Dst.EmpAddress <> Src.EmpAddress OR 

Dst.Location <> Src.Location OR 

Dst.Salary <> Src.Salary AND 

Dst.Active_indicator = ?Y? 

THEN UPDATE 

SET Dst.ENDDATE = GETDATE() - 1, 

Dst.Active_indicator =?N?, 

WHEN NOT MATCHED BY TARGET THEN 

INSERT 

( EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action) 

VALUES 

( 

Src.Id, 

Src.EmpName, 

Src.EmpAddress, 

Src.Location, 

Src.Salary, 

GETDATE(), 

?12/31/9999?, 

?Y?, 

GETDATE(), 

NULL, 

?INSERT? 

) 

OUTPUT $action, 

Src.Id, 

Src.EmpName, 

Src.EmpAddress, 

Src.Location, 

Src.Salary, 

GETDATE(), 

?12/31/9999?, 

?Y?, 

GETDATE(), 

NULL 

) 

AS CHANGES 

( 

ACTION, 

EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??ENDDATE, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime 

) 

WHERE??ACTION = ?UPDATE?;



/* AFTER RUNNING THE ABOVE CODE, YOU WILL SEE THAT THERE WILL BE 3 RECORDS INSERTED INTO DESTINATION TABLE */


/* BELOW CODE WILL CHECK IF UPDATES ARE MADE */


UPDATE Source 

SET EmpName = ?Ramu Krishna?, 

EmpAddress = ?Bangalore? 

WHERE Id in (102, 103);


TRUNCATE TABLE source; 

TRUNCATE TABLE destination;


INSERT INTO destination 

( EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action) 

SELECT 

??EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action 

FROM 

??( 

MERGE INTO destination Dst 

USING source src 

ON (Src.Id = Dst.EmpId) AND Dst.Active_indicator = ?Y?? 

WHEN MATCHED AND 

Dst.EmpName <> Src.EmpName OR 

Dst.EmpAddress <> Src.EmpAddress OR 

Dst.Location <> Src.Location OR 

Dst.Salary <> Src.Salary AND 

Dst.Active_indicator = ?Y? 

THEN UPDATE 

SET Dst.ENDDATE = GETDATE() - 1, 

Dst.Active_indicator =?N?, 

WHEN NOT MATCHED BY TARGET THEN 

INSERT 

( EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??EndDate, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime, 

??Action) 

VALUES 

( 

Src.Id, 

Src.EmpName, 

Src.EmpAddress, 

Src.Location, 

Src.Salary, 

GETDATE(), 

?12/31/9999?, 

?Y?, 

GETDATE(), 

NULL, 

?INSERT? 

) 

OUTPUT $action, 

Src.Id, 

Src.EmpName, 

Src.EmpAddress, 

Src.Location, 

Src.Salary, 

GETDATE(), 

?12/31/9999?, 

?Y?, 

GETDATE(), 

NULL 

) 

AS CHANGES 

( 

ACTION, 

EmpId, 

??EmpName, 

??EmpAddress, 

??Location, 

??Salary, 

??StartDate, 

??ENDDATE, 

??Active_indicator, 

??InsertedDateTime, 

??UpdatedDateTime 

) 

WHERE??ACTION = ?UPDATE?;


