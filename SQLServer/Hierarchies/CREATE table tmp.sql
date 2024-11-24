USE [db_source];

DROP TABLE [dbo].[food_categories_hierarchy_tmp];

CREATE TABLE [dbo].[food_categories_hierarchy_tmp](
	[ID] [int] NOT NULL,
	[catID] [varchar](50)  NULL,
    [catName] [varchar](50)  NULL,
	[PathID] [varchar](500)  NULL,
    [PathName] [varchar](500)  NULL,
	[Level] [varchar](50)  NULL,
	[ParentID] [varchar](50) NULL
) ON [PRIMARY];

TRUNCATE TABLE [dbo].[food_categories_hierarchy_tmp];

WITH SplitCategories AS 
(
	 SELECT id, value AS catName
	 ,REPLACE(category_name, '\', '\') AS category_name
    FROM food_categories
    CROSS APPLY STRING_SPLIT(category_name, '\')
)
-- Second CTE: Assign IDs 
,AssignIDs AS 
(
    SELECT DISTINCT
     catName
    , LEFT(category_name, PATINDEX ('%'+catName+'%', category_name) + LEN(catName) - 1) AS PathName
    FROM SplitCategories s
)
-- Third CTE: Calculate levels
,FindLevels AS 
(
    SELECT 
    DENSE_RANK() OVER (ORDER BY PathName) AS ID
    , * 
    , LEN(PathName) - LEN(REPLACE(PathName, '\', '')) AS Level
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
    INNER JOIN FindParentID r ON p.Level = r.Level +1 AND p.PathName LIKE r.PathName + '%'
)
INSERT INTO [dbo].[food_categories_hierarchy_tmp] (ID, catName, PathName, Level, ParentID)
SELECT ID, catName, PathName, Level, ParentID FROM FindParentID
ORDER BY catName, ID;

SELECT * FROM [dbo].[food_categories_hierarchy_tmp]
ORDER BY ID, LEVEL;
