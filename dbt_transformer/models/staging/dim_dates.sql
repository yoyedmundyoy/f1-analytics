WITH date_range AS (
  -- This generates dates from 1950 (first F1 season) to 2030 (future dates for planning)
  SELECT
    date
  FROM
    UNNEST(GENERATE_DATE_ARRAY('1950-01-01', '2030-12-31')) AS date
)
SELECT
  -- Primary key
  FORMAT_DATE('%Y%m%d', date) AS date_id,
  
  -- Date in various formats
  date AS full_date,
  FORMAT_DATE('%Y-%m-%d', date) AS date_string,
  
  -- Year
  EXTRACT(YEAR FROM date) AS year,
  
  -- Quarter
  EXTRACT(QUARTER FROM date) AS quarter,
  FORMAT('Q%d', EXTRACT(QUARTER FROM date)) AS quarter_name,
  FORMAT('Q%d-%d', EXTRACT(QUARTER FROM date), EXTRACT(YEAR FROM date)) AS quarter_year,
  
  -- Month
  EXTRACT(MONTH FROM date) AS month_number,
  FORMAT_DATE('%B', date) AS month_name,
  FORMAT_DATE('%b', date) AS month_short_name,
  FORMAT_DATE('%Y-%m', date) AS year_month,
  
  -- Week
  EXTRACT(WEEK FROM date) AS week_number,
  FORMAT('Week %d, %d', EXTRACT(WEEK FROM date), EXTRACT(YEAR FROM date)) AS week_year,
  
  -- Day
  EXTRACT(DAY FROM date) AS day_of_month,
  FORMAT_DATE('%A', date) AS day_name,
  FORMAT_DATE('%a', date) AS day_short_name,
  MOD(EXTRACT(DAYOFWEEK FROM date) + 5, 7) + 1 AS day_of_week, -- 1=Monday, 7=Sunday
  EXTRACT(DAYOFYEAR FROM date) AS day_of_year,
  
  -- F1 season flags
  CASE
    WHEN EXTRACT(MONTH FROM date) BETWEEN 3 AND 12 THEN 'Y'
    ELSE 'N'
  END AS is_f1_season,
  
  -- Weekend flag (useful for race weekends)
  CASE 
    WHEN FORMAT_DATE('%A', date) IN ('Saturday', 'Sunday') THEN 'Y'
    ELSE 'N'
  END AS is_weekend,
  
FROM
  date_range
ORDER BY
  date
  