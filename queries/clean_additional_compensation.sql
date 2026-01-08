/*
    Purpose: Clean 'additional_compensation' by replacing NULLs with 0 and converting to integer for analysis.
    
    Step 1: Use COALESCE() to replace any NULL values with 0.
    Step 2: CAST the result to integer for consistent numeric representation.
*/
SELECT
    additional_compensation,
    CAST(COALESCE(additional_compensation, 0) AS int) AS additional_compensation_cleaned
FROM dbo.manager_salary;
