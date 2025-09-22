# Průvodní listina k SQL projektu: Analýza dostupnosti základních potravin v ČR

**Zadavatel:** <br>
ENGETO s.r.o., Nové sady 988/2, 602 00, Brno <br>
V rámci kurzu Datová Akademie <br>
**Autor:** <br>
Mgr. Lenka Masopustová, MSc <br>
**Datum:** <br>
22.9.2025 <br>
**Kontakt:** <br>
lmasopustova@seznam.cz <br>

## Úvod
Na základě zadání analytického oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, byl připraven datový podklad pro zodpovězení klíčových výzkumných otázek týkajících se dostupnosti základních potravin na základě průměrných příjmů v České republice.
Pro stejné časové období jsou připraveny i makroekonomické ukazatele dalších evropských zemí. Výsledky budou sloužit jako podklad pro prezentaci na konferenci zaměřené na životní úroveň obyvatelstva.

## Cíl projektu
Cílem projektu je analyzovat vývoj mezd, cen základních potravin a jejich dostupnosti v čase, a to v kontextu růstu HDP v ČR a dalších evropských státech.

## Datové podklady
Data pro účely projektu poskytla společnost ENGETO s.r.o., zdrojem jsou internetové stránky Českého statistického úřadu.<br>
K dispozici jsou následující data:

**Vývoj hrubé mzdy v letech 2000 – 2021**<br>
V některých odvětvích jsou k dispozici data čtvrtletně, jinde pololetně či jedenkrát do roka.<br>
Vzhledem k relativně širokému rozsahu sledovaných let nepotřebujeme sledovat vývoj po čtvrtletích a počítáme tedy s průměrnými ročními hodnotami.<br>
Jelikož nás zajímají mzdové poměry jednotlivých zaměstnanců, nikoliv délka jejich pracovního úvazku, dává smysl počítat s fyzickým počtem zaměstnanců, a ne s počtem osob přepočteným na plnou pracovní dobu. U údajů o hrubé mzdě máme tato data k dispozici po všechna sledovaná období (u údajů o počtu zaměstnanců je k dispozici méně dat a spíše pro přepočtený počet zaměstnanců, to nás ale v rámci tohoto projektu nezajímají).<br>
Pomocné tabulky, které mají pouze dvě hodnoty, nepropojuji pomocí join, ale pracuji rovnu s danými hodnotami  - join by zde byl zbytečný, obzvláště když má jedna z tabulek (czechia_payroll_unit) prohozené hodnoty.

**Vývoj cen základních potravin v letech 2006 – 2018**<br>
Ačkoliv jsou dostupné ceny potravin v jednotlivých krajích, tyto nejsou v centru zájmu a zadání projektu, budeme tedy počítat s průměrnými ročními hodnotami.

**Celosvětové základní makroekonomické ukazatele z let 1960 - 2020** <br>
Zde nás zajímá pouze sledované období od roku 2000 v evropských zemích.

## Výzkumné otázky

***1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?*** <br>
Ano, rostou. Nejvyšší procentuální nárust byl mezi lety 2000-2021 v oblasti zdravotní a sociální péče, a to o 285%. Nejnižší nárust byl se 129% v oblasti těžby a dobývání.

***2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?*** <br>
V roce 2006 si zaměstnanec s průměrnou hrubou mzdou (ze všech odvětví) mohl koupit 1309 litrů mléka nebo 1172 kusů chleba.
V roce 2018 to bylo 1564 litrů mléka nebo 1278 kusů chleba.
V přiloženém SQL dotazu najdete výpočty i podle jednotlivých průmyslových odvětví.

***3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?*** <br>
Ve sledovaném období zaznamenal nejnižší percentuální meziroční nárůst cukr krystalový, respektive zlevnil o 1,92%.

***4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?*** <br>
Nikoliv, takový rok v rámci sledovaného období nenastal. Největší rozdíl nastal v roce 2009, kdy ceny potravin klesly o 6,41% a průměrné mzdy stouply o 3,33%. Ceny potravin stouply nejvíce v roce 2017 o 9,63%, v tomtéž roce stoupla průměrná mzda o 6,94%. Kompletní hodnoty rozdílů nárustu cen potravin a hrubé mzdy za všechna sledovaná období jsou k dispozici v rámci přiloženého SQL dotazu.

***5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?*** <br>
Nárůsty/propady výše HDP, mezd a cen potravin ve sledovaném období jsou nejlépe patrné z přiloženého grafu. <br>
V roce 2008 způsobila světová ekonomická krize propad jak HDP, tak cen potravin a výše hrubé mzdy. V následujících třech letech došlo pak k jejich nárůstu. <br>
V následujících letech můžeme sledovat jistou vazbu mezi nárůstem HDP a hrubé mzdy v tomtéž roce, vliv růstu HDP na mzdy následujících let se jeví spíše menší. <br>
Růst cen potravin nevykazuje výraznou vazbu na růst HDP v ČR. To je pravděpodobně způsobeno celou řadou vnějších vlivů nejen v prostředí ČR, ale i celosvětově - počasí a jeho vliv na úrodu, politická rozhodnutí, ceny dopravy atd. <br>
Jedná se zde o komplexní téma, které by si jistě zasloužilo důkladnější ekonomickou analýzu a především zohlednění inflace, která má vliv jak na ceny, tak i mzdy. 

## Datové podklady a přílohy:
**LM_SQL_project_tabulka_1** – vytvoření primární tabulky, hrubé mzdy a ceny potravin v ČR <br>
**LM_SQL_project_tabulka_2** – vytvoření doplňkové tabulky s makroekonomickými ukazateli evropských států <br>
**LM_SQL_project_otazka_1** – datový podklad pro výzkumnou otázku č. 1 <br>
**LM_SQL_project_otazka_2** – datový podklad pro výzkumnou otázku č. 2 <br>
**LM_SQL_project_otazka_3** – datový podklad pro výzkumnou otázku č. 3 <br>
**LM_SQL_project_otazka_4** – datový podklad pro výzkumnou otázku č. 4 <br>
**LM_SQL_project_otazka_5** – datový podklad pro výzkumnou otázku č. 5 <br>
**LM_Graf_otázka_5** – graf k výzkumné otázce č. 5 <br>



