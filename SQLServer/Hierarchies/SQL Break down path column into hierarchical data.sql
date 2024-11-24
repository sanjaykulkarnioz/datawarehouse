CREATE TABLE [dbo].[food_categories3](
    [id] [int] NOT NULL,
    [category] [varchar](350) NULL);

insert into food_categories3
values 
(1,'Drinks\Soda'),
(2,'Drinks\Juice\Fruit Juice\Apple Juice\Sugar Free'),
(3,'Food\Fruit\Oranges'),
(4,'Food\Fruit\Apples\Golden'),
(5,'Food\Fruit\Apples\Red Delicious'),
(6,'Food\Vegetables\Potatoes'),
(7, 'Food\Meat'),
(8,'Food');

select * from food_categories3;

SELECT id, value AS cat
	 ,REPLACE(category, '\', '\') AS category
    FROM food_categories3
    CROSS APPLY STRING_SPLIT(category, '\');

/* Great SQL Below */

-- First CTE: Split 'category_id' into individual rows and get the correct path
WITH SplitCategories AS 
(
  SELECT id, value AS cat
	 ,REPLACE(category, '\', '\') AS category
    FROM food_categories3
    CROSS APPLY STRING_SPLIT(category, '\')
)
-- Second CTE: Assign IDs 
,AssignIDs AS 
(
    SELECT DISTINCT
     cat
    , LEFT(category, PATINDEX ('%'+cat+'%', category) + LEN(cat) - 1) AS Path
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

