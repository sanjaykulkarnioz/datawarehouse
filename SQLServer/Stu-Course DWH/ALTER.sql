USE [Student_Course_Dept]
GO

/****** Object:  Table [dbo].[fact_student_attendance]    Script Date: 4/06/2022 5:47:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fact_student_attendance](
	[fact_id] [int] IDENTITY(1,1) NOT NULL,
	[time_id] [int] NULL,
	[course_id] [int] NULL,
	[facility_id] [int] NULL,
	[dept_id] [int] NULL,
 CONSTRAINT [PK_fact_student_attendance] PRIMARY KEY CLUSTERED 
(
	[fact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fact_student_attendance]  WITH CHECK ADD  CONSTRAINT [FK_fact_student_attendance_dim_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[dim_course] ([course_id])
GO

ALTER TABLE [dbo].[fact_student_attendance] CHECK CONSTRAINT [FK_fact_student_attendance_dim_course]
GO

ALTER TABLE [dbo].[fact_student_attendance]  WITH CHECK ADD  CONSTRAINT [FK_fact_student_attendance_dim_dept] FOREIGN KEY([dept_id])
REFERENCES [dbo].[dim_dept] ([dept_id])
GO

ALTER TABLE [dbo].[fact_student_attendance] CHECK CONSTRAINT [FK_fact_student_attendance_dim_dept]
GO

ALTER TABLE [dbo].[fact_student_attendance]  WITH CHECK ADD  CONSTRAINT [FK_fact_student_attendance_dim_facility] FOREIGN KEY([facility_id])
REFERENCES [dbo].[dim_facility] ([facility_id])
GO

ALTER TABLE [dbo].[fact_student_attendance] CHECK CONSTRAINT [FK_fact_student_attendance_dim_facility]
GO

ALTER TABLE [dbo].[fact_student_attendance]  WITH CHECK ADD  CONSTRAINT [FK_fact_student_attendance_dim_time] FOREIGN KEY([time_id])
REFERENCES [dbo].[dim_time] ([time_id])
GO

ALTER TABLE [dbo].[fact_student_attendance] CHECK CONSTRAINT [FK_fact_student_attendance_dim_time]
GO
