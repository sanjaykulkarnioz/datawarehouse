/*
SELECT course_id, count(*) number of attendance
FROM
    fact_student_attendance ft
    JOIN dim_course dc ON (dc.course_id = ft.course_id)
    JOIN dim_time dt ON (dt.time_id = ft.time_id)
WHERE dt.time_year = 2016
GROUP BY course_id
ORDER BY count(*) desc

[Student_Course_Dept].[dbo].[dim_time] 
([time_id_sk] ,[time_date], [time_month], [time_year]) 

insert into [Student_Course_Dept].[dbo].[fact_student_attendance]
([fact_id], [time_id_sk], [course_id_sk], [facility_id_sk], [dept_id_sk])
*/

CREATE TABLE [Student_Course_Dept].[dbo].[fact_student_attendance] AS

with CTE_COURSE_SNAPSHOT_BASE AS (
    select 
          CAL.[time_date]   AS COURSE_SNAPSHOT_DATE
        , C.[course_nbr_nk] AS COURSE_NBR_NK
        , C.[course_name]   AS course_name
        , CAL.[time_date]   AS WAREHOUSE_LOAD_TIMESTAMP
        , 'OLTP'		    AS WAREHOUSE_RECORD_SOURCE
    from
        [Student_Course_Dept].[dbo].[dim_time] CAL
    inner JOIN
        [Student_Course_Dept].[dbo].[dim_course] C
    on 
        CAL.[time_date] >= '20130101 00:00:00 AM'
        CAL.[time_date]  < GETDATE()
)
