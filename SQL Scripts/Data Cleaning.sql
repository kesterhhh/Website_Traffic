/* Step 1: Clean the Website Traffic dataset by selecting relevant columns and casting values to appropriate data types.
They are already in appropraite data types from the data import stage.
We'll store the cleaned data in a new table called WebsiteTraffic_Cleaned. */

SELECT
    Page_Views,
    Session_Duration,
    Bounce_Rate,
    Traffic_Source,
    Time_on_Page,
    Previous_Visits,
    Conversion_Rate
INTO WebsiteTraffic_Cleaned
FROM dbo.WebsiteTraffic; 


/* Step 2: Create a Common Table Expression (CTE) to analyze the cleaned dataset.
This CTE will check for NULL values in each column and categorize the rows accordingly. */

WITH CTE_WebsiteTraffic AS (
    SELECT *,
        CASE
            WHEN Page_Views IS NULL OR 
                 Session_Duration IS NULL OR 
                 Bounce_Rate IS NULL OR 
                 Traffic_Source IS NULL OR 
                 Time_on_Page IS NULL OR 
                 Previous_Visits IS NULL OR 
                 Conversion_Rate IS NULL
            THEN 'Contains null values'
            ELSE 'No null values'
        END AS Contains_Null_Values
    FROM WebsiteTraffic_Cleaned
)
/* Step 3: Select all rows from the CTE where NULL values are present. This will help us identify any records that need further attention. */
SELECT * 
FROM CTE_WebsiteTraffic
WHERE Contains_Null_Values = 'Contains null values'; 


/* Step 4: Create a view named view_website_traffic_dataset to provide easy access to the cleaned dataset.
This view will allow for simplified queries on the cleaned data. */

CREATE VIEW view_website_traffic_dataset AS
SELECT *
FROM WebsiteTraffic_Cleaned;