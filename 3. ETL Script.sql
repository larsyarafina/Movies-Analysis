-- ETL
-- Step 1: Add new columns to store cleaned values
-- Use TRY to avoid errors if columns already exist

--BEGIN TRY
    --ALTER TABLE Movies
    --ADD Director NVARCHAR(255),
    --    Actors NVARCHAR(MAX);
--END TRY

-- Step 2: Update Director column
UPDATE Movies
SET Director = LTRIM(RTRIM(
-- LTRIM(RTRIM(..)) will removes leading / trailing spaces
    SUBSTRING(
        STARS,
		-- find the start of Director, +9 to skips past 'Director:'
        CHARINDEX('Director:', STARS) + 9,
		-- find the piple | that ends the director section
        CHARINDEX('|', STARS + '|') - CHARINDEX('Director:', STARS) - 9
    )
))
WHERE STARS LIKE '%Director:%|%';

-- Step 3: Update Actors column
UPDATE Movies
SET Actors = LTRIM(RTRIM(
    SUBSTRING(
        STARS,
        CHARINDEX('Stars:', STARS) + 7,
        LEN(STARS)
    )
))
WHERE STARS LIKE '%Stars:%';

SELECT TOP 10 MOVIES, STARS, Director, Actors
FROM Movies
WHERE STARS IS NOT NULL;


