CREATE TABLE t_lenka_masopustova_project_SQL_secondary_final as
WITH gdp_europe AS (
    SELECT
        e.country,
        e.year,
        e.population,
    	e.gini,
        e.gdp,
        LAG(e.gdp) OVER (PARTITION BY e.country ORDER BY e.year) AS gdp_prev_year
    FROM economies e
    JOIN countries c ON e.country = c.country
    WHERE c.continent = 'Europe'
    	AND YEAR BETWEEN 2000 AND 2021
	)
SELECT
    country,
    year,
    population,
    gini,
    gdp,
    gdp_prev_year,
    ROUND(
        CASE 
            WHEN gdp_prev_year IS NULL THEN NULL
            ELSE ((gdp - gdp_prev_year) / gdp_prev_year)::numeric * 100
        END, 2) AS gdp_change_percent
FROM gdp_europe
ORDER BY country, year;

--

SELECT *
FROM t_lenka_masopustova_project_SQL_secondary_final;