/*
In my dimensional model, I have a attendance fact table associated with a date dimension table which holds the working days attendance but would like to introduce a mechanism to capture special events like public holidays and ad-hoc  holidays as well as join the fact with the leave calendars and create a report of the attendance along with their overtime schedules and other attendance. Can you put the five realistic records creation in SQL Server script format?
To create a SQL Server script for capturing attendance records, including special events like public holidays and ad-hoc holidays, and joining with leave calendars, you'll need to set up the necessary tables and insert sample records. Below, I'll provide a script that creates and populates five realistic records for your scenario. 
Please note that this script assumes you have already created the necessary tables for the date dimension, attendance fact table, special events, and leave calendars. If you haven't created these tables yet, you'll need to define their structures first.
Here's a sample script:
*/

/*
1. **Dimension Tables:**
   - These tables will contain attributes related to dimensions such as date and employee.
   - There should be a dimension bridge table to associate multiple dates with special events and leave calendar entries.

   **Date Dimension:**

*/

USE [Test_Dim_Model];

   CREATE TABLE DateDimension (
       DateID INT PRIMARY KEY,
       Date DATE,
       DayOfWeek VARCHAR(10),
       Month VARCHAR(20),
       Year INT
   );


--   **Employee Dimension:**

   
   CREATE TABLE EmployeeDimension (
       EmployeeID INT PRIMARY KEY,
       EmployeeName VARCHAR(100),
       Department VARCHAR(50),
       -- Other employee attributes
   );
   

   --**Special Events Dimension:**

   CREATE TABLE SpecialEventsDimension (
       EventID INT PRIMARY KEY,
       EventDate DATE,
       EventDescription VARCHAR(100)
   );
   

   --**Leave Calendar Dimension:**

   CREATE TABLE LeaveCalendarDimension (
       LeaveID INT PRIMARY KEY,
       EmployeeID INT,
       LeaveDate DATE,
       LeaveType VARCHAR(50),
       CONSTRAINT FK_Employee FOREIGN KEY (EmployeeID) REFERENCES EmployeeDimension(EmployeeID)
   );

/*
  2. **Fact Table (AttendanceFact):**
   - This table will serve as the central fact table in your data model, containing measures related to attendance, such as `HoursWorked` and `OvertimeHours`.
   - It will include foreign keys to link to the dimension tables for date and employee.
   - No direct relationship with special events or leave calendar tables.


*/

   CREATE TABLE FactAttendance (
       FactAttendanceID INT PRIMARY KEY,
       DateID INT,
       EmployeeID INT,
       HoursWorked DECIMAL(5, 2),
       OvertimeHours DECIMAL(5, 2)--,
       CONSTRAINT FK_Date_001 FOREIGN KEY (DateID) REFERENCES DateDimension(DateID),
       CONSTRAINT FK_Employee_001 FOREIGN KEY (EmployeeID) REFERENCES EmployeeDimension(EmployeeID)
   );
 
--4. **Bridge Tables:**
   -- Bridge tables are used to associate fact records with multiple dimension records.
   -- You will have two bridge tables, one for special events and one for leave calendar entries.

   --**Special Events Bridge:**
  
   CREATE TABLE SpecialEventsBridge (
       FactAttendanceID INT,
       EventID INT,
       CONSTRAINT FK_FactAttendance FOREIGN KEY (FactAttendanceID) REFERENCES FactAttendance(FactAttendanceID),
       CONSTRAINT FK_SpecialEvent FOREIGN KEY (EventID) REFERENCES SpecialEventsDimension(EventID)
   );

--   **Leave Calendar Bridge:**

CREATE TABLE LeaveCalendarBridge (
       FactAttendanceID INT,
       LeaveID INT,
       CONSTRAINT FK_FactAttendance_001 FOREIGN KEY (FactAttendanceID) REFERENCES FactAttendance(FactAttendanceID),
       CONSTRAINT FK_LeaveCalendar_001 FOREIGN KEY (LeaveID) REFERENCES LeaveCalendarDimension(LeaveID)
   );

/*
4. **Referential Integrity:**
   - The referential integrity constraints ensure that foreign key relationships are maintained between the fact and dimension tables.
   - The foreign keys in the fact table (`FactAttendance`) reference the primary keys in the dimension tables (`DateDimension` and `EmployeeDimension`).
   - The bridge tables (`SpecialEventsBridge` and `LeaveCalendarBridge`) connect the fact table with the respective dimension bridge tables (`SpecialEventsDimension` and `LeaveCalendarDimension`).

By structuring the data model this way, you can efficiently capture attendance records, special events, and leave calendar entries while maintaining referential integrity. This design allows for flexible reporting and analysis of attendance data along with special events and leave details.
Can you create 10 sample realistic records in SQL Server script for all the above facts, dimensions and bridge tables?
Certainly, I can provide you with sample records for the fact, dimension, and bridge tables in SQL Server. Here are 10 realistic sample records for each of these tables:
**Sample Records for Date Dimension (DateDimension):**
```sql
*/

INSERT INTO DateDimension (DateID, Date, DayOfWeek, Month, Year)
VALUES 
    (20230910, '2023-09-10', 'Sunday', 'September', 2023),
    (20230911, '2023-09-11', 'Monday', 'September', 2023),
    (20230912, '2023-09-12', 'Tuesday', 'September', 2023),
    (20230913, '2023-09-13', 'Wednesday', 'September', 2023),
    (20230914, '2023-09-14', 'Thursday', 'September', 2023),
    (20230915, '2023-09-15', 'Friday', 'September', 2023),
    (20230916, '2023-09-16', 'Saturday', 'September', 2023),
    (20230917, '2023-09-17', 'Sunday', 'September', 2023),
    (20230918, '2023-09-18', 'Monday', 'September', 2023),
    (20230919, '2023-09-19', 'Tuesday', 'September', 2023);


--**Sample Records for Employee Dimension (EmployeeDimension):**

INSERT INTO EmployeeDimension (EmployeeID, EmployeeName, Department)
VALUES 
    (1, 'John Smith', 'Sales'),
    (2, 'Alice Johnson', 'Marketing'),
    (3, 'Robert Davis', 'HR'),
    (4, 'Sarah Lee', 'Engineering'),
    (5, 'Michael Brown', 'Finance'),
    (6, 'Emily White', 'IT'),
    (7, 'David Wilson', 'Operations'),
    (8, 'Olivia Clark', 'Customer Support'),
    (9, 'Daniel Hall', 'Research & Development'),
    (10, 'Sophia Adams', 'Quality Assurance');

--**Sample Records for Special Events Dimension (SpecialEventsDimension):**


INSERT INTO SpecialEventsDimension (EventID, EventDate, EventDescription)
VALUES 
    (1, '2023-09-11', 'Labor Day'),
    (2, '2023-12-25', 'Christmas Day'),
    (3, '2023-07-04', 'Independence Day'),
    (4, '2023-11-24', 'Thanksgiving Day'),
    (5, '2023-05-29', 'Memorial Day'),
    (6, '2023-01-01', 'New Year''s Day'),
    (7, '2023-04-15', 'Tax Day'),
    (8, '2023-10-31', 'Halloween'),
    (9, '2023-02-14', 'Valentine''s Day'),
    (10, '2023-06-18', 'Father''s Day');


--**Sample Records for Leave Calendar Dimension (LeaveCalendarDimension):**

INSERT INTO LeaveCalendarDimension (LeaveID, EmployeeID, LeaveDate, LeaveType)
VALUES 
    (1, 1, '2023-09-13', 'Vacation'),
    (2, 2, '2023-09-12', 'Sick Leave'),
    (3, 3, '2023-09-14', 'Personal Leave'),
    (4, 4, '2023-08-05', 'Vacation'),
    (5, 5, '2023-07-20', 'Sick Leave'),
    (6, 6, '2023-10-10', 'Vacation'),
    (7, 7, '2023-11-25', 'Sick Leave'),
    (8, 8, '2023-12-20', 'Personal Leave'),
    (9, 9, '2023-06-15', 'Vacation'),
    (10, 10, '2023-03-08', 'Sick Leave');


--**Sample Records for Fact Attendance (FactAttendance):**
-- Assuming you have a sequence or identity column for FactAttendanceID

INSERT INTO FactAttendance (FactAttendanceID, DateID, EmployeeID, HoursWorked, OvertimeHours)
VALUES 
    (1, 20230910, 1, 8, 2),
    (2, 20230911, 2, 7, 1),
    (3, 20230912, 3, 8, 3),
    (4, 20230913, 4, 7.5, 1.5),
    (5, 20230914, 5, 8, 2),
    (6, 20230915, 6, 7, 1),
    (7, 20230916, 7, 8, 2.5),
    (8, 20230917, 8, 7.5, 1),
    (9, 20230918, 9, 8.5, 2),
    (10, 20230919, 10, 7.5, 1.5);


--To list the hours worked and overtime hours metrics associated with each employee using the provided tables, you can use a SQL query that performs a JOIN between the `FactAttendance` table and the `EmployeeDimension` table. Here's a SQL query to achieve this:

SELECT
    E.EmployeeName,
    SUM(FA.HoursWorked) AS TotalHoursWorked,
    SUM(FA.OvertimeHours) AS TotalOvertimeHours
FROM
    EmployeeDimension AS E
INNER JOIN
    FactAttendance AS FA
ON
    E.EmployeeID = FA.EmployeeID
GROUP BY
    E.EmployeeName
ORDER BY
    E.EmployeeName;

/*
In this query:

- We start by selecting the `EmployeeName` from the `EmployeeDimension` table.
- We then calculate the total hours worked and total overtime hours for each employee using the `SUM` function.
- We join the `EmployeeDimension` table with the `FactAttendance` table using the `EmployeeID` as the common key.
- We group the results by `EmployeeName` to aggregate the metrics for each employee.
- Finally, we order the results by `EmployeeName`.

--This query will give you a list of employees along with their total hours worked and total overtime hours.


--**Sample Records for Special Events Bridge (SpecialEventsBridge):**
*/

INSERT INTO SpecialEventsBridge (FactAttendanceID, EventID)
VALUES
    (1, 1),
    (4, 2),
    (7, 3),
    (10, 4),
    (2, 5),
    (5, 6),
    (8, 7),
    (3, 8),
    (6, 9),
    (9, 10);

--**Sample Records for Leave Calendar Bridge (LeaveCalendarBridge):**


INSERT INTO LeaveCalendarBridge (FactAttendanceID, LeaveID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);

--These sample records should help you populate your dimensional 
--model with realistic data for testing and analysis purposes. 
--Please adjust the column names, data types, and additional 
--attributes as needed to match your specific schema.

-- Create sample records for Date Dimension table

/* iGNORE: --ADDITIONAL RECORDS
INSERT INTO DateDimension (Date, DayOfWeek, Month, Year)
VALUES 
    ('2023-09-10', 'Sunday', 'September', 2023),
    ('2023-09-11', 'Monday', 'September', 2023),
    ('2023-09-12', 'Tuesday', 'September', 2023),
    ('2023-09-13', 'Wednesday', 'September', 2023),
    ('2023-09-14', 'Thursday', 'September', 2023);

-- Create sample records for Special Events table (e.g., public holidays)
INSERT INTO SpecialEvents (EventDate, EventDescription)
VALUES 
    ('2023-09-11', 'Labor Day'),
    ('2023-12-25', 'Christmas Day');

-- Create sample records for Leave Calendar table
INSERT INTO LeaveCalendar (EmployeeID, LeaveDate, LeaveType)
VALUES 
    (1, '2023-09-13', 'Vacation'),
    (2, '2023-09-12', 'Sick Leave'),
    (3, '2023-09-14', 'Personal Leave');

-- Create sample records for Attendance Fact table
INSERT INTO AttendanceFact (DateID, EmployeeID, HoursWorked, OvertimeHours)
VALUES 
    (1, 1, 8, 2),
    (2, 2, 7, 1),
    (3, 3, 8, 3),
    (4, 1, 7.5, 1.5),
    (5, 2, 8, 2);
*/

/*
In this script:

1. Sample records are inserted into the `DateDimension` table, representing various dates and their attributes.
2. Sample records for special events (e.g., public holidays) are inserted into the `SpecialEvents` table.
3. Sample records for leave calendar entries are inserted into the `LeaveCalendar` table. Each record includes an `EmployeeID`, `LeaveDate`, and `LeaveType`.
4. Sample attendance records are inserted into the `AttendanceFact` table, linking to the date dimension and including `EmployeeID`, `HoursWorked`, and `OvertimeHours`.

Please adjust the table and column names as per your actual database schema. This script provides a basic structure for your scenario, and you can expand it with more records and additional columns as needed.

How would the above tables when transformed into dimensional data model with facts, dimensions and bridges look like? How will they be related? What would be the referential integrity associated with these tables?

Transforming the tables into a dimensional data model involves organizing the data into facts, dimensions, and bridges, as well as establishing relationships and ensuring referential integrity. Let's structure the tables accordingly:
*/

--To list the hours worked and overtime hours metrics associated with each employee using the provided tables, you can use a SQL query that performs a JOIN between the `FactAttendance` table and the `EmployeeDimension` table. Here's a SQL query to achieve this:


SELECT
    E.EmployeeName,
    SUM(FA.HoursWorked) AS TotalHoursWorked,
    SUM(FA.OvertimeHours) AS TotalOvertimeHours
FROM
    EmployeeDimension AS E
INNER JOIN
    FactAttendance AS FA
ON
    E.EmployeeID = FA.EmployeeID
GROUP BY
    E.EmployeeName
ORDER BY
    E.EmployeeName;

/*

In this query:

- We start by selecting the `EmployeeName` from the `EmployeeDimension` table.
- We then calculate the total hours worked and total overtime hours for each employee using the `SUM` function.
- We join the `EmployeeDimension` table with the `FactAttendance` table using the `EmployeeID` as the common key.
- We group the results by `EmployeeName` to aggregate the metrics for each employee.
- Finally, we order the results by `EmployeeName`.

This query will give you a list of employees along with their total hours worked and total overtime hours.

*/