# Problem 1: The Hierarchy of Needs
- List of any other students you worked with: Evyn and Salvador
- About how long did you work on this problem? [45 minutes]
- GenAI Conversation link (if used): N/a

This problem analyzes the relationship between Safety (pf_ss) and GDP.

## Part A: Top 5 Safest Countries

```sql
-- Paste your SQL Query for Part A here
-- (Select top 5 from freedom ordered by pf_ss desc)

SELECT c.country_name, c.region, f.pf_ss
FROM freedom f
JOIN countries c ON f.country_name = c.country_name
ORDER BY f.pf_ss DESC
LIMIT 5;

```

## Part B: Wealth vs Safety by Region
code 

```sql
-- Paste your SQL Query for Part B here
-- (Join countries/freedom, Group By Region, Avg GDP and Avg Safety)

SELECT 
    c.region, 
    ROUND(AVG(c.gdp_usd), 2) AS avg_gdp, 
    ROUND(AVG(f.pf_ss), 2) AS avg_safety
FROM countries c
JOIN freedom f ON c.country_name = f.country_name
GROUP BY c.region
ORDER BY avg_safety DESC;

```

## Part C: The Hidden Gems

```sql
-- Paste your SQL Query for Part C here
-- (Where pf_ss > avg AND gdp < avg)

SELECT 
    c.country_name, 
    f.pf_ss, 
    c.gdp_usd
FROM countries c
JOIN freedom f ON c.country_name = f.country_name
WHERE f.pf_ss > (SELECT AVG(pf_ss) FROM freedom)
  AND c.gdp_usd < (SELECT AVG(gdp_usd) FROM countries)
ORDER BY f.pf_ss DESC;

```