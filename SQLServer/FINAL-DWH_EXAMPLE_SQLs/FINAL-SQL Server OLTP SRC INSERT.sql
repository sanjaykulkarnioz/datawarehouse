--example :
--insert into my_table(id, date1) values (1, CAST('2016-07-23' AS DATE));
--insert statements
INSERT INTO department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (1, 1, 'Salesdept', CAST('2014-01-01' AS DATE), CAST('2014-07-20' AS DATE), 0);

INSERT INTO department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (4, 1, 'SalesD', CAST('2014-07-21' AS DATE), CAST('2015-11-15' AS DATE), 0);

INSERT INTO department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (2, 2, 'IT', CAST('2014-11-16' AS DATE), CAST('9999-12-31' AS DATE), 0);

INSERT INTO department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (3, 3, 'Support', CAST('2014-11-16' AS DATE), CAST('9999-12-31' AS DATE), 0);

INSERT INTO department (DEPT_ID_SK, dept_id, dept_name, FROM_DTTM, TO_DTTM, RETIRED_FLAG) 
VALUES (5, 1, 'Sales', CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE), 0);


INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM) 
VALUES (1, 1, 'Sally', 'Jones', 3, 2, 5, CAST('2014-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (2, 2, 'Mark', 'Smithe', 2, 4, 3, CAST('2014-01-01' AS DATE), CAST('2014-07-20' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (3, 3, 'John', 'Andrews', 1, 4, 3, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (4, 4, 'Michelle', 'Johnson', 2, NULL, 5, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (5, 5, 'Brian', 'Grand', 2, 2, 3, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (6, 2, 'Mark', 'Smithy', 2, 4, 3, CAST('2014-07-21' AS DATE), CAST('2015-11-15' AS DATE));

INSERT INTO employee (EMP_ID_SK, emp_id, first_name, last_name, dept_id, manager_id, office_id, FROM_DTTM, TO_DTTM)
VALUES (7, 2, 'Mark', 'Smith', 2, 4, 3, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));


INSERT INTO office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (1, 1, 1, 22120, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (2, 2, 2, 77070, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));

INSERT INTO office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (3, 3, 3, 90210, CAST('2014-01-01' AS DATE), CAST('2014-07-20' AS DATE));

INSERT INTO office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (4, 3, 3, 90210, CAST('2014-07-21' AS DATE), CAST('2015-11-15' AS DATE));

INSERT INTO office (OFFICE_ID_SK, office_id, dept_id, zip, FROM_DTTM, TO_DTTM) 
VALUES (5, 3, 3, 90210, CAST('2015-11-16' AS DATE), CAST('9999-12-31' AS DATE));