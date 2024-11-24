CREATE TABLE department (
	 DEPT_ID_SK int  NOT NULL,
	 DEPT_ID int  NOT NULL,
	 DEPT_NAME varchar (50) NULL,
	 FROM_DTTM date  NULL,
	 TO_DTTM date  NULL,
	 RETIRED_FLAG int NULL
);

CREATE OR REPLACE  TABLE employee (
	 EMP_ID_SK int  NOT NULL,
	 EMP_ID int  NOT NULL,
	 FIRST_NAME varchar (50) NULL,
	 LAST_NAME varchar (50) NULL,
	 DEPT_ID int  NULL,
	 MANAGER_ID int  NULL,
	 OFFICE_ID int  NULL,
	 FROM_DTTM date  NULL,
	 TO_DTTM date  NULL
);


CREATE OR REPLACE  TABLE office (
	 OFFICE_ID_SK int  NOT NULL,
	 OFFICE_ID int  NOT NULL,
	 ZIP int  NULL,
	 DEPT_ID int  NULL,
	 FROM_DTTM date  NULL,
	 TO_DTTM date  NULL);

