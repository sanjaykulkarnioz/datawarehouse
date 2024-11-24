truncate table department;
truncate table employee;
truncate table office;
--example :
--insert into my_table(id, date1) values (1, cast(''23-07-2016'   AS date));
--insert statements
INSERT INTO  department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (1, 1, 'Salesdept', cast('01-Jan-2014'   AS date), cast('20-Jul-2014'   AS date), 0 );

INSERT INTO  department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (4, 1, 'SalesD', cast('21-Jul-2014'   AS date), cast('15-Nov-2015'   AS date), 0 );

INSERT INTO  department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (2, 2, 'IT', cast('16-Nov-2014'   AS date), cast('31-Dec-9999'   AS date), 0 );

INSERT INTO  department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (3, 3, 'Support', cast('16-Nov-2014'   AS date), cast('31-Dec-9999'   AS date), 0 );

INSERT INTO  department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (5, 1, 'Sales', cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date), 0 );
 

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM) 
VALUES (1, 1, 'Sally', 'Jones', 3, 2, 5, cast('16-Nov-2014'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (2, 2, 'Mark', 'Smithe', 2, 4, 3, cast('01-Jan-2014'   AS date), cast('20-Nov-2014'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (3, 3, 'John', 'Andrews', 1, 4, 3, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (4, 4, 'Michelle', 'Johnson', 2, NULL, 5, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (5, 5, 'Brian', 'Grand', 2, 2, 3, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (6, 2, 'Mark', 'Smithy', 2, 4, 3, cast('21-Jul-2014'   AS date), cast('15-Nov-2015'   AS date));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (7, 2, 'Mark', 'Smith', 2, 4, 3, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));
 

INSERT INTO  office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (1, 1, 1, 22120, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO  office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (2, 2, 2, 77070, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

INSERT INTO  office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (3, 3, 3, 90210, cast('01-Jan-2014'   AS date), cast('20-Jul-2014'   AS date));

INSERT INTO  office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (4, 3, 3, 90210, cast('21-Jul-2014'   AS date), cast('15-Nov-2015'   AS date));

INSERT INTO  office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (5, 3, 3, 90210, cast('16-Nov-2015'   AS date), cast('31-Dec-9999'   AS date));

