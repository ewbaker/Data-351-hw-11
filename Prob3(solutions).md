# Problem 3: The Ultimate Migration List
- List of any other students you worked with: Evyn and Salvador
- About how long did you work on this problem? [1.5 hours]
- GenAI Conversation link (if used): N/a

This problem filters for the "Ideal" countries based on 4 distinct criteria.

## SQL to filter and export to `ideal_destinations.csv`
**Don't forget to upload the CSV of that table!**

```sql

    -- Paste your SQL Query for Problem 3 here
    -- SELECT * FROM ...
    -- WHERE pf_ss > 8.0 AND ...
    -- ORDER BY healthy_life_expectancy DESC

COPY (
    SELECT 
        c.country_name, 
        c.region, 
        h.healthy_life_expectancy, 
        c.gdp_usd, 
        f.pf_ss,
        f.pf_score,
        h.social_support
    FROM countries c
    JOIN happiness h ON c.country_name = h.country_name
    JOIN freedom f ON c.country_name = f.country_name
    WHERE f.pf_ss > 8.0
      AND c.gdp_usd > 20000        
      AND h.social_support > 0.9   
      AND f.pf_score > 8.0         
    ORDER BY h.healthy_life_expectancy DESC
)
TO 'C:/Users/YourName/Downloads/ideal_destinations.csv' 
WITH (FORMAT CSV, HEADER);

```