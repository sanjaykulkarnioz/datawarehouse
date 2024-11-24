--use the YYYYMMDD for unambiguous date determination 
--in SQL Server as below
--insert into table1(approvaldate) values('20120618 10:34:09 AM');
/*      [course_id_sk], 
      ,[course_nbr_nk]
      ,[course_name]
      ,[course_desc]
      ,[WAREHOUSE_CURRENT_FLAG]
      ,[WAREHOUSE_HASH_ROW]
      ,[WAREHOUSE_PREVIOUS_HASH_ROW]
      ,[WAREHOUSE_CHANGE_DESCRIPTION]
      ,[WAREHOUSE_LOAD_DATE]
      ,[WAREHOUSE_VALID_FROM_TIMESTAMP]
      ,[WAREHOUSE_VALID_TO_TIMESTAMP]
      ,[WAREHOUSE_RECORD_SOURCE]
*/
INSERT INTO [Student_Course_Dept].[dbo].[dim_course]
  VALUES (1, 1, 'course1', 'course1', 'N', NULL, NULL, NULL,
  GETDATE(), '20140101 10:34:09 AM', '20140720 02:34:09 PM', 'OLTP');

INSERT INTO [Student_Course_Dept].[dbo].[dim_course]
  VALUES (2, 2, 'course2', 'course2', 'Y', NULL, NULL, NULL,
  GETDATE(), '20141116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

INSERT INTO [Student_Course_Dept].[dbo].[dim_course]
  VALUES (3, 3, 'course3', 'course3', 'Y', NULL, NULL, NULL,
  GETDATE(), '20141116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

INSERT INTO [Student_Course_Dept].[dbo].[dim_course]
  VALUES (4, 1, 'course12', 'course12', 'N', NULL, NULL, NULL,
  GETDATE(), '20140721 10:34:09 AM', '20151115 02:34:09 PM', 'OLTP');

INSERT INTO [Student_Course_Dept].[dbo].[dim_course]
  VALUES (5, 1, 'course13', 'course13', 'Y', NULL, NULL, NULL,
  GETDATE(), '20151116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

---------------
insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (1, 1, 'dept1', 'dept1', 'N', NULL, NULL, NULL,
  GETDATE(), '20141116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (2, 2, 'dept2', 'dept2', 'Y', NULL, NULL, NULL,
  GETDATE(), '20140101 10:34:09 AM', '20140720 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (3, 3, 'dept3', 'dept3', 'Y', NULL, NULL, NULL,
  GETDATE(), '20151116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (4, 4, 'dept4', 'dept4', 'Y', NULL, NULL, NULL,
  GETDATE(), '20151116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (5, 5, 'dept5', 'dept5', 'Y', NULL, NULL, NULL,
  GETDATE(), '20151116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_dept]
      values (6, 2, 'dept21', 'dept21', 'Y', NULL, NULL, NULL,
  GETDATE(), '20140721 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

-----------
insert into [Student_Course_Dept].[dbo].[dim_facility] 
      values (1, 1, 'facility1', 'facility1', 'N', NULL, NULL, NULL,
  GETDATE(), '20141116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_facility] 
values (2, 1, 'facility2', 'facility2', 'N', NULL, NULL, NULL,
  GETDATE(), '20141116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_facility] 
values (3, 1, 'facility3', 'facility3', 'N', NULL, NULL, NULL,
  GETDATE(), '20140101 10:34:09 AM', '20140720 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_facility] 
values (4, 2, 'facility31', 'facility31', 'N', NULL, NULL, NULL,
  GETDATE(), '20140721 10:34:09 AM', '20151115 02:34:09 PM', 'OLTP');

insert into [Student_Course_Dept].[dbo].[dim_facility] 
values (5, 3, 'facility32', 'facility32', 'N', NULL, NULL, NULL,
  GETDATE(), '20151116 10:34:09 AM', '29991231 02:34:09 PM', 'OLTP');

--------------
insert into  [Student_Course_Dept].[dbo].[dim_time] 
([time_id_sk]
      ,[time_date]
      ,[time_month]
      ,[time_year]) 
select [date_key], [full_date], month, year FROM
[Student_Course_Dept].[dbo].[Date_Dimension];



