-- 0. Cleans up previous runs to avoid errors
DROP TABLE IF EXISTS happiness;
DROP TABLE IF EXISTS freedom;
DROP TABLE IF EXISTS countries;

-- 1. Creates the specific tables (Rubric: 3 Tables in 3NF + Constraints)

-- TABLE 1: COUNTRIES (Demographic & Economic Fundamentals)
CREATE TABLE countries (
    country_name TEXT PRIMARY KEY,
    region TEXT,
    gdp_usd NUMERIC,          
    infant_mortality NUMERIC, 
    population INTEGER
);

-- TABLE 2: HAPPINESS (Subjective Metrics)
CREATE TABLE happiness (
    id SERIAL PRIMARY KEY,    
    country_name TEXT REFERENCES countries(country_name),
    
    -- DATA INTEGRITY: Ensure scores are valid (0 to 10)
    ladder_score NUMERIC CHECK (ladder_score >= 0 AND ladder_score <= 10),
    social_support NUMERIC,
    healthy_life_expectancy NUMERIC,
    generosity NUMERIC,
    corruption_perception NUMERIC
);

-- TABLE 3: FREEDOM (Objective Metrics)
CREATE TABLE freedom (
    id SERIAL PRIMARY KEY,    
    country_name TEXT REFERENCES countries(country_name),
    
    -- DATA INTEGRITY: Ensure scores are valid (0 to 10)
    pf_ss NUMERIC CHECK (pf_ss >= 0 AND pf_ss <= 10),
    pf_score NUMERIC CHECK (pf_score >= 0 AND pf_score <= 10),
    hf_score NUMERIC CHECK (hf_score >= 0 AND hf_score <= 10),
    ef_legal NUMERIC CHECK (ef_legal >= 0 AND ef_legal <= 10)
);

-- 2. Populate tables from consolidated_country_data_2019(final).csv (132 rows)

INSERT INTO countries (country_name, region, gdp_usd, infant_mortality, population)
SELECT DISTINCT 
    country, 
    region, 
    usd_gdp_per_capita, 
    infant_mortality_per_1000_births, 
    population
FROM consolidated_country_data_2019(final).csv;

INSERT INTO happiness (country_name, ladder_score, social_support, healthy_life_expectancy, generosity, corruption_perception)
SELECT DISTINCT 
    country, 
    score, 
    social_support, 
    healthy_life_expectancy, 
    generosity, 
    perceptions_of_corruption
FROM consolidated_country_data_2019(final).csv;

INSERT INTO freedom (country_name, pf_ss, pf_score, hf_score, ef_legal)
SELECT DISTINCT 
    country, 
    pf_ss, 
    pf_score, 
    hf_score, 
    ef_legal
FROM consolidated_country_data_2019(final).csv;