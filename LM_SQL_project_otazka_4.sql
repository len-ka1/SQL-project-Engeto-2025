WITH vypoctena_data AS (
    SELECT
        rok,
        AVG(rocni_prumerna_cena_kc) AS prumerna_cena_potravin,
        AVG(prumerna_hruba_mzda_kc) FILTER (WHERE prumyslove_odvetvi = 'Všechna odvětví') AS prumerna_hruba_mzda
    FROM t_lenka_masopustova_project_SQL_primary_final
    GROUP BY rok
	),
s_predchozim_rokem AS (
    SELECT
        rok,
        prumerna_cena_potravin,
        prumerna_hruba_mzda,
        LAG(prumerna_cena_potravin) OVER (ORDER BY rok) AS predchozi_cena,
        LAG(prumerna_hruba_mzda) OVER (ORDER BY rok) AS predchozi_mzda
    FROM vypoctena_data
	)
SELECT
    rok,
    prumerna_cena_potravin,
    predchozi_cena,
    prumerna_hruba_mzda,
    predchozi_mzda,
    ROUND(((prumerna_cena_potravin - predchozi_cena) / predchozi_cena * 100)::numeric, 2) AS mezirocni_narust_cen_potravin,
    ROUND(((prumerna_hruba_mzda - predchozi_mzda) / predchozi_mzda * 100)::numeric, 2) AS mezirocni_narust_mzdy,
    ROUND((
            ((prumerna_cena_potravin - predchozi_cena) / predchozi_cena * 100) -
            ((prumerna_hruba_mzda - predchozi_mzda) / predchozi_mzda * 100)
        )::numeric, 2
    ) AS rozdil_mezi_narusty
FROM s_predchozim_rokem
WHERE predchozi_cena IS NOT NULL AND predchozi_mzda IS NOT NULL
ORDER BY rozdil_mezi_narusty
--ORDER BY mezirocni_narust_cen_potravin desc
;