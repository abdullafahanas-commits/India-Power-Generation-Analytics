USE india_power_analytics;

SELECT *
FROM power_generation;
DESCRIBE power_generation;
SELECT state_ut, grand_total
FROM power_generation
ORDER BY grand_total DESC
LIMIT 10;
SELECT state_ut, solar
FROM power_generation
ORDER BY solar DESC
LIMIT 10;
SELECT state_ut, wind
FROM power_generation
ORDER BY wind DESC
LIMIT 10;
SELECT state_ut, renewable_energy_total
FROM power_generation
ORDER BY renewable_energy_total DESC
LIMIT 10;
SELECT 
    state_ut,
    conventional_total,
    renewable_energy_total,
    grand_total
FROM power_generation
ORDER BY grand_total DESC;
SELECT 
    state_ut,
    conventional_total,
    renewable_energy_total,
    grand_total
FROM power_generation
ORDER BY grand_total DESC
LIMIT 10;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / grand_total) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC;
SELECT 
    state_ut,
    ROUND(
        (renewable_energy_total / grand_total) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC
LIMIT 10;
SELECT 
    SUM(conventional_total) AS total_conventional,
    SUM(renewable_energy_total) AS total_renewable,
    SUM(grand_total) AS total_power_generation
FROM power_generation;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / grand_total) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC;
SELECT
    state_ut,
    solar,
    wind,
    bio_power,
    small_hydro,
    CASE
        WHEN solar >= wind
         AND solar >= bio_power
         AND solar >= small_hydro THEN 'Solar'
        WHEN wind >= solar
         AND wind >= bio_power
         AND wind >= small_hydro THEN 'Wind'
        WHEN bio_power >= solar
         AND bio_power >= wind
         AND bio_power >= small_hydro THEN 'Bio Power'
        ELSE 'Small Hydro'
    END AS dominant_renewable_source
FROM power_generation;
SELECT
    state_ut,
    renewable_energy_total,
    RANK() OVER (
        ORDER BY renewable_energy_total DESC
    ) AS renewable_rank
FROM power_generation;
CREATE VIEW state_energy_profile AS
SELECT
    state_ut,
    thermal,
    hydro,
    nuclear,
    wind,
    solar,
    bio_power,
    small_hydro,
    renewable_energy_total,
    conventional_total,
    grand_total,
    ROUND(
        (renewable_energy_total / grand_total) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0;
SELECT
    ROUND(SUM(thermal), 2) AS total_thermal,
    ROUND(SUM(hydro), 2) AS total_hydro,
    ROUND(SUM(nuclear), 2) AS total_nuclear,
    ROUND(SUM(wind), 2) AS total_wind,
    ROUND(SUM(solar), 2) AS total_solar,
    ROUND(SUM(bio_power), 2) AS total_bio_power,
    ROUND(SUM(renewable_energy_total), 2) AS total_renewable,
    ROUND(SUM(conventional_total), 2) AS total_conventional,
    ROUND(SUM(grand_total), 2) AS india_total_power
FROM power_generation;
CREATE OR REPLACE VIEW dashboard_power_generation AS
SELECT
    state_ut,
    thermal,
    hydro,
    nuclear,
    wind,
    solar,
    bio_power,
    small_hydro,
    renewable_energy_total,
    conventional_total,
    grand_total,
    ROUND(
        (renewable_energy_total / grand_total) * 100,
        2
    ) AS renewable_percentage,
    ROUND(
        (conventional_total / grand_total) * 100,
        2
    ) AS conventional_percentage
FROM power_generation
WHERE grand_total > 0;
SELECT *
FROM dashboard_power_generation
ORDER BY grand_total DESC;
SELECT
    state_ut,
    renewable_energy_total,
    conventional_total,
    ROUND(
        renewable_energy_total / grand_total * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC;
SELECT
    state_ut,
    solar,
    RANK() OVER (ORDER BY solar DESC) AS solar_rank
FROM power_generation
ORDER BY solar DESC
LIMIT 10;
SELECT
    state_ut,
    wind,
    RANK() OVER (ORDER BY wind DESC) AS wind_rank
FROM power_generation
ORDER BY wind DESC
LIMIT 10;
SELECT
    COUNT(*) AS total_records,
    COUNT(state_ut) AS states_with_names,
    COUNT(grand_total) AS records_with_total,
    SUM(grand_total IS NULL) AS missing_grand_total
FROM power_generation;
SELECT 
    state_ut,
    conventional_total,
    renewable_energy_total,
    grand_total,
    ROUND((renewable_energy_total / grand_total) * 100, 2) AS renewable_percentage
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND((renewable_energy_total / grand_total) * 100, 2) AS renewable_percentage,
    RANK() OVER (
        ORDER BY (renewable_energy_total / grand_total) DESC
    ) AS renewable_rank
FROM power_generation
WHERE grand_total > 0
ORDER BY renewable_percentage DESC;
USE india_power_analytics;

SELECT 
    SUM(conventional_total) AS total_conventional,
    SUM(renewable_energy_total) AS total_renewable,
    SUM(grand_total) AS total_generation,
    ROUND(SUM(renewable_energy_total) / SUM(grand_total) * 100, 2) AS renewable_percentage,
    ROUND(SUM(conventional_total) / SUM(grand_total) * 100, 2) AS conventional_percentage
FROM power_generation;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
ORDER BY renewable_percentage DESC
LIMIT 10;
SELECT 
    state_ut,
    conventional_total,
    grand_total,
    ROUND(
        (conventional_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS conventional_percentage
FROM power_generation
ORDER BY conventional_total DESC
LIMIT 10;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE grand_total > 5000
ORDER BY renewable_energy_total DESC
LIMIT 10;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage,
    
    CASE
        WHEN (renewable_energy_total / NULLIF(grand_total, 0)) * 100 >= 30 
            THEN 'High Renewable'
        WHEN (renewable_energy_total / NULLIF(grand_total, 0)) * 100 >= 15 
            THEN 'Medium Renewable'
        ELSE 'Low Renewable'
    END AS renewable_category
FROM power_generation
ORDER BY renewable_percentage DESC;
SELECT 
    CASE
        WHEN (renewable_energy_total / NULLIF(grand_total, 0)) * 100 >= 30 
            THEN 'High Renewable'
        WHEN (renewable_energy_total / NULLIF(grand_total, 0)) * 100 >= 15 
            THEN 'Medium Renewable'
        ELSE 'Low Renewable'
    END AS renewable_category,
    
    COUNT(*) AS number_of_states
FROM power_generation
GROUP BY renewable_category
ORDER BY number_of_states DESC;
SELECT 
    ROUND(
        AVG(
            (renewable_energy_total / NULLIF(grand_total, 0)) * 100
        ),
        2
    ) AS average_renewable_percentage
FROM power_generation;
SELECT 
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
WHERE (renewable_energy_total / NULLIF(grand_total, 0)) * 100 > 17.14
ORDER BY renewable_percentage DESC;
SELECT 
    SUM(wind) AS total_wind,
    SUM(solar) AS total_solar,
    SUM(bio_power) AS total_bio_power,
    SUM(small_hydro) AS total_small_hydro,
    SUM(others) AS total_others
FROM power_generation;
SELECT 
    state_ut,
    solar
FROM power_generation
ORDER BY solar DESC
LIMIT 10;
SELECT 
    state_ut,
    wind
FROM power_generation
ORDER BY wind DESC
LIMIT 10;
SELECT 
    state_ut,
    bio_power
FROM power_generation
ORDER BY bio_power DESC
LIMIT 10;
SELECT 
    state_ut,
    small_hydro
FROM power_generation
ORDER BY small_hydro DESC
LIMIT 10;
SELECT 
    SUM(wind) AS total_wind,
    SUM(solar) AS total_solar,
    SUM(bio_power) AS total_bio_power,
    SUM(small_hydro) AS total_small_hydro,
    SUM(others) AS total_others
FROM power_generation;
SELECT
    'Wind' AS energy_source, SUM(wind) AS total_generation
FROM power_generation

UNION ALL

SELECT
    'Solar', SUM(solar)
FROM power_generation

UNION ALL

SELECT
    'Bio Power', SUM(bio_power)
FROM power_generation

UNION ALL

SELECT
    'Small Hydro', SUM(small_hydro)
FROM power_generation

UNION ALL

SELECT
    'Others', SUM(others)
FROM power_generation
ORDER BY total_generation DESC;
SELECT 
    state_ut,
    solar,
    wind,
    bio_power,
    small_hydro,
    others,
    GREATEST(
        COALESCE(solar, 0),
        COALESCE(wind, 0),
        COALESCE(bio_power, 0),
        COALESCE(small_hydro, 0),
        COALESCE(others, 0)
    ) AS highest_source_value
FROM power_generation
ORDER BY highest_source_value DESC;
SELECT 
    state_ut,
    solar,
    wind,
    bio_power,
    small_hydro,
    others,
    GREATEST(
        COALESCE(solar, 0),
        COALESCE(wind, 0),
        COALESCE(bio_power, 0),
        COALESCE(small_hydro, 0),
        COALESCE(others, 0)
    ) AS highest_source_value
FROM power_generation;
SELECT 
    state_ut,
    solar,
    wind,
    bio_power,
    small_hydro,
    others,

    CASE
        WHEN COALESCE(solar, 0) >= COALESCE(wind, 0)
         AND COALESCE(solar, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(solar, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(solar, 0) >= COALESCE(others, 0)
        THEN 'Solar'

        WHEN COALESCE(wind, 0) >= COALESCE(solar, 0)
         AND COALESCE(wind, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(wind, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(wind, 0) >= COALESCE(others, 0)
        THEN 'Wind'

        WHEN COALESCE(bio_power, 0) >= COALESCE(solar, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(wind, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(others, 0)
        THEN 'Bio Power'

        WHEN COALESCE(small_hydro, 0) >= COALESCE(solar, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(wind, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(others, 0)
        THEN 'Small Hydro'

        ELSE 'Others'
    END AS dominant_renewable_source

FROM power_generation;
SELECT 
    state_ut,
    solar,
    wind,
    bio_power,
    small_hydro,
    others,

    CASE
        WHEN COALESCE(solar, 0) >= COALESCE(wind, 0)
         AND COALESCE(solar, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(solar, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(solar, 0) >= COALESCE(others, 0)
        THEN 'Solar'

        WHEN COALESCE(wind, 0) >= COALESCE(solar, 0)
         AND COALESCE(wind, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(wind, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(wind, 0) >= COALESCE(others, 0)
        THEN 'Wind'

        WHEN COALESCE(bio_power, 0) >= COALESCE(solar, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(wind, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(small_hydro, 0)
         AND COALESCE(bio_power, 0) >= COALESCE(others, 0)
        THEN 'Bio Power'

        WHEN COALESCE(small_hydro, 0) >= COALESCE(solar, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(wind, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(bio_power, 0)
         AND COALESCE(small_hydro, 0) >= COALESCE(others, 0)
        THEN 'Small Hydro'

        ELSE 'Others'
    END AS dominant_renewable_source

FROM power_generation;
SELECT 
    dominant_renewable_source,
    COUNT(*) AS number_of_states
FROM (
    SELECT 
        CASE
            WHEN COALESCE(solar, 0) >= COALESCE(wind, 0)
             AND COALESCE(solar, 0) >= COALESCE(bio_power, 0)
             AND COALESCE(solar, 0) >= COALESCE(small_hydro, 0)
             AND COALESCE(solar, 0) >= COALESCE(others, 0)
            THEN 'Solar'

            WHEN COALESCE(wind, 0) >= COALESCE(solar, 0)
             AND COALESCE(wind, 0) >= COALESCE(bio_power, 0)
             AND COALESCE(wind, 0) >= COALESCE(small_hydro, 0)
             AND COALESCE(wind, 0) >= COALESCE(others, 0)
            THEN 'Wind'

            WHEN COALESCE(bio_power, 0) >= COALESCE(solar, 0)
             AND COALESCE(bio_power, 0) >= COALESCE(wind, 0)
             AND COALESCE(bio_power, 0) >= COALESCE(small_hydro, 0)
             AND COALESCE(bio_power, 0) >= COALESCE(others, 0)
            THEN 'Bio Power'

            WHEN COALESCE(small_hydro, 0) >= COALESCE(solar, 0)
             AND COALESCE(small_hydro, 0) >= COALESCE(wind, 0)
             AND COALESCE(small_hydro, 0) >= COALESCE(bio_power, 0)
             AND COALESCE(small_hydro, 0) >= COALESCE(others, 0)
            THEN 'Small Hydro'

            ELSE 'Others'
        END AS dominant_renewable_source
    FROM power_generation
) AS renewable_analysis
GROUP BY dominant_renewable_source
ORDER BY number_of_states DESC;
USE india_power_analytics;

-- 1. Check total records
SELECT COUNT(*) AS total_rows
FROM power_generation;

-- 2. Top 10 states by total power generation
SELECT
    state_ut,
    grand_total
FROM power_generation
ORDER BY grand_total DESC
LIMIT 10;

-- 3. Top 10 states by renewable energy
SELECT
    state_ut,
    renewable_energy_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
ORDER BY renewable_energy_total DESC
LIMIT 10;

-- 4. Renewable energy share by state
SELECT
    state_ut,
    renewable_energy_total,
    conventional_total,
    grand_total,
    ROUND(
        (renewable_energy_total / NULLIF(grand_total, 0)) * 100,
        2
    ) AS renewable_percentage
FROM power_generation
ORDER BY renewable_percentage DESC;

-- 5. Renewable source contribution
SELECT
    'Wind' AS energy_source, SUM(wind) AS total_generation
FROM power_generation
UNION ALL
SELECT 'Solar', SUM(solar) FROM power_generation
UNION ALL
SELECT 'Bio Power', SUM(bio_power) FROM power_generation
UNION ALL
SELECT 'Small Hydro', SUM(small_hydro) FROM power_generation
UNION ALL
SELECT 'Others', SUM(others) FROM power_generation
ORDER BY total_generation DESC;

-- 6. Top 10 states by solar energy
SELECT state_ut, solar
FROM power_generation
ORDER BY solar DESC
LIMIT 10;

-- 7. Top 10 states by wind energy
SELECT state_ut, wind
FROM power_generation
ORDER BY wind DESC
LIMIT 10;

-- 8. Top 10 states by bio power
SELECT state_ut, bio_power
FROM power_generation
ORDER BY bio_power DESC
LIMIT 10;

-- 9. Top 10 states by small hydro
SELECT state_ut, small_hydro
FROM power_generation
ORDER BY small_hydro DESC
LIMIT 10;