/*
    Purpose: Identify and flag unusually high manager salaries for review.
    - During initial analysis, some salary values appeared exceptionally high.
    - To ensure data integrity and facilitate further investigation, salaries exceeding $2,000,000 are flagged unless associated with executive, founder, senior medical, legal, or principal engineering roles.
    - This approach supports accurate reporting and highlights potential anomalies or exceptional compensation cases.
*/

-- Step 1: Create a CTE to clean and convert salary data
WITH annual_salary AS
(
    SELECT
        job_title,
        base_annual_compensation,
        -- Remove commas from the salary string and convert it to BIGINT for numeric comparison
        CAST(REPLACE(base_annual_compensation, ',', '') AS BIGINT) AS base_annual_compensation_raw
    FROM dbo.manager_salary
)

-- Step 2: Select salary data with flags for verification
SELECT
    job_title,
    base_annual_compensation,
    base_annual_compensation_raw,
    CASE
        -- Step 2a: Identify high-salary job titles
        -- We use LOWER() to make keyword matching case-insensitive
        -- PATINDEX() returns >0 if the keyword exists in the string
        WHEN PATINDEX('%ceo%', LOWER(job_title)) > 0
            OR PATINDEX('%cfo%', LOWER(job_title)) > 0
            OR PATINDEX('%coo%', LOWER(job_title)) > 0
            OR PATINDEX('%cto%', LOWER(job_title)) > 0
            OR PATINDEX('%cpo%', LOWER(job_title)) > 0
            OR PATINDEX('%chief%', LOWER(job_title)) > 0
            OR PATINDEX('%founder%', LOWER(job_title)) > 0
            OR PATINDEX('%owner%', LOWER(job_title)) > 0
            OR PATINDEX('%partner%', LOWER(job_title)) > 0
            OR PATINDEX('%managing director%', LOWER(job_title)) > 0
            OR PATINDEX('%president%', LOWER(job_title)) > 0
            OR PATINDEX('%physician%', LOWER(job_title)) > 0
            OR PATINDEX('%surgeon%', LOWER(job_title)) > 0
            OR PATINDEX('%attending%', LOWER(job_title)) > 0
            OR PATINDEX('%medical director%', LOWER(job_title)) > 0
            OR PATINDEX('%general counsel%', LOWER(job_title)) > 0
            OR PATINDEX('%counsel%', LOWER(job_title)) > 0
            OR PATINDEX('%director of engineering%', LOWER(job_title)) > 0
            OR PATINDEX('%principal software engineer%', LOWER(job_title)) > 0
            OR PATINDEX('%vp%', LOWER(job_title)) > 0
        THEN 'OK' -- High-salary job titles are allowed to exceed $2,000,000

        -- Step 2b: Flag salaries above $2,000,000 for review if not a high-salary title
        WHEN base_annual_compensation_raw > 2000000 THEN 'SUSPICIOUS'

        -- Step 2c: Default flag for all other salaries
        ELSE 'OK'
    END AS base_annual_compensation_flag
FROM annual_salary

-- Step 3: Sort the results so the highest salaries appear first
ORDER BY
    base_annual_compensation_raw DESC
