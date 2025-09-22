WITH ceny_s_rozdily AS (
	    SELECT
	        druh_potraviny,
	        rok,
	        rocni_prumerna_cena_kc,
	        LAG(rocni_prumerna_cena_kc) OVER (PARTITION BY druh_potraviny ORDER BY rok) AS predchozi_cena
	    FROM t_lenka_masopustova_project_SQL_primary_final
		),
	rocni_narusty AS (
	    SELECT
	        druh_potraviny,
	        rok,
	        predchozi_cena,
	        rocni_prumerna_cena_kc,
	        CASE
	            WHEN predchozi_cena IS NOT NULL AND predchozi_cena > 0 THEN
	                ((rocni_prumerna_cena_kc - predchozi_cena) / predchozi_cena) * 100
	            ELSE NULL
	        END AS procentualni_narust
	    FROM ceny_s_rozdily
		),
	prumerne_narusty AS (
	    SELECT
	        druh_potraviny,
	        ROUND(AVG(procentualni_narust)::numeric, 2) AS prumerny_rocni_procent_narust
	    FROM rocni_narusty
	    GROUP BY druh_potraviny
		)
SELECT *
FROM prumerne_narusty
ORDER BY prumerny_rocni_procent_narust ASC;