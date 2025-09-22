CREATE TABLE t_lenka_masopustova_project_SQL_primary_final as
	WITH mzdy AS (
	    SELECT
	        cpay.payroll_year AS rok,
	        NULL::text AS druh_potraviny,
	        NULL::double precision AS rocni_prumerna_cena_kc,
	        NULL::text AS jednotka,
	        CASE 
				WHEN cpib.name IS NOT NULL THEN cpib.name ELSE 'Všechna odvětví'
			END AS prumyslove_odvetvi,
	        avg(cpay.value)::double precision AS prumerna_hruba_mzda_kc
	    FROM czechia_payroll cpay
	    LEFT JOIN czechia_payroll_industry_branch AS cpib
	        ON cpay.industry_branch_code = cpib.code
	    WHERE cpay.calculation_code = '100'
	        AND cpay.value_type_code = '5958'
	    GROUP BY rok, prumyslove_odvetvi
				),
	potraviny AS (
	    SELECT
	        date_part('year', cp.date_from) AS rok,
	        cpc.name AS druh_potraviny,
	        avg(cp.value)::double precision AS rocni_prumerna_cena_kc,
	        concat(cpc.price_value, cpc.price_unit) AS jednotka,
	        NULL::text AS prumyslove_odvetvi,
	        NULL::double precision AS prumerna_hruba_mzda_kc
	    FROM czechia_price cp
	    JOIN czechia_price_category cpc ON cpc.code = cp.category_code
	    WHERE cp.region_code IS NULL
	    GROUP BY rok, cpc.name, jednotka
				)
	SELECT * FROM mzdy
	UNION ALL
	SELECT * FROM potraviny
	ORDER BY rok, prumyslove_odvetvi, druh_potraviny;

--
SELECT *
FROM t_lenka_masopustova_project_SQL_primary_final;

























