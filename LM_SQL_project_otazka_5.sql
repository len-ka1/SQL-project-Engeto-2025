WITH ceny_potravin AS (
    SELECT
        rok,
        AVG(rocni_prumerna_cena_kc) AS prumerna_cena_potravin
    FROM t_lenka_masopustova_project_SQL_primary_final
    GROUP BY rok
	),
mzdy AS (
    SELECT
        rok,
        AVG(prumerna_hruba_mzda_kc) FILTER (WHERE prumyslove_odvetvi = 'Všechna odvětví') AS prumerna_hruba_mzda
    FROM t_lenka_masopustova_project_SQL_primary_final
    GROUP BY rok
	),
vypoctena_data AS (
    SELECT
        COALESCE(cp.rok, mz.rok) AS rok,
        cp.prumerna_cena_potravin,
        mz.prumerna_hruba_mzda
    FROM ceny_potravin cp
    FULL OUTER JOIN mzdy mz ON cp.rok = mz.rok
	),
s_predchozim_rokem AS (
    SELECT
        rok,
        prumerna_cena_potravin,
        prumerna_hruba_mzda,
        LAG(prumerna_cena_potravin) OVER (ORDER BY rok) AS predchozi_cena,
        LAG(prumerna_hruba_mzda) OVER (ORDER BY rok) AS predchozi_mzda
    FROM vypoctena_data
	),
gdp_data AS (
    SELECT
        year AS rok,
        gdp_change_percent AS mezirocni_narust_HDP
    FROM t_lenka_masopustova_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
	)
SELECT
    spr.rok,
    ROUND(((spr.prumerna_cena_potravin - spr.predchozi_cena) / spr.predchozi_cena * 100)::numeric, 2) AS mezirocni_narust_cen_potravin,
    ROUND(((spr.prumerna_hruba_mzda - spr.predchozi_mzda) / spr.predchozi_mzda * 100)::numeric, 2) AS mezirocni_narust_mzdy,
    gdp.mezirocni_narust_HDP,
    CASE
        WHEN ((spr.prumerna_cena_potravin - spr.predchozi_cena) / spr.predchozi_cena * 100) IS NULL THEN 'Data nejsou k dispozici'
	    WHEN ((spr.prumerna_cena_potravin - spr.predchozi_cena) / spr.predchozi_cena * 100) > gdp.mezirocni_narust_HDP THEN 'Potraviny rostou rychleji'
        WHEN ((spr.prumerna_cena_potravin - spr.predchozi_cena) / spr.predchozi_cena * 100) < gdp.mezirocni_narust_HDP THEN 'Potraviny rostou pomaleji'
        ELSE 'Stejně rychle'
    END AS ceny_potravin_vs_HDP,
    CASE
        WHEN mezirocni_narust_hdp IS NULL THEN 'Data nejsou k dispozici'
	    WHEN ((spr.prumerna_hruba_mzda - spr.predchozi_mzda) / spr.predchozi_mzda * 100) > gdp.mezirocni_narust_HDP THEN 'Mzdy rostou rychleji'
        WHEN ((spr.prumerna_hruba_mzda - spr.predchozi_mzda) / spr.predchozi_mzda * 100) < gdp.mezirocni_narust_HDP THEN 'Mzdy rostou pomaleji'
        ELSE 'Stejně rychle'
    END AS mzdy_vs_HDP
FROM s_predchozim_rokem spr
LEFT JOIN gdp_data gdp ON spr.rok = gdp.rok
WHERE spr.predchozi_cena IS NOT NULL OR spr.predchozi_mzda IS NOT NULL
ORDER BY rok;