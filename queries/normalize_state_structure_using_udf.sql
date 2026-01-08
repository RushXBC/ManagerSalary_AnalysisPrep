/*
    Purpose: Clean and categorize the 'state' column in the manager_salary table.
    - The column contains messy, inconsistent, and free-text state entries provided by users.
    - This query standardizes entries by capitalizing single states and labeling multi-state entries as 'MULTI-STATE'.
    - It also calculates 'state_count', representing the number of states listed in each entry.
    - NULL values are preserved.
    - Note: dbo.ProperCase is a user-defined function created to capitalize the first letter of each word in a string.
*/
SELECT
    state,  -- Original raw state entry
    state_clean,  -- Cleaned and standardized state entry (single state capitalized or 'MULTI-STATE')
    LEN(state_raw) - LEN(REPLACE(state_raw,',','')) + 1 AS state_count  -- Number of states by counting commas + 1
FROM
(
    SELECT
        state,  -- Original raw state
        CASE
            /* =========================
                Cleaning the state column
                - If state is NULL, retain NULL.
                - If only one state (no commas), apply dbo.ProperCase to capitalize the first letter of each word.
                  Note: dbo.ProperCase is a user-defined function.
                - If multiple states (contains commas), label as 'MULTI-STATE'.
            ========================== */
            WHEN state IS NULL THEN NULL
            WHEN state NOT LIKE '%,%' THEN dbo.ProperCase(state)
            ELSE 'MULTI-STATE'
        END AS state_clean,

        /* =========================
            Preparing a trimmed and capitalized version of the state(s) for counting
            - Used to calculate state_count
            - If state is NULL, retain NULL
            - Otherwise, remove extra spaces and apply dbo.ProperCase
        ========================== */
        CASE
            WHEN state IS NULL THEN NULL
            ELSE dbo.Propercase(TRIM(state))
        END AS state_raw
    FROM dbo.manager_salary
) AS s
/* =========================
    Order by number of states (descending)
    - Multi-state entries appear at the top
    - Single-state entries follow
========================== */
ORDER BY LEN(state_raw) - LEN(REPLACE(state_raw,',','')) + 1 DESC;
