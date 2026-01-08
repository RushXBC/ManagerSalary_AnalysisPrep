/*
    Purpose: Complete cleaning and categorization for the manager_salary table
    - Standardizes: industry, base salary, additional compensation, state, country, and city
    - Flags unusually high salaries for review
    - Uses strict reference validation for cities
*/

WITH industry_clean AS
(
    SELECT
        *,
        CASE
            WHEN PATINDEX('%aerospace%', LOWER(industry)) > 0 
              OR PATINDEX('%defense%', LOWER(industry)) > 0 
              OR PATINDEX('%aviation%', LOWER(industry)) > 0
            THEN 'Aerospace & Defense'
            WHEN PATINDEX('%agriculture%', LOWER(industry)) > 0 
              OR PATINDEX('%forestry%', LOWER(industry)) > 0 
              OR PATINDEX('%natural resource%', LOWER(industry)) > 0
            THEN 'Agriculture, Forestry & Natural Resources'
            WHEN PATINDEX('%architecture%', LOWER(industry)) > 0 
              OR PATINDEX('%engineering%', LOWER(industry)) > 0 
              OR PATINDEX('%construction%', LOWER(industry)) > 0
            THEN 'Architecture, Engineering & Construction'
            WHEN PATINDEX('%arts%', LOWER(industry)) > 0 
              OR PATINDEX('%culture%', LOWER(industry)) > 0 
              OR PATINDEX('%heritage%', LOWER(industry)) > 0 
              OR PATINDEX('%museum%', LOWER(industry)) > 0
            THEN 'Arts, Culture & Heritage'
            WHEN PATINDEX('%automotive%', LOWER(industry)) > 0 
              OR PATINDEX('%auto%', LOWER(industry)) > 0 
              OR PATINDEX('%vehicle%', LOWER(industry)) > 0
            THEN 'Automotive & Transportation Manufacturing'
            WHEN PATINDEX('%bank%', LOWER(industry)) > 0 
              OR PATINDEX('%finance%', LOWER(industry)) > 0 
              OR PATINDEX('%account%', LOWER(industry)) > 0
            THEN 'Banking, Finance & Accounting'
            WHEN PATINDEX('%biotech%', LOWER(industry)) > 0 
              OR PATINDEX('%pharma%', LOWER(industry)) > 0 
              OR PATINDEX('%life sciences%', LOWER(industry)) > 0 
              OR PATINDEX('%biological%', LOWER(industry)) > 0
            THEN 'Biotechnology, Life Sciences & Pharmaceuticals'
            WHEN PATINDEX('%chemical%', LOWER(industry)) > 0 
              OR PATINDEX('%materials%', LOWER(industry)) > 0
            THEN 'Chemicals & Materials Manufacturing'
            WHEN PATINDEX('%consumer good%', LOWER(industry)) > 0 
              OR PATINDEX('%retail%', LOWER(industry)) > 0 
              OR PATINDEX('%cpd%', LOWER(industry)) > 0 
              OR PATINDEX('%product%', LOWER(industry)) > 0
            THEN 'Consumer Goods & Retail'
            WHEN PATINDEX('%education%', LOWER(industry)) > 0 
              OR PATINDEX('%training%', LOWER(industry)) > 0 
              OR PATINDEX('%school%', LOWER(industry)) > 0 
              OR PATINDEX('%university%', LOWER(industry)) > 0 
              OR PATINDEX('%college%', LOWER(industry)) > 0
            THEN 'Education & Training'
            WHEN PATINDEX('%energy%', LOWER(industry)) > 0 
              OR PATINDEX('%oil%', LOWER(industry)) > 0 
              OR PATINDEX('%gas%', LOWER(industry)) > 0 
              OR PATINDEX('%renewable%', LOWER(industry)) > 0 
              OR PATINDEX('%utility%', LOWER(industry)) > 0
            THEN 'Energy & Utilities'
            WHEN PATINDEX('%food%', LOWER(industry)) > 0 
              OR PATINDEX('%beverage%', LOWER(industry)) > 0 
              OR PATINDEX('%restaurant%', LOWER(industry)) > 0 
              OR PATINDEX('%brewery%', LOWER(industry)) > 0 
              OR PATINDEX('%catering%', LOWER(industry)) > 0
            THEN 'Food & Beverage Production and Services'
            WHEN PATINDEX('%government%', LOWER(industry)) > 0 
              OR PATINDEX('%public administration%', LOWER(industry)) > 0 
              OR PATINDEX('%federal%', LOWER(industry)) > 0 
              OR PATINDEX('%state%', LOWER(industry)) > 0 
              OR PATINDEX('%municipal%', LOWER(industry)) > 0
            THEN 'Government & Public Administration'
            WHEN PATINDEX('%health%', LOWER(industry)) > 0 
              OR PATINDEX('%medical%', LOWER(industry)) > 0 
              OR PATINDEX('%hospital%', LOWER(industry)) > 0 
              OR PATINDEX('%clinic%', LOWER(industry)) > 0
            THEN 'Healthcare & Medical Services'
            WHEN PATINDEX('%hospitality%', LOWER(industry)) > 0 
              OR PATINDEX('%tourism%', LOWER(industry)) > 0 
              OR PATINDEX('%hotel%', LOWER(industry)) > 0 
              OR PATINDEX('%resort%', LOWER(industry)) > 0 
              OR PATINDEX('%leisure%', LOWER(industry)) > 0
            THEN 'Hospitality, Tourism & Leisure'
            WHEN PATINDEX('%tech%', LOWER(industry)) > 0 
              OR PATINDEX('%software%', LOWER(industry)) > 0 
              OR PATINDEX('%computing%', LOWER(industry)) > 0 
              OR PATINDEX('%it%', LOWER(industry)) > 0 
              OR PATINDEX('%saas%', LOWER(industry)) > 0
            THEN 'Information Technology & Software'
            WHEN PATINDEX('%legal%', LOWER(industry)) > 0 
              OR PATINDEX('%compliance%', LOWER(industry)) > 0 
              OR PATINDEX('%law%', LOWER(industry)) > 0
            THEN 'Legal & Compliance'
            WHEN PATINDEX('%logistics%', LOWER(industry)) > 0 
              OR PATINDEX('%supply chain%', LOWER(industry)) > 0 
              OR PATINDEX('%transportation%', LOWER(industry)) > 0
            THEN 'Logistics, Supply Chain & Transportation'
            WHEN PATINDEX('%media%', LOWER(industry)) > 0 
              OR PATINDEX('%communication%', LOWER(industry)) > 0 
              OR PATINDEX('%publishing%', LOWER(industry)) > 0 
              OR PATINDEX('%journalism%', LOWER(industry)) > 0
            THEN 'Media & Communications'
            WHEN PATINDEX('%nonprofit%', LOWER(industry)) > 0 
              OR PATINDEX('%social service%', LOWER(industry)) > 0 
              OR PATINDEX('%charity%', LOWER(industry)) > 0
            THEN 'Nonprofit & Social Services'
            WHEN PATINDEX('%consulting%', LOWER(industry)) > 0 
              OR PATINDEX('%professional service%', LOWER(industry)) > 0
            THEN 'Professional Services & Consulting'
            WHEN PATINDEX('%real estate%', LOWER(industry)) > 0 
              OR PATINDEX('%property%', LOWER(industry)) > 0
            THEN 'Real Estate & Property Management'
            WHEN PATINDEX('%science%', LOWER(industry)) > 0 
              OR PATINDEX('%research%', LOWER(industry)) > 0 
              OR PATINDEX('%laboratory%', LOWER(industry)) > 0
            THEN 'Science & Laboratory Research'
            WHEN PATINDEX('%security%', LOWER(industry)) > 0 
              OR PATINDEX('%safety%', LOWER(industry)) > 0 
              OR PATINDEX('%protection%', LOWER(industry)) > 0
            THEN 'Security & Safety Services'
            WHEN PATINDEX('%telecommunication%', LOWER(industry)) > 0 
              OR PATINDEX('%telecom%', LOWER(industry)) > 0
            THEN 'Telecommunications'
            WHEN PATINDEX('%veterinary%', LOWER(industry)) > 0 
              OR PATINDEX('%animal health%', LOWER(industry)) > 0 
              OR PATINDEX('%vet%', LOWER(industry)) > 0
            THEN 'Veterinary & Animal Health'
            WHEN PATINDEX('%waste%', LOWER(industry)) > 0 
              OR PATINDEX('%environment%', LOWER(industry)) > 0 
              OR PATINDEX('%recycling%', LOWER(industry)) > 0
            THEN 'Waste Management & Environmental Services'
            ELSE 'Other'
        END AS industry_group
    FROM dbo.manager_salary
),

salary_clean AS
(
    SELECT
        *,
        CAST(REPLACE(base_annual_compensation, ',', '') AS BIGINT) AS base_annual_compensation_raw,
        CASE
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
            THEN 'OK'
            WHEN CAST(REPLACE(base_annual_compensation, ',', '') AS BIGINT) > 2000000 THEN 'SUSPICIOUS'
            ELSE 'OK'
        END AS base_annual_compensation_flag,
        CAST(COALESCE(additional_compensation, 0) AS INT) AS additional_compensation_cleaned
    FROM industry_clean
),

state_clean AS
(
    SELECT
        *,
        CASE
            WHEN state IS NULL THEN NULL
            WHEN state NOT LIKE '%,%' THEN dbo.ProperCase(state)
            ELSE 'MULTI-STATE'
        END AS state_clean,
        LEN(state) - LEN(REPLACE(state, ',', '')) + 1 AS state_count
    FROM salary_clean
),

country_clean AS
(
    SELECT
        *,
        CASE
            WHEN LOWER(country) LIKE '%united states%' OR LOWER(country) LIKE '%usa%' OR LOWER(country) LIKE '%u.s%' OR country = N'🇺🇸' THEN 'United States'
            WHEN LOWER(country) LIKE '%puerto rico%' THEN 'Puerto Rico'
            WHEN LOWER(country) LIKE '%united kingdom%' OR LOWER(country) LIKE '%uk%' THEN 'United Kingdom'
            WHEN LOWER(country) LIKE '%canada%' THEN 'Canada'
            WHEN LOWER(country) LIKE '%australia%' THEN 'Australia'
            WHEN LOWER(country) LIKE '%new zealand%' OR LOWER(country) LIKE '%nz%' THEN 'New Zealand'
            WHEN LOWER(country) LIKE '%netherlands%' OR LOWER(country) LIKE '%nl%' THEN 'Netherlands'
            WHEN LOWER(country) LIKE '%united arab emirates%' OR LOWER(country) LIKE '%uae%' THEN 'United Arab Emirates'
            WHEN LOWER(country) LIKE '%china%' OR LOWER(country) LIKE '%hong kong%' THEN 'China'
            WHEN LOWER(country) LIKE '%south korea%' OR LOWER(country) LIKE '%korea%' THEN 'South Korea'
            WHEN LOWER(country) LIKE '%philippines%' THEN 'Philippines'
            WHEN LOWER(country) LIKE '%india%' THEN 'India'
            WHEN LOWER(country) LIKE '%japan%' THEN 'Japan'
            ELSE 'Other'
        END AS country_clean
    FROM state_clean
),

city_clean AS
(
    SELECT
        c.*,
        CASE
            WHEN a.city IS NULL THEN NULL
            ELSE UPPER(LEFT(LTRIM(RTRIM(c.city)), 1)) +
                 LOWER(SUBSTRING(LTRIM(RTRIM(c.city)), 2, LEN(LTRIM(RTRIM(c.city)))))
        END AS cleaned_city
    FROM country_clean c
    LEFT JOIN all_cities a
        ON LOWER(LTRIM(RTRIM(c.city))) = LOWER(LTRIM(RTRIM(a.city)))
)

SELECT
    response_timestamp,
    age,
    industry_group AS industry,
    job_title,
    job_title_notes,
    base_annual_compensation_raw AS base_annual_compensation,
    base_annual_compensation_flag,
    additional_compensation_cleaned AS additional_compensation,
    currency,
    currency_other,
    country_clean AS country,
    state_clean AS state,
    cleaned_city AS city,
    total_experience_years,
    field_experience_years,
    education_level,
    gender,
    race_ethnicity
FROM city_clean
ORDER BY NEWID();
