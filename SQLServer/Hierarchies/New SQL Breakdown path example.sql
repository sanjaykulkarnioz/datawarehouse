USE [db_source];

CREATE TABLE [dbo].[food_categories_new](
	[id] [int] NULL,
	[category_id] [varchar](350) NULL,
	[category_name] [varchar](350) NULL
) ON [PRIMARY];

insert into food_categories_new
values 
(1,'A001\AB01','Drinks\Soda'),
(2,'A001\AC01\AF01\AFJ1\AL01', 'Drinks\Juice\Fruit Juice\Apple Juice\Sugar Free'),
(3,'P001\P002\PL01','Food\Fruit\Oranges'),
(4,'P001\P002\PQ01\PL02','Food\Fruit\Apples\Golden'),
(5,'P001\P002\PQ01\PL03','Food\Fruit\Apples\Red Delicious'),
(6,'P001\P003\PL04','Food\Vegetables\Potatoes'),
(7,'P001\PL04','Food\Meat'),
(8,'P001','Food');

select * from food_categories_new;

I am building a hierarchy of associated elements like Food as category_name and associated category_id of 'P001' with child nodes under it like Fruit followed by Apples, Oranges etc separated by a \ delimiter. The same structure is stored in a SQL Server table named food_categories with columns like 'id', 'category_id' and 'category_name' and each hierarchy stored in a single row. Can you create a CREATE statement and INSERT statement to populate these sample 3 rows? How do I write a SELECT query to separate out both the category_id and 'category_name' into individual rows for each drill-down elements?

Can you modify the table structure to reflect 3 columns that is, 'id', 'category_id' and 'category_name'? The example row would be 1, 'P001\P003\PL04', 'Food\Vegetables\Potatoes'. Please create table and insert script with 5 rows in SQL Server.

Certainly! If you want to modify the table structure to include three columns: 'id', 'category_id', and 'category_name' and store the hierarchy with backslashes (\), you can create the table and insert sample data as follows:

1. Create the table with the new structure:

```sql
CREATE TABLE food_categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    category_id NVARCHAR(255),
    category_name NVARCHAR(255)
);
```

2. Insert sample data into the table:

```sql
INSERT INTO food_categories (category_id, category_name) VALUES
    ('P001\P002', 'Food\Fruit'),
    ('P001\P002\P003', 'Food\Fruit\Apples'),
    ('P001\P002\P004', 'Food\Fruit\Oranges'),
    ('P001\P002\P005', 'Food\Fruit\Bananas'),
    ('P001\P006', 'Food\Veggies\Potatoes');
```

Now, the `food_categories` table is created with the specified structure and contains five sample rows.

To separate the `category_id` and `category_name` into individual rows for each drill-down element, you can use the following SELECT query:

```sql
SELECT
    id,
    value AS category_id,
    REPLACE(category_name, '\', '\') AS category_name
FROM
    food_categories
CROSS APPLY STRING_SPLIT(category_id, '\');
```

--This query will split the `category_id` column using the backslash delimiter ('\') 
--and return each drill-down element as individual rows along with their respective 'id' 
--and 'category_name'.
--I would like to breakdown this query into CTEs as below:

--First CTE: Split 'category_id' into individual rows and get the correct path
WITH SplitCategories AS 
(
	 SELECT id, value AS cat
	 ,REPLACE(category_id, '\', '\') AS category_id
    FROM food_categories
    CROSS APPLY STRING_SPLIT(category_id, '\')
)
-- Second CTE: Assign IDs 
,AssignIDs AS 
(
    SELECT DISTINCT
     cat
    , LEFT(category_id, PATINDEX ('%'+cat+'%', category_id) + LEN(cat) - 1) AS Path
    FROM SplitCategories s
)
-- Third CTE: Calculate levels
,FindLevels AS 
(
    SELECT 
    DENSE_RANK() OVER (ORDER BY Path) AS ID
    , * 
    , LEN(Path) - LEN(REPLACE(Path, '\', '')) AS Level
    FROM AssignIDs

)
-- Fourth CTE: Find ParentID using calculated Path and Level
,FindParentID AS
(
    SELECT *, CAST(NULL AS BIGINT) AS ParentID
    FROM FindLevels
    WHERE Level = 0
    UNION ALL 
    SELECT p.*, r.ID
    FROM FindLevels p
    INNER JOIN FindParentID r ON p.Level = r.Level +1 AND p.Path LIKE r.Path + '%'
)
SELECT * FROM FindParentID
ORDER BY ID;

--create temp table
--First CTE: Split 'category_id' into individual rows and get the correct path
WITH SplitCategories AS 
(
	 SELECT id, value AS cat
	 ,REPLACE(category_id, '\', '\') AS category_id
    FROM food_categories_tmp
    CROSS APPLY STRING_SPLIT(category_id, '\')
)
-- Second CTE: Assign IDs 
,AssignIDs AS 
(
    SELECT DISTINCT
     cat
    , LEFT(category_id, PATINDEX ('%'+cat+'%', category_id) + LEN(cat) - 1) AS Path
    FROM SplitCategories s
)
-- Third CTE: Calculate levels
,FindLevels AS 
(
    SELECT 
    DENSE_RANK() OVER (ORDER BY Path) AS ID
    , * 
    , LEN(Path) - LEN(REPLACE(Path, '\', '')) AS Level
    FROM AssignIDs

)
-- Fourth CTE: Find ParentID using calculated Path and Level
,FindParentID AS
(
    SELECT *, CAST(NULL AS BIGINT) AS ParentID
    FROM FindLevels
    WHERE Level = 0
    UNION ALL 
    SELECT p.*, r.ID
    FROM FindLevels p
    INNER JOIN FindParentID r ON p.Level = r.Level +1 AND p.Path LIKE r.Path + '%'
)
SELECT * FROM FindParentID
ORDER BY ID;
