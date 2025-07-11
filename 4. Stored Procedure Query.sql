CREATE or ALTER PROCEDURE GetAllMovieInsights
AS
BEGIN
    --a. Number of Unique Film Titles
    SELECT COUNT(DISTINCT MOVIES) AS UniqueFilmCount
    FROM Movies;

    -- b. Lena Headey Films
    SELECT MOVIES AS Title, YEAR AS ReleaseYear, RATING, Actors
    FROM Movies
    WHERE [STARS] LIKE '%Lena Headey%' and RATING is not null
    ORDER BY YEAR;

    -- c. Director and Total Gross
	SELECT Director, SUM(
					TRY_CAST(
						REPLACE(REPLACE(Gross, '$', ''), 'M', '') 
						AS DECIMAL(18,2)
						) * 1000000
					) AS TotalGross
	FROM Movies
	WHERE Director IS NOT NULL AND Gross LIKE '$%M'
	GROUP BY Director
	ORDER BY TotalGross DESC;

    -- d. Top 5 Comedy Films by Gross
    SELECT TOP 5 MOVIES AS Title, YEAR AS ReleaseYear, RATING, Gross
    FROM Movies
    WHERE GENRE LIKE '%Comedy%' AND Gross IS NOT NULL
    ORDER BY Gross DESC;

    -- e. Scorsese + De Niro Films
    SELECT MOVIES AS Title, YEAR AS ReleaseYear, RATING, Director, Actors
    FROM Movies
    WHERE STARS LIKE '%Martin Scorsese%' AND STARS LIKE '%Robert De Niro%'
	AND Director is not null AND Actors is not null;
END;
