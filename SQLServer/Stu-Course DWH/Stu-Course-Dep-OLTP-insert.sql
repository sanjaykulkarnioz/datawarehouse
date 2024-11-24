--use the YYYYMMDD for unambiguous date determination 
--in SQL Server as below
--insert into table1(approvaldate) values('20120618 10:34:09 AM');

insert into [Student_Course_Dept].[dbo].[facility] 
      values (1, 'facility1', 'facility1');

insert into [Student_Course_Dept].[dbo].[facility] 
values (2, 'facility2', 'facility2');

insert into [Student_Course_Dept].[dbo].[facility] 
values (3, 'facility3', 'facility3');

---------------
insert into [Student_Course_Dept].[dbo].[dept]
      values (1, 'dept1', 'dept1', 1);

insert into [Student_Course_Dept].[dbo].[dept]
      values (2, 'dept2', 'dept2', 2);

insert into [Student_Course_Dept].[dbo].[dept]
      values (3, 'dept3', 'dept3', 1);

insert into [Student_Course_Dept].[dbo].[dept]
      values (4, 'dept4', 'dept4', 2);

insert into [Student_Course_Dept].[dbo].[dept]
      values (5, 'dept5', 'dept5', 3);

insert into [Student_Course_Dept].[dbo].[dept]
      values (6, 'dept6', 'dept6', 3);
	  
insert into [Student_Course_Dept].[dbo].[dept]
      values (7, 'dept6', 'dept6', 3);	  

-----------

INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (1, 'faculty1', 1);
  
INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (2, 'faculty2', 1);

INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (3, 'faculty3', 2);

INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (4, 'faculty4', 3);
  
INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (5, 'faculty5', 4);
  
INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (6, 'faculty6', 5);

INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (7, 'faculty7', 4);
  
INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (8, 'faculty8', 6);

INSERT INTO [Student_Course_Dept].[dbo].[faculty]
  VALUES (9, 'faculty9', 2);

---------------------
INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (1, 'student1');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (2, 'student2');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (3, 'student3');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (4, 'student4');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (5, 'student5');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (6, 'student6');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (7, 'student7');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (8, 'student8');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (9, 'student9');

INSERT INTO [Student_Course_Dept].[dbo].[student]
  VALUES (10, 'student10');  

------------------------------- 
INSERT INTO [Student_Course_Dept].[dbo].[course]
  VALUES (1, 'course1', 'course1', 1);

INSERT INTO [Student_Course_Dept].[dbo].[course]
  VALUES (2, 'course2', 'course2', 2);

INSERT INTO [Student_Course_Dept].[dbo].[course]
  VALUES (3, 'course3', 'course3', 2);

INSERT INTO [Student_Course_Dept].[dbo].[course]
  VALUES (4, 'course4', 'course4', 1);

INSERT INTO [Student_Course_Dept].[dbo].[course]
  VALUES (5, 'course5', 'course5', 3);

---------------
INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (1, 3);

INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (1, 4);
  
INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (1, 6);
  
INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (2, 1);
  
INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (2, 8)
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (2, 9);
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (3, 3);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (3, 7);
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (3, 8);
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (4, 2);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (4, 6);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (4, 7);  
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (5, 6);  
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (5, 7);  

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (5, 4);    
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (6, 6);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (6, 1);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (6, 2);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (7, 5);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (8, 6);  
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (8, 5); 

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (8, 3);  

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (9, 9);    
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (9, 2);    

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (9, 1);    
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (10, 5);

  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (10, 3);
  
  INSERT INTO [Student_Course_Dept].[dbo].[student_course_enrollment]
  VALUES (10, 9);



