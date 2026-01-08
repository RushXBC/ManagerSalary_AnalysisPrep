/*
    Purpose: STRICTLY validate and standardize the 'city' column in the manager_salary table.

    IMPORTANT:
    - This logic uses STRICT REFERENCE MATCHING against the all_cities table.
    - Only cities that exist EXACTLY (after normalization) in the reference table
      are considered valid.
    - No partial matching, no fuzzy logic, no assumptions.
    - Any value not found in all_cities is treated as invalid and set to NULL.

    Rationale:
    - Respondent-entered city data is noisy and unreliable.
    - Downstream analysis requires a controlled and verified list of real cities.
    - It is safer to discard uncertain values than to misclassify them.
*/

SELECT
    -- Raw city value exactly as entered by the respondent
    m.city,

    CASE
        -- If no exact match exists in the reference table,
        -- the city is explicitly rejected.
        WHEN a.city IS NULL THEN NULL

        -- Only cities that pass strict reference validation
        -- are standardized for presentation.
        ELSE
            UPPER(LEFT(LTRIM(RTRIM(m.city)), 1)) +
            LOWER(
                SUBSTRING(
                    LTRIM(RTRIM(m.city)),
                    2,
                    LEN(LTRIM(RTRIM(m.city)))
                )
            )
    END AS cleaned_city

FROM manager_salary AS m

-- LEFT JOIN preserves all survey responses while enforcing validation.
LEFT JOIN all_cities AS a
    ON
        -- STRICT MATCH CONDITIONS:
        -- 1. Leading/trailing whitespace is removed
        -- 2. Comparison is case-insensitive
        -- 3. No substring or pattern matching is performed
        LOWER(LTRIM(RTRIM(m.city))) = LOWER(LTRIM(RTRIM(a.city)));
