WITH mzdy_2000 AS (
	    SELECT
	    	prumyslove_odvetvi,
	    	prumerna_hruba_mzda_kc AS mzda_2000
	    FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2000
		),
     mzdy_2021 AS (
		SELECT
			prumyslove_odvetvi,
			prumerna_hruba_mzda_kc AS mzda_2021
		FROM t_lenka_masopustova_project_SQL_primary_final
		WHERE rok = 2021
		)
SELECT
	mzdy_2000.prumyslove_odvetvi,
	mzdy_2000.mzda_2000,
	mzdy_2021.mzda_2021,
    ROUND(((mzdy_2021.mzda_2021 - mzdy_2000.mzda_2000) / mzdy_2000.mzda_2000 * 100)::numeric, 2) AS procentualni_narust
FROM mzdy_2000
JOIN mzdy_2021 ON mzdy_2000.prumyslove_odvetvi = mzdy_2021.prumyslove_odvetvi
ORDER BY procentualni_narust DESC;