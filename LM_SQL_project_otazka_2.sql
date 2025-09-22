WITH mzdy_2006 AS (
	    SELECT
	    	prumyslove_odvetvi,
	    	prumerna_hruba_mzda_kc AS mzda_2006
	    FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2006
	    ),
     mzdy_2018 AS (
		SELECT
			prumyslove_odvetvi,
			prumerna_hruba_mzda_kc AS mzda_2018
		FROM t_lenka_masopustova_project_SQL_primary_final
		WHERE rok = 2018
		),
	mleko2006 AS (
		SELECT
			rocni_prumerna_cena_kc AS mleko_2006
		FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2006 AND druh_potraviny = 'Mléko polotučné pasterované'
	    ),
	mleko2018 AS (
		SELECT
			rocni_prumerna_cena_kc AS mleko_2018
		FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2018 AND druh_potraviny = 'Mléko polotučné pasterované'
	    ),
	chleb2006 AS (
		SELECT
			rocni_prumerna_cena_kc AS chleb_2006
		FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2006 AND druh_potraviny = 'Chléb konzumní kmínový'
	    ),
	chleb2018 AS (
		SELECT
			rocni_prumerna_cena_kc AS chleb_2018
		FROM t_lenka_masopustova_project_SQL_primary_final
	    WHERE rok = 2018 AND druh_potraviny = 'Chléb konzumní kmínový'
	    )
SELECT
	mzdy_2006.prumyslove_odvetvi,
	mzdy_2006.mzda_2006,
	ROUND((mzdy_2006.mzda_2006 / mleko2006.mleko_2006)::numeric, 2) AS litru_mleka_2006,
	ROUND((mzdy_2006.mzda_2006 / chleb2006.chleb_2006)::numeric, 2) AS kusu_chleba_2006,
	mzdy_2018.mzda_2018,
	ROUND((mzdy_2018.mzda_2018 / mleko2018.mleko_2018)::numeric, 2) AS litru_mleka_2018,
	ROUND((mzdy_2018.mzda_2018 / chleb2018.chleb_2018)::numeric, 2) AS kusu_chleba_2018
FROM mzdy_2006
JOIN mzdy_2018 ON mzdy_2006.prumyslove_odvetvi = mzdy_2018.prumyslove_odvetvi
CROSS JOIN mleko2006
CROSS JOIN mleko2018
CROSS JOIN chleb2006
CROSS JOIN chleb2018;