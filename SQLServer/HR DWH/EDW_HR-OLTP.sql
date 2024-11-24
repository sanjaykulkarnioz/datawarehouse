-- Script generated by DB Designer for iPad
-- 2022 Jun 12 - 11:42 

-- MS SQL Syntax


IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'HR_OLTP')
BEGIN
  EXEC( 'CREATE SCHEMA HR_OLTP' );
END

CREATE TABLE [HR_OLTP].[Emp](
    [Emp_Nbr] int identity (1,1) NOT NULL,
    [Emp_Name] varchar(100) NOT NULL,
    [Dept_Nbr] int NULL,

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

CREATE TABLE [HR_OLTP].[Table_3](

)

ALTER TABLE [HR_OLTP].[Emp]
  ADD CONSTRAINT FK1_Dept$Dept_Nbr$_$Emp$Dept_Nbr FOREIGN KEY ([Dept_Nbr])
    REFERENCES [HR_OLTP].[Dept] ([Dept_Nbr])
