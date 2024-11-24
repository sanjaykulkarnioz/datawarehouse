USE [db_source];

DROP TABLE [dbo].[food_categories_hierarchy];

CREATE TABLE [dbo].[food_categories_hierarchy](
	[ID] [int] NOT NULL,
	[catID] [varchar](50)  NULL,
    [catName] [varchar](50)  NULL,
	[PathID] [varchar](500)  NULL,
    [PathName] [varchar](500)  NULL,
	[Level] [varchar](50)  NULL,
	[ParentID] [varchar](50) NULL
) ON [PRIMARY];

TRUNCATE TABLE [dbo].[food_categories_hierarchy];

WITH SplitCategories AS 
(
	 SELECT id, value AS catID
	 ,REPLACE(category_id, '\', '\') AS category_id
    FROM food_categories
    CROSS APPLY STRING_SPLIT(category_id, '\')
)

-- Second CTE: Assign IDs 
,AssignIDs AS 
(
    SELECT DISTINCT
     catID
    , LEFT(category_id, PATINDEX ('%'+catID+'%', category_id) + LEN(catID) - 1) AS PathID
    FROM SplitCategories s
)
-- Third CTE: Calculate levels
,FindLevels AS 
(
    SELECT 
    DENSE_RANK() OVER (ORDER BY PathID) AS ID
    , * 
    , LEN(PathID) - LEN(REPLACE(PathID, '\', '')) AS Level
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
    INNER JOIN FindParentID r ON p.Level = r.Level +1 AND p.PathID LIKE r.PathID + '%'
)
INSERT INTO [dbo].[food_categories_hierarchy] (ID, catID, PathID, Level, ParentID)
SELECT ID, catID, PathID, Level, ParentID FROM FindParentID
ORDER BY catID, ID;

SELECT * FROM [dbo].[food_categories_hierarchy]
ORDER BY ID, LEVEL;
