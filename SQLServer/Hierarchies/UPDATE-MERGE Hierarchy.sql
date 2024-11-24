SELECT * FROM [dbo].[food_categories_hierarchy]
ORDER BY ID, LEVEL;

SELECT * FROM [dbo].[food_categories_hierarchy_tmp]
ORDER BY ID, LEVEL;

SELECT ID, LEVEL, COUNT(*) FROM [dbo].[food_categories_hierarchy]
GROUP BY ID, LEVEL
HAVING COUNT(*) > 1
ORDER BY ID, LEVEL;

SELECT ID, LEVEL, COUNT(*) FROM [dbo].[food_categories_hierarchy_tmp]
GROUP BY ID, LEVEL
HAVING COUNT(*) > 1
ORDER BY ID, LEVEL;



SELECT A.*, B.*
FROM [dbo].[food_categories_hierarchy] A
INNER JOIN [dbo].[food_categories_hierarchy_tmp] B
ON A.ID = B.ID
AND A.LEVEL = B.LEVEL;

/* UPDATE does not work!!! Use Merge instead!!!

UPDATE [dbo].[food_categories_hierarchy] 
SET catName = B.catName,
	PathName = B.PathName
FROM [dbo].[food_categories_hierarchy] A
INNER JOIN [dbo].[food_categories_hierarchy_tmp] B
ON A.ID = B.ID
AND A.LEVEL = B.LEVEL;
*/

MERGE 
    [dbo].[food_categories_hierarchy] tgt
    USING [dbo].[food_categories_hierarchy_tmp] src 
	ON (tgt.ID = src.ID) AND tgt.LEVEL = src.LEVEL
WHEN MATCHED 
    THEN UPDATE SET 
        tgt.catName = src.catName,
		tgt.PathName = src.PathName
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ID, catName, PathName, Level, ParentID)
         VALUES (src.ID, src.catName, src.PathName, src.Level, src.ParentID);


SELECT ID, catID, PathID, Level, ParentID