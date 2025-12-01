# Problem 2: The "True" Quality of Life
- List of any other students you worked with: Evyn and Salvador
- About how long did you work on this problem? [45 minutes]
- GenAI Conversation link (if used): N/a

This problem compares subjective Happiness against objective Infant Mortality using CTEs.

## SQL to Categorize Health Tiers and Calculate Avg Happiness
```sql
-- Paste your SQL Query for Problem 2 here
-- (WITH Health_Stats AS (CASE WHEN infant_mortality < 10 THEN 'High Quality'...))

WITH Health_Stats AS (
    SELECT 
        country_name, 
        infant_mortality,
        CASE 
            WHEN infant_mortality < 10 THEN 'High Quality'
            WHEN infant_mortality BETWEEN 10 AND 19.999 THEN 'Good Standard'
            WHEN infant_mortality BETWEEN 20 AND 29.999 THEN 'Moderate Standard'
            WHEN infant_mortality BETWEEN 30 AND 39.999 THEN 'Low Standard'
            WHEN infant_mortality BETWEEN 40 AND 49.999 THEN 'High Risk'            
            ELSE 'Crisis'
        END AS health_tier
    FROM countries
)
SELECT 
    h_stats.health_tier, 
    ROUND(AVG(hap.ladder_score), 2) AS avg_happiness
FROM Health_Stats h_stats
JOIN happiness hap ON h_stats.country_name = hap.country_name
GROUP BY h_stats.health_tier
ORDER BY avg_happiness DESC;

```