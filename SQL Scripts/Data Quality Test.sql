/*
DATA QUALITY TESTS

1. The dataset should contain a specific number of records (row count test)
2. The dataset should have a specific number of columns (column count test)
3. Each column should have the correct data type (data type check)
4. Bounce Rate values should be within the valid range of 0 to 1 (range check)
5. Session Duration and Time on Page values should be within valid ranges (range check)

Summary of Expected Requirements:
- Row count: 2000
- Column count: 7
- Data types:
    - Page_Views = INT
    - Session_Duration = FLOAT
    - Bounce_Rate = FLOAT
    - Traffic_Source = VARCHAR(50)
    - Time_on_Page = FLOAT
    - Previous_Visits = INT
    - Conversion_Rate = FLOAT
*/

-- Step 1: Row count check
SELECT COUNT(*) AS Total_Rows FROM view_website_traffic_dataset;

-- Step 2: Column count check
SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_website_traffic_dataset';

-- Step 3: Data type check
SELECT 
  COLUMN_NAME,
  DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_website_traffic_dataset';

-- Step 4: Range checks for Bounce Rate
SELECT 
    COUNT(*) AS Invalid_Bounce_Rate_Count
FROM 
    view_website_traffic_dataset
WHERE 
    Bounce_Rate < 0 OR Bounce_Rate > 1;  -- Check for valid Bounce Rate values

-- Step 5: Check if Session Duration and Time on Page values are within valid ranges
SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Session_Duration < 0 THEN 1 ELSE 0 END) AS Invalid_Session_Duration,
    SUM(CASE WHEN Time_on_Page < 0 THEN 1 ELSE 0 END) AS Invalid_Time_on_Page
FROM 
    view_website_traffic_dataset;